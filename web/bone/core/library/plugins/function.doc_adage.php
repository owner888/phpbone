<?php
/**
  * 随机格言
  *
  * @param &$tpl 引用的模板类对象实例
  * @parem $atts 传递的属性参数
  *
  * @return string
  *
  */
function tpl_function_doc_adage(&$tpl, $atts)
{
     $ds = file(PATH_SHARE.'/global_adage.txt');
     $n = mt_rand(0, count($ds)-1);
     return "<script language='javascript'>document.write('".trim($ds[$n])."');</script>\r\n";
}
