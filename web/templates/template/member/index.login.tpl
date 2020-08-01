<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<style>
*{margin:0;padding:0;color:#333;font-size:12px;}
.content_box { background:#c3d9eb;width:900px;margin:30px auto; padding-top:100px; padding-bottom:100px; }
.box_border { border:1px #8ebce1 solid; width:500px; margin:auto; }
h2 {font-size:14px;height:36px; line-height:36px;border-bottom:1px #8ebce1 solid;padding:0 10px;background:#ebf3fa;}
.box_body { padding:20px 0; text-align:center;background:#fff; }
input.text { height:20px; padding:2px; width:200px; border-top: 1px solid #ddd; border-right: 1px solid #ddd;}
input.btn { border-left: 1px solid #ddd; border-top: 1px solid #ddd; margin-right:20px; height:24px; padding:3px; }
</style>
<title> <{$title}>--登录系统 </title>
</head>
<body>
<div class="content_box">
    <div class='box_border'>
    <h2><{$title}>--登录系统</h2>
    <div class='box_body'>
	  <{if !empty($err_msg)}>
	  <div style="color:red"><{$err_msg}></div>
	  <{/if}>
	  <form name="form1" method="post" action="?ct=index&ac=login">
	  <input type="hidden" name="gourl" value="<{$gourl}>" />
	  <table width="98%" border="0" cellspacing="3" cellpadding="3">
        <tr>
          <td width="30%" height="42">用户名：</td>
          <td width="70%" align="left"><input name="login[user_name]" type="text" id="user_name" class="text"></td>
        </tr>
        <tr>
          <td height="42">密　码：</td>
          <td align="left"><input name="login[userpwd]" type="password" id="userpwd" class="text"></td>
        </tr>
        <tr>
          <td height="42">选　项：</td>
          <td align="left">
            <label for="record">
            <input type="checkbox" name="login[save]" id="record" checked="checked" />
            记住登录状态
            </label>
            &nbsp;
            <a href='?ac=reg'>注册成为新会员</a>
          </td>
        </tr>
        <tr>
          <td height="50">&nbsp;</td>
          <td align="left">
            <input type="submit" name="Submit" value=" 登 录 " class='btn'>
            <input type="reset" name="Submit2" value=" 重 置 " class='btn'>
          </td>
        </tr>
      </table>
	  </form>
    </div>
  </div>
</div>
</body>
</html>