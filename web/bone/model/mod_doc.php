<?php
if( !defined('PHPBONE') ) exit('Request Error!');
/**
 * 文档管理 模型类
 */
class mod_doc
{
    //模型类主操作表
    protected static $mod_table = 'bone_doc';
    
    //模型类缓存前缀
    protected static $cache_prefix = 'bone_doc';
    
    //缓存时间
    protected static $cache_time = 86400;

   /**
    * 根据主键获取单个记录
    * @param $pri_key 主键或唯一类型索引字段值
    * @return array
    */
    public static function get_one( $pri_key )
    {
        $data = cache::get(self::$cache_prefix, $pri_key);
        if( $data !== false ) {
            return $data;
        }
        $sql = "Select * From `".self::$mod_table."` where `doc_id` = '{$pri_key}' ";
        $data = db::get_one( $sql );
        if( !empty($data) )
        {
            //读取副表的数据
            $adddata = self::get_body( $pri_key, $data['cid'] );
            foreach($adddata as $k => $v)
            {
                if( !isset($data[$k]) ) {
                    $data[$k]  = $v;
                }
            }
            unset( $adddata );
            cache::set(self::$cache_prefix, $pri_key, $data, self::$cache_time);
        }
        return $data;
    }
    
   /**
    * 读取附加表内容
    */
    public static function get_body( $pri_key, $cid )
    {
        $sql = "Select * From `".self::$mod_table."_body` where `doc_id` = '{$pri_key}' ";
        $data = db::get_one( $sql );
        if( empty($data) ) {
            $data = array('doc_id' => $pri_key, 'cid' => $cid, 'body' => '' );
            db::insert(self::$mod_table.'_body', $data);
        }
        return $data;
    }
    
   /**
    * 删除指定文档
    * @param $doc_id
    * @return bool
    */
    public static function del_one( $doc_id )
    {
        db::query("Delete From `".self::$mod_table."` where `doc_id` = '{$doc_id}' ");
        db::query("Delete From `".self::$mod_table."_body` where `doc_id` = '{$doc_id}' ");
        cache::del(self::$cache_prefix, $doc_id);
        return true;
    }
    
   /**
    * 获取指定条件的数据
    * @param $atts          查询条件
    * @param $limit         记录限定数
    * @param $orderby       排序字SQL
    * @param $is_pagelist   是否分页列表的请求（非分页列表请求会进行缓存，否则不缓存）
    * @return array
    */
    public static function get_datas($atts, $limit='10', $orderby='', $is_pagelist=false)
    {
        $data = false;
        $where_sql = '';
        $cons = self::_get_search_con( $atts );
        if( !empty($cons) ) {
            $where_sql = ' where '.join(' AND ', $cons);
        }
        if( $orderby=='' ) {
            $orderby = " order by `sortrank` desc, `doc_id` desc ";
        }
        if( empty($limit) ) {
            $limit = 10;
        }
        $sql = "Select * From `".self::$mod_table."` {$where_sql} {$orderby} limit {$limit}";
        if( !$is_pagelist ) {
            $data = cache::get(self::$cache_prefix, $sql);
            if( $data !== false )  return $data;
        }
        $rs = db::query( $sql );
        while( $row = db::fetch_one($rs) )
        {
            $data[] = $row;
        }
        if( !$is_pagelist && !empty($data) ) {
            cache::set(self::$cache_prefix, $sql, $data, self::$cache_time);
        }
        return is_array($data) ? $data : array();
    }
    
   /**
    * 获取分页数据
    * @param $url        前缀网址(不包含 pageno=xx )
    * @param $atts       查询条件
    * @param $orderby    排序字SQL
    * @param $cur_page   当前页
    * @param $pagesize   分页大小
    * @param $index_url  第一页的url
    * @return array
    */
    public static function get_page_datas($url, $atts, $orderby='', $cur_page = 1, $pagesize=20, $index_url='', $count_num = -1)
    {
        $data = array();
        $pagination_config = array('count_num' => 0, 'pagesize' => $pagesize, 'pagename' => 'pageno',
                        '          cur_page' => 1, 'css_class' => 'lurd-pager');
        //分页列表获取
        if( empty($cur_page) ) $cur_page  = 1;
        $pagination_config['cur_page']    = $cur_page;
        if( $count_num == -1) {
            $pagination_config['count_num']   = self::get_count( $atts );
        } else {
            $pagination_config['count_num']   = $count_num;
        }
        $data['count_num']   = $pagination_config['count_num'];
        $data['count_page']  = ceil( $pagination_config['count_num']/ $pagesize);
        $data['pagination']  = db::pagination($url , $pagination_config, $index_url);
        
        //分页数据
        $start = ($cur_page - 1) * $pagesize;
        $limit = " {$start}, {$pagesize} ";
        $data['data'] = self::get_datas($atts, $limit, $orderby, true);
        
        return $data;
    }
    
   /**
    * 获取指定查询条件的记录总数
    * @param $atts   查询条件
    * @return count
    */
    public static function get_count( $atts )
    {
        $where_sql = '';
        $cons = self::_get_search_con( $atts );
        if( !empty($cons) ) {
            $where_sql = ' where '.join(' AND ', $cons);
        }
        $row = db::get_one("Select count(*) as dd From `".self::$mod_table."` {$where_sql} ");
        return $row['dd'];
    }
    
    /**
     * 返回查询条件
     * @param $atts
     * @return array
     */
     protected static function _get_search_con( $atts )
     {
         $cons = array();
         if( !empty($atts['cid'])  ) {
            $cons[] = " `cid` in({$atts['cid']}) ";
         }
         if( !empty($atts['flag'])  )
         {
            $fs = explode(',', $atts['flag']);
            foreach($fs as $f) {
                if( $f=='' ) continue;
                $f = trim( $f );
                $cons[] = "  FIND_IN_SET('{$f}', `flag`) ";
            }
         }
         if( !empty($atts['subday'])  ) {
            $starttime = time() - ($atts['subday'] * 86400);
            $cons[] = " `addtime` > {$starttime} ";
         }
         if( !empty($atts['keyword'])  )
         {
            $kws = explode(' ', $atts['keyword']);
            foreach( $kws as $kw ) {
                $kw = trim( $kw );
                if( trim($kw)=='' || (strlen($kw)==1 && !preg_match("/[^\w\*\#\$\@-]/", $kw))  ) continue;
                $kw = addslashes( $kw );
                $cons[] = " (LOCATE('{$kw}', `title`) > 0 OR LOCATE('{$kw}', `keyword`) > 0) ";
            }
         }
         if( !empty($atts['author'])  ) {
            $atts['author'] = addslashes( $atts['author'] );
            $cons[] = " `author` like '{$atts['author']}' ";
         }
         $cons[] = " `sta` = 1 ";
         return $cons;
     }
     
    /**
     * 删除单个记录的缓存
     * @param $pri_key
     * @return array
     */
     public static function cache_del( $pri_key )
     {
        return cache::del(self::$cache_prefix, $pri_key);
     }
     
    /**
     * 增加点击数
     * @param $pri_key
     * @return array
     */
     public static function up_hits( $pri_key )
     {
        db::query("Update LOW_PRIORITY `".self::$mod_table."` set `hits` = `hits` + 1 where `doc_id` = '{$pri_key}' ");
     }
}

