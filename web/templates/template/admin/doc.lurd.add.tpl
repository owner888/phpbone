<{include file="admin/header.tpl"}>
</head>
<body class="frame-from">
<dl class="tips">
    <dd>
        <strong>当前位置：</strong><a href='?ct=doc'>文档管理</a> &gt;&gt; 录入文档
    </dd>
    <dd class='right'></dd>
</dl>
<form name="form1" action="?" method="POST" enctype="multipart/form-data">
<input type='hidden' name='ct' value='doc' />
<input type='hidden' name='even' value='saveadd' />
<table class="form">
<tr>
  <td class='title'>文档标题：</td>
  <td class='fitem'>
    <input type='text' name='title' id='lurd_title' class='text' value='' style='width:300px' />
    &nbsp; 附加标题：
    <input type='text' name='add_title' id='lurd_add_title' class='text' value='' />
  </td>
</tr>
<tr>
  <td class='title'>文档分类：</td>
  <td class='fitem'>
    <select name='cid'>
    <{#catalog_options cmid='3' selid=0 dfname='--请选择--' }>
    </select>
    &nbsp; 排序：<input type='text' name='sortrank' id='lurd_sortrank' class='text s' value='0' /> <span class='info'>(值大的靠前)</span>
</td>
</tr>
<tr>
  <td class='title' width='120'>文档属性：</td>
  <td class='fitem'>
    <{foreach from="mod_catalog::get_catalogs(4,'ems')" item="_v"}>
    <input type='checkbox' name='flag[]' value='<{$_v.ico}>' /> <{$_v.cname}>(<{$_v.ico}>)
    <{/foreach}>
 </td>
</tr>
<tr>
  <td class='title'>文档状态：</td>
  <td class='fitem'>
    <label><input type='radio' name='sta' value='1' checked>已审核</label>
    <label><input type='radio' name='sta' value='0'>未审核</label>
    <label><input type='radio' name='sta' value='-1'>回收站</label>
  </td>
</tr>
<tr>
  <td class='title'>缩略图：</td>
  <td class='fitem'>
    <input type='text' name='thumb' id='lurd_thumb' class='text' value='' style='width:300px' />
    <script  language='javascript'>
        function GetBoneDlgUpload_lurd_thumb( reurl )
        {
            document.getElementById('lurd_thumb').value = reurl;
            if( document.getElementById('preimg_lurd_thumb') ) {
                document.getElementById('preimg_lurd_thumb').src    = reurl;
                document.getElementById('preimg_lurd_thumb').display = 'block';
            }
        }
        </script>
        <input type='button' name='dlg_btn_1' value='浏览...' cls='dlg_btn' onclick='window.open("../share/fck/dialog/select_images.php?dlg_i=GetBoneDlgUpload_lurd_thumb", "dlg_popUpImgWin", "scrollbars=yes,resizable=yes,statebar=no,width=600,height=400,left=100,top=100");' />
        <br />
        <img src='../../static/frame/admin/images/preview.gif' id='preimg_lurd_thumb' width='80' style='margin-top:10px;display:none' />
</td>
</tr>
<tr>
  <td class='title'>作者：</td>
  <td class='fitem'>
    <input type='text' name='author' id='lurd_author' class='text' value='' />
    &nbsp; 来源：
    <input type='text' name='source' id='lurd_source' class='text' value='' />
  </td>
</tr>
<tr>
  <td class='title'>附加选项：</td>
  <td class='fitem'>
    <label><input type='checkbox' name='doc_auto_keywords' value='1' <{if config::get('doc_auto_keywords')==1}>checked<{/if}>> 自动提取关键字</label>
    <label><input type='checkbox' name='doc_auto_des' value='1'  <{if config::get('doc_auto_des')==1}>checked<{/if}>> 自动提取摘要</label>
    <label><input type='checkbox' name='doc_auto_thumb' value='1'  <{if config::get('doc_auto_thumb')==1}>checked<{/if}>> 自动提取缩略图</label>
    <label><input type='checkbox' name='doc_down_remove' value='1' <{if config::get('doc_down_remove')==1}>checked<{/if}>> 下载远程资源</label>
  </td>
</tr>
<tr>
  <td class='title'>内容：</td>
  <td class='fitem'>
    <{#editor fieldname='body' dfvalue='' toolbar='Default' width='800px' height='400px'}>
  </td>
</tr>
<tr>
  <td class='title'>关键字：</td>
  <td class='fitem'>
    <input type='text' name='keyword' id='lurd_keyword' class='text' value='' style='width:350px;' />
    &nbsp;
    <button type="button" id='get_editor_keyword'>分析编辑器内容关键字</button>
    &nbsp;
    <button type="button" id='get_editor_description'>分析编辑器内容摘要</button>
  </td>
</tr>
<tr>
  <td class='title'>内容摘要：</td>
  <td class='fitem'>
    <textarea name='description' id='lurd_description' class='text' style='width:350px;height:50px'></textarea>
  </td>
</tr>
<tr>
  <td class='title'>发布时间：</td>
  <td class='fitem'>
    <input type='text' name='pubtime' id='lurd_pubtime' class='text' style='width:120px' value='<{date('Y-m-d H:i:s')}>' />
    &nbsp; 总点击：
    <input type='text' name='hits' class='text s' value='0' />
    &nbsp; 周点击：
    <input type='text' name='week_hits' class='text s' value='0' />
  </td>
</tr>
<tr>
  <td colspan='2' align='center' height='60' style='padding-left:200px;'>
      <button type="submit" style='margin-right:50px'>保存</button>
      <button type="reset">重设</button>
  </td>
</tr>
</table>
</form>

</body>
</html>
