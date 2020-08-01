<?php
/**
  * 广告调用
  * @param &$tpl 引用的模板类对象实例
  * @parem $atts 传递的属性参数
  * @return string
  * 模板示例 <{#ads key='mykey'}>
  */
function tpl_function_ads(&$tpl, $atts)
{
    $key = isset($atts['key']) ? $atts['key'] : '';
    if( $key=='' )  return '';
    $data = cache::get($GLOBALS['config']['cache']['df_prefix'], 'tpl_func_ads_'.$key);
    if( $data===false )
    {
        $row = db::get_one("Select * From `#PB#_ads` where `key`='{$key}' ");
        if( empty($row) )  {
            $data = '';
        } else {
            $data = ($row['show'] == 1 ? $row['code'] : $row['expcode']);
        }
        cache::set($GLOBALS['config']['cache']['df_prefix'], 'tpl_func_ads_'.$key, $data);
    }
    return $data;
}