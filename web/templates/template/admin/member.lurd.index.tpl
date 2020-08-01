<{include file="admin/header.tpl"}>
<script lang='javascript'>
function add_data(nid)
{
    tb_show('增加会员', '?ct=member&even=add&tb=bone_member&TB_iframe=true&height=350&width=600', true);
}
function show_data(nid)
{
    tb_show('浏览/编辑会员', '?ct=member&even=edit&member_id='+ nid +'&TB_iframe=true&height=370&width=600', true);
}
function do_delete()
{
    document.form1.even.value = 'delete';
    var msg = "你确定要删除选中的记录？！";
    msg += "<br/><a href='javascript:tb_remove2();'>&lt;&lt;点错了</a> &nbsp;|&nbsp; <a href='javascript:document.form1.submit();'>确定要删除&gt;&gt;</a>";
    tb_showmsg(msg);
}
</script>
</head>
<body class="frame-from">
<div id="contents">
<form name="formsearch" action="?" method="GET">
<input type='hidden' name='ct' value='member'>
<dl class="search-class">
    <dd>
    关键字：
    <input type='text' name='keyword' style='width:200px;' class='text' value="<{if !empty($reqs.keyword)}><{$reqs.keyword}><{/if}>" />
    <select name='sta'>
    <option value='2'>全部</option>
    <option value='1' <{if $reqs.sta==1}>selected<{/if}>>正常</option>
    <option value='0' <{if $reqs.sta==0}>selected<{/if}>>未审核</option>
    <option value='-1' <{if $reqs.sta==-1}>selected<{/if}>>已禁用</option>
    </select>
    <button type='submit'>搜索</button>
    </dd>
</dl>
</form>

<form name="form1" action="?ct=member" method="POST">
<input type="hidden" name="even" value="delete" />
<table class="table-sort table-operate">
  <tr>
    <th width="60"> <label for='id[]'><input type='checkbox' name='id[]' id='id[]'  rel='parent' /> 选择</label> </th>
    <th width="50">会员id</th>
    <th width="120">用户名</th>
    <th width="120">邮箱</th>
    <th width="50">状态</th>
    <th width="120">注册时间</th>
    <th width="120">登录时间</th>
    <th width="120">登录IP</th>
    <th></th>
  </tr>
  <{lurd_list item='v'}>
  <tr>
  <td>
       <a href="javascript:show_data('<{$v.member_id}>');"><img src='../../static/frame/admin/images/icons/text.gif' alt='修改' border='0' /></a>
       <input type='checkbox' rel='child' class='cbox' name='member_id[]' value='<{$v.member_id}>' />
  </td>
  <td> <{$v.member_id}> </td>
  <td> <{$v.user_name}>(<{$v.name}>) </td>
  <td> <{$v.email}> </td>
  <td>
    <{if $v.sta==1}>正常<{elseif $v.sta==0}><span style='color:red'>未审核</span><{else}><span style='color:red'>禁用</span><{/if}>
  </td>
  <td> <{$v.regtime|date('Y-m-d H:i')}> </td>
  <td> <{$v.logintime|date('Y-m-d H:i')}> </td>
  <td> <{$v.loginip}> </td>
  <td></td>
  </tr>
  <{/lurd_list}>
  <tr>
</table>
</form>
</div>

<div id="bottom">
    <div class="fl">
        <button type="button" onclick="add_data();">增加会员</button>
        &nbsp;
        <button type="button" onclick="do_delete();">删除选中记录</button>
    </div>
    <div class="pages">
        <{$lurd_pagination}>
    </div>
</div>

</body>
</html>
 