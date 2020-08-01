<?php
if( !defined('PHPBONE') ) exit('Request Error!');
/**
 * 会员管理
 */
class ctl_member
{
    private $table = 'bone_member';
    
    private $base_url = '?ct=member';

    public function index()
    {
        $even = request('even', 'list');
        $tb = cls_lurd_control::factory($this->table);
        $tb->form_url = $this->base_url;
        $reqs['keyword'] = request('keyword', '');
        $reqs['sta'] = request('sta', '2');
        //关键字
        if( !empty($reqs['keyword']) ) {
            $tb->add_search_condition(" LOCATE('{$reqs['keyword']}', `user_name`) > 0  OR LOCATE('{$reqs['keyword']}', `email`) > 0  ");
            $tb->form_url .= "&keyword=".urlencode($reqs['keyword']);
        }
        //状态
        if( $reqs['sta'] < 2 ) {
            $tb->add_search_condition(" `sta` = '{$reqs['sta']}'  ");
            $tb->form_url .= "&sta=".$reqs['sta'];
        }
        tpl::assign('reqs', $reqs);
        $lurd_hooks = array('saveadd_start' => '_member_add', 'saveadd_end' => '_member_add',
                            'saveedit_start' => '_member_edit', 'saveedit_end' => '_member_edit',
                            'delete_start' => '_member_delete', 'delete_end' => '_member_delete',
                            );
        $tb->bind_hooks($this, $lurd_hooks);
        $evens = array('list',  'add',  'saveadd',   'edit', 'saveedit',  'delete');
        $tb->lock_evens( $evens );
        $tb->set_tplfiles('member.lurd.index.tpl', 'member.lurd.add.tpl', 'member.lurd.edit.tpl');
        $tb->listen(req::$forms);
    }
    
    //保存增加模型数据后的处理
    public function _member_add($hookname, &$data, $insert_id)
    {
        if( $hookname=='saveadd_start' )
        {
            //用户名、email合法性
            if( !pub_validate::email($data['email']) )
            {
                cls_msgbox::show('系统提示', "增加会员失败，email格式'{$data['email']}'不合法", "-1", 2000);
            }
            elseif( !pub_validate::user_name($data['user_name']) )
            {
                cls_msgbox::show('系统提示', "增加会员失败，用户名格式'{$data['user_name']}'不合法", "-1", 2000);
            }
            $mb = new mod_member();
            //用户名、email唯一性
            if( $mb->get_infos( $data['user_name'], 'member_id' ) ) {
                cls_msgbox::show('系统提示', '增加会员失败，用户名已经存在', "-1", 2000);
            }
            elseif( $mb->get_infos( $data['email'], 'email' ) ) {
                cls_msgbox::show('系统提示', '增加会员失败，email已经存在', "-1", 2000);
            }
            $data['pools']      = 'member';
            $data['groups']     = 'member_common';
            $data['userpwd']    = md5( $data['userpwd'] );
            $data['logintime']  = $data['regtime'] = time();
            $data['loginip']    = $data['regip'] = '127.0.0.1';
        }
        else
        {
            cls_msgbox::show('系统提示', '成功增加会员管理', "javascript:parent.tb_remove();");
        }
    }
    
    //lurd保存修改数据后的处理
    public function _member_edit($hookname, &$data)
    {
        static $mb = false;
        if( $mb==false ) {
            $mb = new mod_member();
        }
        if( $hookname=='saveedit_start' )
        {
            if( trim($data['userpwd'])=='' ) 
            {
                unset($data['userpwd']);
            } else {
                $data['userpwd'] = md5( $data['userpwd'] );
            }
            if( $data['email']  != $data['old_email'] )
            {
                if( !pub_validate::email($data['email']) ) {
                    cls_msgbox::show('系统提示', "修改会员失败，email格式'{$data['email']}'不合法", "-1", 2000);
                }
                //email唯一性
                $mb = new mod_member();
                if( $mb->get_infos( $data['email'], 'email' ) ) {
                    cls_msgbox::show('系统提示', '修改会员失败，email已经存在', "-1", 2000);
                }
            }
        }
        else
        {
            $infos = array('member_id' => $data['member_id'], 'user_name' => $data['old_user_name'], 'email' => $data['email']);
            $mb->del_all_cache($infos);
            cls_msgbox::show('系统提示', '成功修改会员管理', "javascript:parent.tb_remove();");
        }
    }
    
    //lurd删除数据hooks
    public function _member_delete($hookname, &$data, &$add_data)
    {
        if( $hookname=='delete_start' )
        {
            $mb = new mod_member();
            foreach($data as $k => $member_id)
            {
                $infos = $mb->get_infos( $member_id );
                if( empty($infos) ) {
                    unset($data[$k]);
                } else {
                    $mb->del_all_cache($infos);
                } 
            }
        }
        else
        {
            cls_msgbox::show('系统提示', '成功删除指定的数据', $this->base_url);
        }
    }

   
}

