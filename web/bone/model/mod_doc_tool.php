<?php
if( !defined('PHPBONE') ) exit('Request Error!');
/**
 * 文档特殊内容处理
 */
class mod_doc_tool
{
    
    //分词引擎
    private static $_pa = null;

   /**
    * 综合分析文档的html
    * @param $html
    * @param $auto_set array($auto_keywords, $auto_des, $auto_thumb, $down_remove)
    * @param $thumb 原来的$thumb字段内容（不为空时才提取）
    * @return array('keyword' => '', 'des' => '', 'thumb' => '')
    */
   public static function analyse_body(&$html, $auto_set, $thumb = '', $title = '')
   {
       extract($auto_set, EXTR_OVERWRITE);
       $html = stripslashes( $html );
       $rearr = array('keyword' => '', 'des' => '', 'thumb' => '');
       if( $auto_keywords || $auto_des) {
           $text = self::html2text( $html );
           if( $auto_keywords ) {
                //标题重复三次，以提升权重
                $rearr['keyword'] = addslashes( self::auto_keywords( $title.','.$title.','.$title.','.$text ) );
           }
           if( $auto_des ) {
                $rearr['description'] = addslashes( self::auto_des( $text ) );
           }
       }
       if( $down_remove ) {
            self::auto_down_remove( $html );
       }
       if( $auto_thumb ) {
           $rearr['thumb'] = ($thumb=='' ? self::auto_thumb( $html ) : $thumb);
       }
       $html = addslashes( $html );
       return $rearr;
   }
   
   /**
    * 自动摘要
    * @param $text
    * @param $len  长度（为0时使用系统默认设置）
    * @return string
    */
    public static function auto_des( $text, $len=0 )
    {
         $len = $len==0 ? config::get('doc_auto_des_len') : $len;
         $restr = trim(util::utf8_substr_num($text, $len));
         return $restr;
    }
    
   /**
    * 自动提取关键字
    * @param $text
    * @param $num  提取个数
    * @return string
    */
    public static function auto_keywords( $text, $num=8 )
    {
         if( !self::$_pa ) {
            self::$_pa = new cls_analysis();
         }
         self::$_pa->SetSource($text);
         self::$_pa->StartAnalysis();
         $okwords = self::$_pa->GetFinallyKeywords( $num );
         return $okwords;
    }
    
   /**
    * 自动抓取远程图片
    * @param $html
    * @return void
    */
    public static function auto_down_remove( &$html )
    {
        
    }
    
   /**
    * 自动提取缩略图
    * @param $html
    * @return string
    */
    public static function auto_thumb( &$html )
    {
        $thumb = '';
        return $thumb;
    }
    
   /**
    * html转换为text
    * @param $str
    * @return string
    */
    public static function html2text( $str )
    {
	    $str = preg_replace("/<sty(.*)\\/style>|<scr(.*)\\/script>|<!--(.*)-->/isU", '', $str);
	    $alltext = '';
	    $start = 1;
	    for($i=0; $i < strlen($str); $i++)
	    {
		    if($start == 0 && $str[$i] == '>')
		    {
			    $start = 1;
		    }
		    else if($start == 1)
		    {
			    if($str[$i] == '<') {
				    $start = 0;
				    $alltext .= ' ';
			    }
			    else if(ord($str[$i]) > 31)
			    {
				    $alltext .= $str[$i];
			    }
		    }
	    }
	    $alltext = str_replace('　',' ',$alltext);
	    $alltext = preg_replace("/&([^;&]*)(;|&)/", '', $alltext);
	    $alltext = preg_replace("/[\s]+/s", ' ', $alltext);
	    $alltext = preg_replace("/[\"']/", '`', $alltext);
	    return $alltext;
    }
   
}

