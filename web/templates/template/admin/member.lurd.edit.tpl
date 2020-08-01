<{include file="admin/header.tpl"}>
</head>
<body class="frame-from">
<div class="tboxform">
<form name="form1" action="?ct=member&even=saveedit" method="POST" enctype="multipart/form-data">
<table class="form">
<{lurd_list item='v'}>
<input type='hidden' name='member_id' value='<{$v.member_id}>' />
<input type='hidden' name='old_email' value='<{$v.email}>' />
<input type='hidden' name='old_user_name' value='<{$v.user_name}>' />
<tr>
  <td class='title' width='120'>用户名：</td>
  <td class='fitem'> <{$v.user_name}> </td>
</tr>
<tr>
  <td class='title'>用户密码：</td>
  <td class='fitem'>
    <input type='text' name='userpwd' id='lurd_userpwd' class='text' value='' />
    <br /><span class='info'>(不修改留空)</span>
  </td>
</tr>
<tr>
  <td class='title'>邮箱：</td>
  <td class='fitem'><input type='text' name='email' id='lurd_email' class='text' value='<{$v.email}>' /></td>
</tr>
<tr>
  <td class='title'>姓名：</td>
  <td class='fitem'><input type='text' name='name' class='text' value='<{$v.name}>' /></td>
</tr>
<tr>
  <td class='title'>手机：</td>
  <td class='fitem'>
    <input type='text' name='mobile' class='text s' value='<{$v.mobile}>' style='width:120px;' />
    &nbsp; QQ:
    <input type='text' name='qq' class='text s' value='<{$v.qq}>' style='width:120px;' />
  </td>
</tr>
<tr>
  <td class='title'>帐号状态：</td>
  <td class='fitem'>
    <label><input type='radio' name='sta' value='1' <{if $v.sta==1}>checked<{/if}>> 正常</label>
    <label><input type='radio' name='sta' value='0' <{if $v.sta==0}>checked<{/if}>> 未审核</label>
    <label><input type='radio' name='sta' value='-1' <{if $v.sta==-1}>checked<{/if}>> 禁用</label>
  </td>
</tr>
<tr>
  <td class='title'>注册时间：</td>
  <td class='fitem'>
    <{$v.regtime|date('Y-m-d H:i:s', @me)}> &nbsp; 注册ip：<{$v.regip}>
  </td>
</tr>
<tr>
  <td class='title'>最后登录时间：</td>
  <td class='fitem'>
    <{$v.logintime|date('Y-m-d H:i:s', @me)}> &nbsp; 最后登录IP：<{$v.loginip}>
  </td>
</tr>
<{/lurd_list}>
<tr>
  <td colspan='2' align='center' height='60' style='padding-left:60px;'>
      <button type="submit">保存</button> &nbsp;&nbsp;&nbsp;
      <button type="reset">重设</button>
  </td>
</tr>
</table>
</form>
</div>
</body>
</html>
