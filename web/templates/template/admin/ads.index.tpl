<{include file="admin/header.tpl"}>
<script lang='javascript'>
function show_data(nid)
{
    tb_show('浏览/编辑广告', '?ct=ads&even=edit&id='+ nid +'&TB_iframe=true&height=450&width=700', true);
}
function do_delete()
{
    document.form1.even.value = 'delete';
    var msg = "你确定要删除选中的记录？！";
    msg += "<br/><a href='javascript:tb_remove();'>&lt;&lt;点错了</a> &nbsp;|&nbsp; <a href='javascript:document.form1.submit();'>确定要删除&gt;&gt;</a>";
    tb_showmsg(msg);
}
</script>
</head>
<body class="frame-from">
<div id="contents">
<form name="formsearch" action="?" method="GET">
<input type='hidden' name='ct' value='ads' />
<dl class="search-class">
    <dd>
    关键字：
    <input type='text' name='keyword' style='width:200px;' class='text' value="" />
    <button type='submit'>搜索</button>
    </dd>
</dl>
</form>

<form name="form1" action="?ct=ads" method="POST">
<input type='hidden' name='tb' value='bone_ads' />
<input type="hidden" name="even" value="delete" />
<table class="table-sort table-operate">
  <tr>
    <th style='width:50px'> <a href='javascript:select_checkbox("selckbox");'>选择</a> </th>
    <th style='width:50px'><strong>编号</strong></th>
    <th style='width:100px'><strong>标识</strong></th>
    <th style='width:250px'><strong>调用代码</strong></th>
    <th style='width:200px'><strong>备注</strong></th>
    <th style='width:80px'><strong>是否启用</strong></th>
    <th style='width:150px'><strong>更新时间</strong></th>
    <th></th>
  </tr>
  <{lurd_list item='v'}>
  <tr>
  <td>
    <a href="javascript:show_data('<{$v.id}>');"><img src='../../static/frame/admin/images/icons/text.gif' alt='修改' title='修改' border='0' /></a>
    <input type='checkbox' name='id[]' value='<{$v.id}>' class='selckbox' />
  </td>
  <td> <{$v.id}> </td>
  <td> <{$v.key}> </td>
  <td> <input type="text" class="text" value="&lt{#ads key='<{$v.key}>' }&gt;" style="width:200px;" /> </td>
  <td> <{$v.info}> </td>
  <td> <{if $v.show != 1 }><span style='color:red'>禁用</span><{else}>启用<{/if}> </td>
  <td> <{date('Y-m-d H:i', $v.uptime)}> </td>
    <td></td>
  </tr>
  <{/lurd_list}>
  <tr>
</table>
</form>
</div>

<div id="bottom">
    <div class="fl">
        <button type="button" onclick="tb_show('增加新广告', '?ct=ads&even=add&TB_iframe=true&height=450&width=700', true)">增加记录</button>
        &nbsp;
        <button type="button" onclick="do_delete();">删除选中记录</button>
    </div>
    <div class="pages">
        <{$lurd_pagination}>
    </div>
</div>

</body>
</html>
 