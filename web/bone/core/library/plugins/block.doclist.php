<?php
/**
 * 文档列表
 * 没指定排序条件的情况下默认排序为 "orderby `sortrank` desc, `doc_id` desc"
 * limit 文档条数，允许使用 limit = '10, 10' 这样的位移
 * <{doclist limit='' cid='' flag='' subday='多少天以内录入的文档' keyword='' author='' orderby='' item='_v' key='_k' }>
 *    <{$_v.name}>--<{$_v.cid}>...<br />
 * <{/doclist}>
 * @return array
 */
function tpl_block_doclist(&$tpl, $atts)
{
    $limit = isset($atts['limit']) ? $atts['limit'] : 10;
    $orderby = isset($atts['orderby']) ? $atts['orderby'] : '';
    unset($atts['limit']);
    unset($atts['orderby']);
    return mod_doc::get_datas($atts, $limit, $orderby, false);
}
