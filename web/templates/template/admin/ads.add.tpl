<{include file="admin/header.tpl"}>
</head>
<body class="frame-from">
<div class="tboxform">
<form name="form1" action="?ct=ads&even=saveadd&tb=bone_ads" method="POST" enctype="multipart/form-data">
<table class="form" style="width:90%">
<tr>
  <td class='title' style="width:120px;">是否启用：</td>
  <td class='fitem'>
    <label><input type='radio' name='show' value='1' checked="checked"/>启用</label>
    <label><input type='radio' name='show' value='0' />禁用</label>
  </td>
</tr>
<tr>
  <td class='title'>标识：</td>
  <td class='fitem'><input type='text' name='key' class='text' value='' /> (建议不要用中文标识)</td>
</tr>
<tr>
  <td class='title'>备注：</td>
  <td class='fitem'><input type='text' name='info' class='text' value='' style='width:300px;' /></td>
</tr>
<tr>
  <td class='title'>正常显示代码：</td>
  <td class='fitem'><{#editor fieldname='code' toolbar='Base' value='' width='100%' height='150'}></td>
</tr>
<tr>
  <td class='title'>禁用后显示代码：</td>
  <td class='fitem'><textarea name='expcode' class='txtarea' style='height:100px;width:97%'></textarea></td>
</tr>
<tr>
  <td colspan='2' align='center' height='60'>
      <button type="submit">保存</button> &nbsp;&nbsp;&nbsp;
      <button type="reset">重设</button>
  </td>
</tr>
</table>
</form>
</div>
</body>
</html>
