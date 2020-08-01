<?php
if( !defined('PHPBONE') ) exit('Request Error!');
/**
 * 文档管理
 */
class ctl_doc
{
    private $table = 'bone_doc';
    
    private $base_url = '?ct=doc';

    public function index()
    {
        $even = request('even', 'list');
        $reqs['cid']  = request('cid', 0, 'int');
        $reqs['sta']  = request('sta', 1, 'int');
        $reqs['flag'] = request('flag', 0, 'int');
        $tb = cls_lurd_control::factory($this->table);
        if( !empty($reqs['cid']) ) {
            $tb->set_order_query(" order by `sortrank` desc, `doc_id` desc ");
        } else {
            $tb->set_order_query(" order by `doc_id` desc ");
        }
        $tb->set_safe_check( 1 );
        $tb->form_url = $this->base_url;
        $reqs['keyword'] = request('keyword', '');
        if( !empty($reqs['keyword']) )
        {
            $tb->add_search_condition(" (LOCATE('{$reqs['keyword']}', `title`) > 0 OR LOCATE('{$reqs['keyword']}', `keyword`) > 0) ");
            $tb->form_url .= "&keyword=".urlencode($reqs['keyword']);
        }
        if( !empty($reqs['cid']) )
        {
            $tb->add_search_condition(" `cid` = '{$reqs['cid']}' ");
            $tb->form_url .= "&cid=".urlencode($reqs['cid']);
        }
        if( !empty($reqs['flag']) )
        {
            $cats = mod_catalog::get_one(4, $reqs['flag']);
            $flag = $cats['ico'];
            $tb->add_search_condition(" FIND_IN_SET('{$flag}', `flag`) ");
            $tb->form_url .= "&flag=".urlencode($reqs['flag']);
        }
        //状态参数
        if( $reqs['sta']==10 ) {
            $tb->add_search_condition(" `sta` > -1 ");
        } else {
            $tb->add_search_condition(" `sta` = '{$reqs['sta']}' ");
        }
        $tb->form_url .= "&sta=".urlencode($reqs['sta']);
        tpl::assign('reqs', $reqs);
        $lurd_hooks = array('saveadd_start' => '_doc_add', 'saveadd_end' => '_doc_add', 'edit_start' => '_doc_edit',
                            'saveedit_start' => '_doc_add','saveedit_end' => '_doc_edit');
        $tb->lock_evens( array('add', 'saveadd', 'edit', 'saveedit', 'list') );
        $tb->bind_hooks($this, $lurd_hooks);
        $tb->set_tplfiles('doc.lurd.index.tpl', 'doc.lurd.add.tpl', 'doc.lurd.edit.tpl');
        $tb->listen(req::$forms);
    }
    
    //保存增加模型数据后的处理
    public function _doc_add($hookname, &$data, $insert_id)
    {
        if($hookname=='saveadd_start' || $hookname=='saveedit_start')
        {
            //发表文档时，关键字和摘要为空才自动提取
            if( $hookname=='saveadd_start' ) {
                $auto_keywords = $data['keyword']=='' ? request('doc_auto_keywords', 0) : 0;
                $auto_des      = $data['description']=='' ? request('doc_auto_des', 0) : 0;
            }
            //修改文档时，不管任何情况，勾了选项就自动提取
            else
            {
                $auto_keywords = request('doc_auto_keywords', 0);
                $auto_des      = request('doc_auto_des', 0);
            }
            $auto_set = array('auto_keywords' => $auto_keywords,
                              'auto_des' => $auto_des,
                              'auto_thumb' => request('doc_auto_thumb', 0),
                              'down_remove' => request('doc_down_remove', 0) );
            $rearr = mod_doc_tool::analyse_body($data['body'], $auto_set, $data['thumb'], $data['title']);
            foreach($rearr as $k => $v) {
                if($v != '')  $data[ $k ] = $v;
            }
            $data['pubtime']  = util::cn_strtotime($data['pubtime']);
            $data['addtime']  = $data['uptime'] = time();
            $data['admin_id'] = $data['edit_admin'] = cls_auth::$user->fields['uid'];
            //编辑时不允许修改录入时间和录入员
            if( $hookname=='saveedit_start' ) {
                unset( $data['addtime'] );
                unset( $data['admin_id'] );
            }
        }
        elseif($hookname=='saveadd_end')
        {
            $add_data = array('doc_id' => $insert_id, 'cid' => $data['cid'], 'body' => $data['body'] );
            db::insert($this->table.'_body', $add_data, 1);
            cls_msgbox::show('系统提示', '成功增加文档', $this->base_url."&cid={$data['cid']}");
        }
    }
    
    //lurd保存修改数据后的处理
    public function _doc_edit($hookname, &$data, $add_data='')
    {
        if( $hookname=='edit_start' )
        {
            //读取副表数据
            $adddata = mod_doc::get_body( $data['doc_id'], $data['cid']);
            foreach($adddata as $k => $v) {
                if( !isset($data[$k]) ) {
                    $data[$k]  = $v;
                }
            }
        }
        else if( $hookname=='saveedit_end')
        {
            //更新副表数据
            $update_data = array('doc_id' => $data['doc_id'], 'cid' => $data['cid'], 'body' => $data['body'] );
            if( !empty($data['doc_id']) ) {
                db::update($this->table.'_body', $update_data, '', 1);
            }
            mod_doc::cache_del($data['doc_id']);
            cls_msgbox::show('系统提示', '成功修改文档', $this->base_url."&cid={$data['cid']}", 1000);
        }
    }
    
   /**
    * 删除文档
    */
    public function doc_del()
    {
        $cid = request('cid', 0, 'int');
        $sta = request('sta', 1, 'int');
        $ids = request('doc_id');
        if( is_array($ids) )
        {
            $n = 0;
            if( $sta != - 1)
            {
                foreach($ids as $id) {
                    db::query("UPDATE `{$this->table}` SET `sta`='-1' WHERE `doc_id`='{$id}' LIMIT 1");
                }
                cls_msgbox::show('系统提示', '成功把选中的文件移动回收站', $this->base_url."&sta={$sta}&cid={$cid}", 500);
            }
            else
            {
                foreach($ids as $id) {
                    mod_doc::del_one( $id );
                    $n++;
                }
                cls_msgbox::show('系统提示', "成功删除 {$n} 个选中的文档！", $this->base_url."&sta={$sta}&cid={$cid}", 500);
            }
        }
        else
        {
            cls_msgbox::show('系统提示', '你没选中任何需要操作的文档', $this->base_url."&sta={$sta}&cid={$cid}", 1000);
        }
    }
    
   /**
    * 还原文档
    */
    public function un_del()
    {
        $cid = request('cid', 0, 'int');
        $sta = request('sta', 1, 'int');
        $ids = request('doc_id');
        if( is_array($ids) )
        {
            $n = 0;
            foreach($ids as $id) {
                db::query("UPDATE `{$this->table}` SET `sta`='1' WHERE `doc_id`='{$id}' LIMIT 1");
            }
            cls_msgbox::show('系统提示', '成功把选中的文件恢复为正常状态', $this->base_url."&sta={$sta}&cid={$cid}", 500);
        }
        else
        {
            cls_msgbox::show('系统提示', '你没选中任何需要操作的文档', $this->base_url."&sta={$sta}&cid={$cid}", 1000);
        }
    }
    
   /**
    * 文档批量排序
    */
    public function doc_sort()
    {
        $cid = request('cid', 0, 'int');
        $sta = request('sta', 1, 'int');
        $sortrank = request('sortrank');
        $old_sortrank = request('old_sortrank');
        if( !empty($sortrank) )
        {
            foreach($sortrank as $id => $val) {
                if( $old_sortrank[$id] != $val ) {
                    db::query("UPDATE `{$this->table}` SET `sortrank`='{$val}' WHERE `doc_id`='{$id}' LIMIT 1");
                }
            }
        }
        cls_msgbox::show('系统提示', '更新成功排序', $this->base_url."&sta={$sta}&cid={$cid}", 500);
    }

   
}

