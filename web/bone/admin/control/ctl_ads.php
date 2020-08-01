<?php
if( !defined('PHPBONE') ) exit('Request Error!');
/**
 * 广告管理
 */
class ctl_ads
{
    private $table = '#PB#_ads';


    public function index()
    {
        req::$forms['uptime'] = time();
        $even = req::item('even', 'list');
        $tb   = cls_lurd_control::factory($this->table);
        $tb->form_url = '?ct=ads';
        $tb->set_order_query("order by id desc");
        $reqs['keyword'] = req::item('keyword', '');
        if(!empty($reqs['keyword'])){
            $tb->add_search_condition("`info` like '%{$reqs['keyword']}%'");
            $tb->form_url .= "&keyword=".urlencode($reqs['keyword']);
        }
        
        //保存数据时，先检查key是否重复
        if( preg_match('/save/', $even) )
        {
            $reqs['key'] = req::item('key', '');
            $reqs['show'] = req::item('show', 0);
            $row = db::get_one("Select `id` From `{$this->table}` where `key` = '{$reqs['key']}' ");
            if( !empty($row) && $row['id'] != req::item('id', 0) ) {
                cls_msgbox::show('提示', '广告标识与系统其它标识存在冲突，请更改！', '-1');
                exit();
            }
            $addata = stripslashes($reqs['show']==1 ? req::item('code', '') : req::item('expcode', ''));
            cache::set($GLOBALS['config']['cache']['df_prefix'], 'tpl_func_ads_'.$reqs['key'], $addata);
        }
        
        //删除数据时，移除缓存
        if( $even=='delete' )
        {
            $ids = req::item('id', array());
            $ids_str = preg_replace("/[^0-9,]/", '', join(',', $ids));
            if( $ids_str != '' )
            {
                $rs = db::query("Select `id`,`key` From `#PB#_ads` where `id` in($ids_str) ");
                while( $row = db::fetch_one($rs) ) {
                    cache::del($GLOBALS['config']['cache']['df_prefix'], 'tpl_func_ads_'.$row['key']);
                }
           }
        }
        
        $tb->string_safe = 0;        
        $tb->set_tplfiles('ads.index.tpl', 'ads.add.tpl', 'ads.edit.tpl');
        $tb->listen(req::$forms);
    }

}