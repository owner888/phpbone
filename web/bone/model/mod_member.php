<?php
/**
 * 获取普通会员信息的接口
 * (此接口需和权限管理类对接，因此不能删除现在的方法)
 * @since 2013/11/13
 * @author IT柏拉图
 * $Id$ 
 */
class mod_member
{
    //缓存前缀
    public static $cache_prefix = 'mod_member';
    
    //会员数据主表
    private $mod_table = 'bone_member';
    
    //用户信息
    public $uid    = 0;
    public $pools  = '';
    public $groups = '';
    public $pool_name = 'member';
    public $fields = array();
    
    /**
    * 构造函数
    * @return void
    */
    public function __construct( $uid=0 )
    {
        if( $uid != 0 ) {
            $this->fields = $this->get_infos( $uid );
            $this->_set_fields();
        }
    }
    
    /**
     * 获取用户具体信息
     *
     * @return array (如果用户尚未登录，则返回 false )
     *
     */
     public function get_infos( $account, $ftype='member_id', $item = '*' )
     {
        if( empty($account) ) {
            return false;
        }
        //缓存
        $this->fields = $this->get_cache( $account.'_'.$ftype );
        //源数据
        if( $this->fields === false )
        {
            if( $ftype=='member_id' ) {
                $query = "Select * From `{$this->mod_table}` where `member_id`='{$account}' ";
            } else {
                $query = "Select * From `{$this->mod_table}` where `{$ftype}` like '{$account}' ";
            }
            $this->fields = db::get_one($query);
            if( is_array($this->fields) )
            {
                $this->fields['uid'] = $this->fields['member_id'];
                $this->set_cache($account.'_'.$ftype, $this->fields);
                if( $ftype != 'member_id ') {
                    $this->set_cache($this->fields['member_id'].'_member_id', $this->fields);
                }
            }
            else
            {
                return false;
            }
        }
        else
        {
            if( !isset($this->fields['uid']) ) {
                $this->fields['uid'] = $this->fields['member_id'];
            }
        }
        //返回内容
        if( $item=='*' )
        {
            return $this->fields;
        }
        else
        {
            $items = explode(',', $item);
            foreach($items as $k => $v ) {
                $items[ $k ] = $this->fields[$v];
            }
            $restr = join('|', $items);
            return $restr;
        }
     }
     
    /**
     * 获取用户具体信息
     *
     * @return array (如果用户尚未登录，则返回 false )
     *
     */
     public static function get_one( $member_id, $item = '*' )
     {
          $mb = new mod_member();
          return $mb->get_infos( $member_id, 'member_id', $item );
     }
     
    /**
     * 获取用户缓存
     * @return mix
     *
     */
     public function get_cache( $account )
     {
        return cache::get(self::$cache_prefix, $account);
     }
     
    /**
     * 设置用户缓存
     * @return bool
     *
     */
     public function set_cache( $account, &$row )
     {
        cache::set(self::$cache_prefix, $account, $row);
     }
     
    /**
     * 删除用户缓存
     * @return bool
     *
     */
     public function del_cache( $account )
     {
        cache::del(self::$cache_prefix, $account);
     }
     
    /**
     * 删除指定用户信息的所有缓存
     * @param $userinfos 用户信息数组
     * @return void
     */
     public function del_all_cache( &$userinfos )
     {
         $this->del_cache( $userinfos['member_id'].'_member_id' );
         $this->del_cache( $userinfos['user_name'].'_user_name' );
         $this->del_cache( $userinfos['email'].'_email' );
     }
     
     /**
     * 获取用户私有权限(非组权限)
     *
     * @return array (如果用户尚未登录，则返回 false )
     *
     */
     public function get_purviews( )
     {
        return '';
     }
    
    /**
     * 检测用户登录
     * @return int 返回值： 0 无该用户， -1 密码错误 ， 1 登录正常
     */
    public function check_user($account, $loginpwd, $keeptime=86400)
    {
        //检测用户名合法性
        $ftype = 'user_name';
        if( pub_validate::email($account) )
        {
            $ftype = 'email';
        }
        else if( !pub_validate::user_name($account) )
        {
           throw new Exception('会员名格式不合法！');
           return 0;
        }
        //同一ip使用某帐号连续错误次数检测
        if( $this->get_login_error24( $account ) )
        {
            throw new Exception('连续登录失败超过5次，暂时禁止登录！');
            return -5;
        }
        //读取用户数据
        $row = $this->get_infos( $account, $ftype );
        //存在用户数据
        if( is_array($row) )
        {
            $row['accounts'] = $account;
            //密码错误，保存登录记录
            if( $row['userpwd'] != $this->_get_encodepwd($loginpwd) )
            {
                $this->save_login_history($row, -1);
                throw new Exception ('密码错误！');
                return -1;
            }
            //正确生成会话信息
            else
            {
                $row['uid'] = $row['member_id'];
                $this->save_login_history($row, 1);
                cache::set(self::$cache_prefix, $row['uid'], $row);
                $this->fields = $row;
                $this->_set_fields();
                return 1;
            }
        }
        //不存在用户数据时不进行任何操作
        else
        {
            $row['accounts'] = $account;
            $this->save_login_history($row, -1);
            throw new Exception ('用户不存在！');
            return 0;
        }
     }
     
   /**
    * 检测用户24小时内连续输错密码次数是否已经超过
    * @return bool 超过返回true, 正常状态返回false
    */
    public function get_login_error24( $accounts )
    {
        return false;
    }
   
   /**
    * 保存历史登录记录
    */
    public function save_login_history(&$row, $loginsta)
    {
        return true;
    }
    
   /**
    * 会员密码加密方式接口（默认是 md5）
    */
    protected function _get_encodepwd($pwd)
    {
        return md5($pwd);
    }
    
    /**
     *
     * 设置用户池等信息
     *
     * @return void
     *
     */
     private function _set_fields( )
     {
        if( !is_array( $this->fields) ) {
            return false;
        }
        $this->uid    = $this->fields['uid'];
        $this->pools  = $this->fields['pools'];
        $this->groups = $this->fields['groups'];
     }

}