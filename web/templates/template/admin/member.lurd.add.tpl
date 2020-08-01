<{include file="admin/header.tpl"}>
</head>
<body class="frame-from">
<div class="tboxform">
<form name="form1" action="?ct=member&even=saveadd" method="POST" enctype="multipart/form-data">
<table class="form">
<tr>
  <td class='title' width='120'>用户名：</td>
  <td class='fitem'><input type='text' name='user_name' id='lurd_user_name' class='text' value='' /></td>
</tr>
<tr>
  <td class='title'>用户密码：</td>
  <td class='fitem'><input type='text' name='userpwd' id='lurd_userpwd' class='text' value='' /></td>
</tr>
<tr>
  <td class='title'>邮箱：</td>
  <td class='fitem'><input type='text' name='email' id='lurd_email' class='text' value='' /></td>
</tr>
<tr>
  <td class='title'>姓名：</td>
  <td class='fitem'><input type='text' name='name' class='text' value='' /></td>
</tr>
<tr>
  <td class='title'>手机：</td>
  <td class='fitem'>
    <input type='text' name='mobile' class='text s' value='' style='width:120px;' />
    &nbsp; QQ:
    <input type='text' name='qq' class='text s' value='' style='width:120px;' />
  </td>
</tr>
<tr>
  <td class='title'>帐号状态：</td>
  <td class='fitem'>
    <label><input type='radio' name='sta' value='1' checked> 正常</label>
    <label><input type='radio' name='sta' value='1'> 未审核</label>
    <label><input type='radio' name='sta' value='-1'> 禁用</label>
 </td>
</tr>
<tr>
  <td colspan='2' align='center' height='60' style='padding-left:60px;'>
      <input type='hidden' name='groups' value='member_common' />
      <button type="submit">保存</button> &nbsp;&nbsp;&nbsp;
      <button type="reset">重设</button>
  </td>
</tr>
</table>
</form>
</div>
</body>
</html>
