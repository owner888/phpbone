<?php
if( !defined('PHPBONE') ) exit('Request Error!');
/**
 * 会员后台管理控制器
 *
 * @version $Id$
 */
class ctl_index
{
   
   public $fields = array();
   
   /**
    * 构造函数
    * @return void
    */
    public function __construct()
    {
        cls_msgbox::$tpl = 'cls_msgbox.member.tpl';
        tpl::assign('title', config::get('site_name'));
        $this->fields   = cls_auth::$user->fields;
        tpl::assign('fields', $this->fields);
    }
   
   /**
    * 主入口
    */
    public function index ()
    {
       tpl::display('index.tpl');
       exit();
    }

    /**
     * 会员注册
     * @return void
     */
    public function reg()
    {
        $err_msg = '';
        if( req::$request_mdthod=='POST' )
        {
            try
            {
                $mb = new mod_member();
                $data = req::item('reg');
                if( !pub_validate::user_name($data['user_name']) ) {
                    unset($data['user_name']);
                    throw new Exception("用户名格式不合法！");
                }
                if( !pub_validate::email($data['email']) ) {
                    unset($data['email']);
                    throw new Exception("邮箱格式不合法！");
                }
                if( strlen($data['userpwd']) < 8 ) {
                    throw new Exception("密码长度必须大于或等于8位！");
                }
                if( $data['userpwd'] != $data['userpwd2'] ) {
                    throw new Exception("两次输入密码不一致！");
                }
                $row = $mb->get_infos( $data['user_name'], 'user_name' );
                if( !empty($row) ) {
                    unset($data['user_name']);
                    throw new Exception("用户名已存在，请使用其它用户名！");
                }
                $row = $mb->get_infos( $data['email'], 'email' );
                if( !empty($row) ) {
                    unset($data['email']);
                    throw new Exception("注册使用的邮箱已经存在！");
                }
                $data['pools']      = 'member';
                $data['groups']     = 'member_common';
                $data['userpwd']    = md5( $data['userpwd'] );
                $data['logintime']  = $data['regtime'] = time();
                $data['loginip']    = $data['regip'] = util::get_client_ip();
                $data['sta']     = -1;
                $insert_id = db::insert('bone_member', $data);
                if( $insert_id > 0 ) {
                    cls_msgbox::show('系统消息', '注册成功，请等待审核...', '?ct=index&ac=login', 1000);
                } else {
                    throw new Exception("注册失败，请检测数据合法性！");
                }
            }
            catch(Exception $e)
            {
                tpl::assign('data', $data);
                $err_msg = $e->getMessage();
            }
        }
        tpl::assign('err_msg', $err_msg);
        tpl::display('index.reg.tpl');
        exit();
    }
    
    /**
     * 修改资料
     * @return void
     */
    public function edit_info()
    {
        $err_msg = '';
        if( req::$request_mdthod=='POST' )
        {
            try
            {
                $mb = new mod_member();
                $data = req::item('data');
                if( empty($data['member_id']) || $data['member_id'] != cls_auth::$user->fields['uid'] ) {
                    throw new Exception("资料不合法！");
                }
                if( $data['email'] != $data['old_email'] )
                {
                    if( !pub_validate::email($data['email']) ) {
                        unset($data['email']);
                        throw new Exception("邮箱格式不合法！");
                    }
                    $row = $mb->get_infos( $data['email'], 'email' );
                    if( !empty($row) ) {
                        unset($data['email']);
                        throw new Exception("注册使用的邮箱已经存在！");
                    }
                }
                if( strlen($data['userpwd']) > 0 )
                {
                    if( strlen($data['userpwd']) < 8 ) {
                        throw new Exception("密码长度必须大于或等于8位！");
                    }
                    if( $data['userpwd'] != $data['userpwd2'] ) {
                        throw new Exception("两次输入密码不一致！");
                    }
                    $data['userpwd']    = md5( $data['userpwd'] );
                }
                else
                {
                    unset( $data['userpwd'] );
                }
                //系统不许修改的数据
                $notallows = array('pools', 'groups', 'logintime', 'regtime', 'loginip', 'regip', 'sta');
                foreach($notallows as $k) {
                    if( isset($data[$k]) ) {
                        throw new Exception('修改资料失败，请检测数据合法性!');
                    }
                }
                //保存修改
                if( db::update('bone_member', $data) ) {
                    cls_msgbox::show('系统消息', '成功修改个人资料...', '?ct=index', 1000);
                } else {
                    throw new Exception("修改资料失败，请检测数据合法性！");
                }
            }
            catch(Exception $e)
            {
                $err_msg = $e->getMessage();
            }
        }
        else
        {
            $data = cls_auth::$user->fields;
        }
        tpl::assign('data', $data);
        tpl::assign('err_msg', $err_msg);
        tpl::display('index.edit_info.tpl');
        exit();
    }
    
    /**
     * 验证码图片
     */
    public function validate_image()
    {
        $vdimg = new cls_securimage(4, 100, 24);
        bone::$is_ajax = true;
        $vdimg->show();
    }

   /**
    * 登录界面
    *
    */
    public function login ()
    {
        $login   = req::item('login', '');
        $err_msg = '';
        $gourl = req::item('gourl');
        if(empty($gourl))
        {
            $gourl = '/member';
        }
        if( !empty($login) && is_array($login) )
        {
            try
            {
                 $keeptime = isset($login['save']) ? 86400 : 0;
                 $rs = cls_auth::$user->check_user($login['user_name'], $login['userpwd'], $keeptime);
                 if( $rs==1 )
                 {
                     bone::$auth->auth_user(cls_auth::$user->fields, $keeptime);
                     header('Location:' . $gourl);
                     exit( );
                     //cls_msgbox::show('登录提示', '成功登录！', $gourl, 100);
                     //exit();
                 }
            }
            catch ( Exception $e )
            {
                $err_msg .= $e->getMessage();
            }
        }
        //tpl::assign('source', $login['source']);
        $gourl = str_replace('<', '&lt;', $gourl);
        $gourl = str_replace('>', '&gt;', $gourl);
        tpl::assign('err_msg', $err_msg);
        tpl::assign('login', $login);
        tpl::assign('gourl', $gourl);
        tpl::display('index.login.tpl');
        exit();
    }

   /**
    * 退出
    */
    public function loginout ()
    {
        bone::$auth->logout();
        cls_msgbox::show('注销登录', '成功退出登录！', './', 3000);
        exit();
    }

}
