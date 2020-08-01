<?php
if( !defined('PHPBONE') ) exit('Request Error!');
/**
 * 简易文档管理控制器
 *
 * @version $id
 */
class ctl_doc
{

   public $fields = array();
   
   /**
    * 构造函数
    * @return void
    */
    public function __construct()
    {
        $this->fields = array(
            'doc_title' => config::get('site_name'),
            'doc_keyword' => config::get('site_keyword'),
            'doc_description' => config::get('site_description'),
            'doc_tj' => config::get('site_tj'),
            'crumbs' => '',
        );
        cls_msgbox::$tpl = 'cls_msgbox.member.tpl';
    }
   
   /**
    * 主页
    */
    public function index( $is_get = false)
    {
        tpl::assign('fields', $this->fields);
        if( $is_get ) {
            return tpl::fetch( 'doc.index.tpl' );
        } else {
            tpl::display('doc.index.tpl');
        }
    }
    
   /**
    * 分类列表
    */
    public function catalog( $cid=0, $pageno = 0, $page_size= 20, $url = '', $url_index = '', $count_num = -1)
    {
        $skip_error = false;
        if( empty($cid) ) {
            $reqs['cid'] = req::item('cid', 0, 'int');
            $pageno      = req::item('pageno', 1, 'int');
            $url = '/catalog-'.$reqs['cid'].'-%s.html';
            $url_index = '/catalog-'.$reqs['cid'].'.html';
        } else {
            $skip_error  = true;
            $reqs['cid'] = $cid;
            $pageno      = $pageno;
        }
        if( empty($reqs['cid']) ) {
            cls_msgbox::show('系统消息', '分类参数错误[1]！', '');
        }
        $this->fields['cats'] = mod_catalog::get_one(3, $reqs['cid']);
        if( empty($this->fields['cats']) )
        {
            if( $skip_error ) {
                echo "获取不到栏目:{$cid} 数据";
                return false;
            } else {
                cls_msgbox::show('系统消息', '请求错误[2]！', '');
            }
        }
        $this->fields['crumbs'] = $this->fields['cats']['cname'];
        $this->fields['doc_title'] = $this->fields['cats']['cname'].'--'.$this->fields['doc_title'];
        $data = mod_doc::get_page_datas($url, $reqs, '', $pageno,  $page_size, $url_index, $count_num);
        tpl::assign('reqs', $reqs);
        tpl::assign('fields', $this->fields);
        tpl::assign('data', $data);
        if( $skip_error ) {
            return array($data['count_page'], tpl::fetch('doc.catalog.tpl'), $data['count_num']);
        } else {
            tpl::display('doc.catalog.tpl');
        }
    }
    
   /**
    * 显示文档
    */
    public function show( $doc_id = 0 )
    {
        if( empty($doc_id) ) {
            $reqs['doc_id'] = req::item('doc_id', 0, 'int');
        } else {
            $reqs['doc_id'] = $doc_id;
        }
        if( empty($reqs['doc_id']) ) {
            cls_msgbox::show('系统消息', '请求错误[1]！', '');
        }
        $fields = mod_doc::get_one( $reqs['doc_id'] );
        if( empty($fields) ) {
            cls_msgbox::show('系统消息', '请求错误[2]！', '');
        }
        $this->fields['cats'] = mod_catalog::get_one(3, $fields['cid']);
        $rs = array_merge($this->fields, $fields);
        unset( $fields );
        unset( $this->fields );
        $rs['crumbs'] = "<a href='/catalog-{$rs['cid']}.html'>{$rs['cats']['cname']}</a> &raquo; {$rs['title']}";
        $rs['doc_title'] = $rs['title'].'--'.$rs['doc_title'];
        tpl::assign('fields', $rs);
        if( empty($doc_id) ) {
            mod_doc::up_hits( $reqs['doc_id'] );
            tpl::display('doc.show.tpl');
        } else {
            return tpl::fetch('doc.show.tpl');
        }
    }
    
   /**
    * 搜索
    */
    public function search()
    {
        $reqs['keyword'] = req::item('keyword', '', 'keyword');
        $pageno = req::item('pageno', 1, 'int');
        if( empty($reqs['keyword']) ) {
            cls_msgbox::show('系统消息', '请求错误[1]！', '');
        }
        $this->fields['crumbs'] = "搜索：<span style='color:red'>{$reqs['keyword']}</span>";
        $this->fields['doc_title'] = $reqs['keyword'].'--'.$this->fields['doc_title'];
        $url = 'route.php?ac=search&keyword='.urlencode( $reqs['keyword'] );
        $pa = new cls_analysis();
        $pa->SetSource( $reqs['keyword'] );
        $pa->StartAnalysis();
        $atts['keyword'] = $pa->GetFinallyResult();
        $data = mod_doc::get_page_datas($url, $atts, '', $pageno,  20);
        tpl::assign('reqs', $reqs);
        tpl::assign('fields', $this->fields);
        tpl::assign('data', $data);
        tpl::display('doc.search.tpl');
    }
    
}
