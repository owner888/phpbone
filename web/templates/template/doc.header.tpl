<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title> <{$fields.doc_title}> </title>
<link href='/static/frame/css/doc.base.css' rel='stylesheet' type='text/css' />
</head>
<body>
<div id="main">
    
<div id="header">
 <div class="topbanner">
    <h1><{$config.site_name}></h1>
    <div class='adage'><{#doc_adage}></div>
    <br class='clear'/>
 </div>
 <ul class="topnav">
   <li class='home'><a href='/'>主页</a></li>
   <{catalog cmid='3' parent=0 item='_v'}>
       <li><a href='/catalog-<{$_v.cid}>.html'><{$_v.cname}></a></li>
   <{/catalog}>
   <li><a href='/phpanalysis'>PHP分词系统</a></li>
   <li><a href='/downframe'>提取php开发框架</a></li>
 </ul>
 <div id="position">
    <div class='l'> 位置 &raquo; <a href='/'>主页</a> &raquo; <{$fields.crumbs}> </div>
    <div class='r'> 
        <form action='/route.php' method='GET'>
            <input type='hidden' name='ct' value='doc' />
            <input type='hidden' name='ac' value='search' />
            <input type='text' name='keyword' class='search_inp' value='<{if !empty($reqs.keyword)}><{$reqs.keyword}><{/if}>' />
            <input type="image" name="imageField" src="/static/frame/images/search.gif" />
        </form>
    </div>
    <br class='clear'/>
 </div>
</div><!-- //头部 -->