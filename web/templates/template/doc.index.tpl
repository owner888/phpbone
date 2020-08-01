<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title> <{$fields.doc_title}>--php框架,php网站开发框架,php开源框架,php快速开发框架 </title>
<link href='static/frame/css/doc.index.css' rel='stylesheet' type='text/css' />
<meta name="Keywords" content="phpbone,php框架,php网站开发框架,php开源框架,php快速开发框架" />
<meta name="Description" content="PHPBONE开发框架并不传统意义的php开发框架，而是本身已经带有开发时最常用的模块，面向php开发人员的“准系统”，以“简单、安全、高效、规范”为原则，是一个真正面向高性能网站的快速开发框架！" />
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
    <div class='l'> <{$config.site_name}>  &raquo; </div>
    <div class='r'> 
        <form action='route.php' method='GET'>
            <input type='hidden' name='ct' value='doc' />
            <input type='hidden' name='ac' value='search' />
            <input type='text' name='keyword' class='search_inp' value='' />
            <input type="image" name="imageField" src="static/frame/images/search.gif" />
        </form>
    </div>
    <br class='clear'/>
 </div>
</div><!-- //头部 -->
 
<table border="0" cellspacing="0" cellpadding="0" id="content">
 <tr>
   <td>
    <div id="body">

<!--  //PHPBONE框架及PHP开发规范 -->
<p align='center'><img src='uploads/frame/f.gif'/></p>
<p>
    &nbsp;&nbsp;<strong> 一、PHPBONE框架简介 </strong><br />
<pre style="padding-left:10px;line-height:180%;font-size:13px;">
        PHPBONE开发框架并不传统意义的php开发框架，而是本身已经带有开发时最常用的模块，面向php开发人员的“准系统”，
    框架以“简单、安全、高效、规范”为原则，是一个真正面向高性能网站的快速开发框架，框架主要特点如下：
        1、根据应用池设定多个入口，这样的好处是即使不对项目的管理后台进行分离，也可以任意重命名管理目录，从而更简单的实
    现管理分离，更容易实现模块化的开发思想，此外各模块之间不用过度关连，在必要场景下，更容易对不同模块设置不同子域名访问。
        2、用户请求参数(GET、POST、FILE等)统一使用req类进行管理，这样更利于实现从底层去进行安全控制，也利于路由器、权限
    控制系统的实现。
        3、框架以简洁为原则，核心设定以PHP+MySQL应用作为主要开发场景，结构也十分清晰简洁，不像其它某些框架过于讲究大而全，
    在可能99.9%派不上用场的所谓数据驱动之类的代码上浪费精力，此外框架作为附带有开发者最常用的功能的“准系统”，也允许用户
    提取框架时自行选择必要的模块，这样有利于开发时根据项目大小或差异使用不同的框架核心。
        4、框架内置LURD控制器的模块，替代传统的ORM库，在开发简易数据管理时，它能极大的提高开发效率。
</pre>
</p>

<p>
    &nbsp;&nbsp;<strong> 二、PHP编码规范重点说明 </strong><br />
<pre style="padding-left:10px;line-height:180%;font-size:13px;">
     <b>开发时以敏捷为原则，但基本的规范必须遵守，程序要注重可读性，不要有太多“个性化”的代码！</b>
     为了方便更快入门，这里提取重点说明如下：
     <b>1、缩进用4个空格代替制表符，以便于不同环境下有更好的兼容性。</b>
     <b>2、大括号里面内容较少时，可以不换行，但较长时建议换行，这样可以保持代码的阅读简易性。</b>
     如：
     if() {
        $xxx = 'xxx';
     }
     if()
     {
        ...
        ...
        ...
     }
     function test()
     {
       ...
     }
     <b>3、变量、成员函数、类名、表名、字段名等命名用下划线分隔法，并且全用小写字母。</b>
     如：open_account()、$acc_users
     <b>4、文件命名规范：</b>
     lib_ 函数库              （存放在 /bone/core/library，目前除模板插件外的地方不建议使用函数，常用的一些功能，
                                可以整合成某个静态类，默认 util 类 ）
     cls_ 框架基础类文件      （存放在 /bone/core/library 通常是动态类）
     pub_ 项目公共接口类     （存放在 /bone/core/library  通常是静态类）
     mod_ 应用目录私有模型类 （存放在 /bone/model）
     ctl_ 应用目录控制器类   （存放在 appdir/control）
     <b>5、模板文件命名方式为：appdir/(ctl name).(action name).tpl</b>
     其中 ct=index 的 index 可以省缺，如：
     templates/template/index.tpl
     templates/template/admin/index.index.tpl
     templates/template/admin/archives.add.tpl
     <b>6、开发时使用严格模式，重点需要注意下面几点： </b>
     (1)、严禁变量没有赋值就直接使用；
     (2)、字符串中使用变量应该用{}括起来，如：$str = "你是：{$type}？";
     (3)、对于没有内部使用变量的字符串尽量用 '' 表示，表示数组元素的字符串，必须用 '' 括起来。
          如： $str = '我是普通字符串！';   $names['tom'] = '汤姆';
     <b>7、关于源码编码问题需特别注意的是：</b> 由于php无法处理带bom的源码，所以务必把源码
     保存为utf-8无bom的格式，以免输出多余的头导致出错！ 
     <b>8、关于在控制器使用私有方法</b> 原则上，控制器类是不放私有逻辑的，但有时为了简便起见，也允许放不
     公用的简单逻辑代码，这种代码函数名用 _ 开头，如：function _test_username(){ ... }，建议模型类里的
     私有方法也用这种方式书写，这样用不同编辑器读代码时都能更简便的识别整个类的情况 。 
</pre>
</p>

<p>
    &nbsp;&nbsp;<strong> 三、新建项目文件结构说明 </strong><br />
<pre style="padding-left:10px;line-height:180%;font-size:13px;">
    以下文件夹是在SVN仓库内：如 www.demo.xxx.com 文件夹内
    
    /res/design   效果图等设计源文件存放目录
    ------------------------------------------------------
    /res/doc      需求文档、项目接口说明文档、数据库文档等
    ------------------------------------------------------
    /res/html     切好的html模板
    ------------------------------------------------------
    /web      网站目录
    ------------------------------------------------------
    /web/bone                           框架程序主目录
       /web/bone/admin                 后台管理文件存放目录
            /web/bone/admin/control     admin应用控制器存放目录
       /web/oneb/model                  模型类存放目录
       /web/bone/config                 配置文件存放目录       
       /web/bone/crond                  计划任务
       /web/bone/share                  共享静态数据（IP库，字体，词典，编辑器等）
       /web/bone/core                   框架核心类库目录
           /web/bone/core/library             类文件和函数库文件存放目录
           /web/bone/core/library/debug       调试函数及相关接口文件
           /web/bone/core/library/plugins     自定义模板插件
    /web/bone/control                            根应用控制器文件存放目录
    /web/bone/data                               缓存文件目录
        /web/bone/data/log                     日志文件存放目录
        /web/bone/data/cache                   缓存文件存放目录
    /web/templates                       模板文件存放目录
        /web/template/template           template 目录
        /web/template/cache              cache目录
        /web/template/compile            compile目录
    /web/static                          静态文件目录
        /web/static/images               图片样式文件存放目录
        /web/static/js                   Js文件存放目录
        /web/static/css                  css文件存放目录
        /web/static/frame                框架自带资源模块图片、样式、js文件存放目录
    /web/apps                            小应用目录
    /web/member                          前台会员模块
    /web/uploads                         默认上传目录
    
</pre>
</p>
        
    <br class='clear'/>
    </div><!-- //列表 -->
    
    <{include file='doc.side_index.tpl'}>
  
  <td>
 </tr>
</table><!-- //content -->
 
<div id="footer">
  <div class='friendlink'>
  友情链接：
  <{friendlink position='2' limit='20' item='_v'}>
  <a href='<{$_v.url}>' target='_blank'><{$_v.webname}></a> 
  <{/friendlink}>
  </div>
   站长Email：2500875#qq.com  Power by <{bone::get_ver()}>
</div>

</div>
</body>
</html>