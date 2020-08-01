<{include file="admin/header.tpl"}>
<script lang='javascript'>
function add_data(nid)
{
    location = '?ct=doc&even=add&tb=bone_doc';
}
function show_data(nid)
{
    location = '?ct=doc&even=edit&doc_id='+ nid;
}
function do_delete(sta)
{
    document.form1.ac.value = 'doc_del';
    if( sta==1 ) {
        var msg = "你确定要彻底删除选中的文档？";
    } else {
        var msg = "你确定要把选中的文档移动回收站？";
    }
    msg += "<br/><a href='javascript:tb_remove2();'>&lt;&lt;点错了</a> &nbsp;|&nbsp; <a href='javascript:document.form1.submit();'>确定操作&gt;&gt;</a>";
    tb_showmsg(msg);
}
function un_del()
{
    document.form1.ac.value   = 'un_del';
    document.form1.submit();
}
function up_sort()
{
    document.form1.ac.value   = 'doc_sort';
    document.form1.submit();
}
</script>
</head>
<body class="frame-from">
<div id="contents">
<form name="formsearch" action="?" method="GET">
<input type='hidden' name='ct' value='doc'>
<dl class="search-class">
    <dd>
    关键字：
    <input type='text' name='keyword' style='width:200px;' class='text' value="<{if !empty($reqs.keyword)}><{$reqs.keyword}><{/if}>" />
    <select name='cid'>
    <{#catalog_options cmid='3' selid=$reqs.cid dfname='文档栏目' }>
    </select>
    &nbsp;
    <select name='flag'>
    <{#catalog_options cmid='4' selid=$reqs.flag dfname='文档属性' }>
    </select>
    &nbsp;
    <select name='sta'>
    <option value='10' <{if $reqs.sta==10}>selected<{/if}>>状态</option>
    <option value='1'  <{if $reqs.sta==1}>selected<{/if}>>已审核</option>
    <option value='0'  <{if $reqs.sta==0}>selected<{/if}>>未审核</option>
    <option value='-1' <{if $reqs.sta==-1}>selected<{/if}>>回收站</option>
    </select>
    &nbsp;
    <button type='submit'>搜索</button>
    </dd>
</dl>
</form>

<form name="form1" action="?" method="POST">
<input type="hidden" name="ct" value="doc" />
<input type="hidden" name="ac" value="index" />
<input type='hidden' name='sta' value='<{$reqs.sta}>'>
<table class="table-sort table-operate">
  <tr>
    <th width='60'>
        <label for='id[]'><input type='checkbox' name='id[]' id='id[]'  rel='parent' /> 选择</label>
    </th>
    <th width='50'>文档id</th>
    <{if $reqs.cid > 0 }>
    <th width='60'>排序</th>
    <{/if}>
    <th width='250'>标题</th>
    <th width='100'>分类</th>
    <th width='50'>状态</th>
    <th width='100' style='text-align:center'>管理员</th>
    <th width='70' style='text-align:center'>总点击</th>
    <th width='80' style='text-align:center'>发布时间</th>
    <th width='120'>更新时间</th>
    <th></th>
  </tr>
  <{lurd_list item='v'}>
  <tr>
  <td>
    <a href="javascript:show_data('<{$v.doc_id}>');"><img src='../../static/frame/admin/images/icons/text.gif' alt='修改' border='0' /></a>
    <input type='checkbox' rel='child' class='cbox' name='doc_id[]' value='<{$v.doc_id}>' />
  </td>
  <td>
    <{$v.doc_id}>
  </td>
  <{if $reqs.cid > 0 }>
  <td>
    <input type='text' name='sortrank[<{$v.doc_id}>]' value='<{$v.sortrank}>' style='width:50px;' />
    <input type='hidden' name='old_sortrank[<{$v.doc_id}>]' value='<{$v.sortrank}>' />
  </td>
  <{/if}>
  <td> 
    <a href='../../index.php?ct=doc&ac=show&doc_id=<{$v.doc_id}>' target='_blank'><{$v.title}></a>
  </td>
  <td> <{$v.cid|mod_catalog::get_name(3, @me)}> </td>
  <td> <{if $v.sta==1}>已审核<{elseif $v.sta==-1}>预删除<{else}>未审核<{/if}> </td>
  <td align='center'> <{$v.admin_id}> </td>
  <td align='center'> <{$v.hits}> </td>
  <td align='center'> <{$v.pubtime|date('Y-m-d', @me)}> </td>
  <td> <{$v.uptime|date('Y-m-d H:i', @me)}> </td>
  <td></td>
  </tr>
  <{/lurd_list}>
  <tr>
</table>
</form>
</div>

<div id="bottom">
    <div class="fl">
     <{if $reqs.sta == -1 }>
        <button type="button" onclick="un_del();">还原文档</button>
        &nbsp;
        <button type="button" onclick="do_delete(1);">彻底删除文档</button>
     <{else}>
        <button type="button" onclick="add_data();">增加记录</button>
        &nbsp;
        <{if $reqs.cid > 0 }>
        <button type="button" onclick="up_sort();">更新排序</button>
        &nbsp;
        <{/if}>
        <button type="button" onclick="do_delete(0);">移动到回收站</button>
     <{/if}>
    </div>
    <div class="pages">
        <{$lurd_pagination}>
    </div>
</div>

</body>
</html>
 