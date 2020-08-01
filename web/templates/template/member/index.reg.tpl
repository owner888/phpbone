<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title> <{$title}> -- 注册成为会员 </title>
<style>
*{margin:0;padding:0;color:#333;font-size:12px;}
.content_box { background:#c3d9eb; width:900px;margin:50px auto; margin:30px auto; padding-top:100px; padding-bottom:100px; }
h2 {font-size:14px;height:36px; line-height:36px;border-bottom:1px #8ebce1 solid;padding:0 10px;background:#ebf3fa;}
.box_border { border:1px #8ebce1 solid; width:700px; margin:auto; }
.box_body { padding:20px 0; text-align:center;background:#fff; }
td.title { width:150px; line-height:32px; height:32px; text-align:left; padding-left:40px; font-weight:bold; border-bottom:1px dashed #ddd}
td.fitem { line-height:32px; height:32px; text-align:left;  border-bottom:1px dashed #ddd }
.err_msg { color:red; line-height:36px; }
input.text { height:20px; padding:2px; width:200px; border-top: 1px solid #ddd; border-right: 1px solid #ddd;}
input.btn { border-left: 1px solid #ddd; border-top: 1px solid #ddd; margin-right:20px; height:24px; padding:3px; }
.info { color:#999 }
</style>
</head>
<body>
<div class="content_box">
    <div class="box_border">
    <h2><{$title}> -- 注册成为会员</h2>
    <div class="box_body">
        <{if !empty($err_msg)}>
        <div class='err_msg'><{$err_msg}></div>
        <{/if}>
        <form name="form1" method="post" action="?ct=index&ac=reg">
	    <table width="100%" border="0" cellspacing="3" cellpadding="3">
        <tr>
            <td class='title' width='120'>用户名：<span style='color:red'>*</span></td>
            <td class='fitem'>
                <input type='text' name='reg[user_name]' id='lurd_user_name' class='text' value='<{if !empty($data.user_name)}><{$data.user_name}><{/if}>' />
                <span class='info'>(用户名为小写字符、下划线或数字组合)</span>
            </td>
        </tr>
        <tr>
            <td class='title'>用户密码：<span style='color:red'>*</span></td>
            <td class='fitem'>
                <input type='password' name='reg[userpwd]' id='lurd_userpwd1' class='text' value='' />
                <span class='info'>(密码长度必须大于或等于8位)</span>
            </td>
        </tr>
        <tr>
            <td class='title'>确认密码：<span style='color:red'>*</span></td>
            <td class='fitem'>
                <input type='password' name='reg[userpwd2]' id='lurd_userpwd2' class='text' value='' />
            </td>
        </tr>
        <tr>
            <td class='title'>邮箱：<span style='color:red'>*</span></td>
            <td class='fitem'>
                <input type='text' name='reg[email]' id='lurd_email' class='text' value='<{if !empty($data.email)}><{$data.email}><{/if}>' />
                <span class='info'>(邮箱也可以用于登录)</span>
            </td>
        </tr>
        <tr>
            <td class='title'>真实姓名：</td>
            <td class='fitem'>
                <input type='text' name='reg[name]' class='text s' style='width:120px;' value='<{if !empty($data.name)}><{$data.name}><{/if}>' />
            </td>
        </tr>
        <tr>
            <td class='title'>手机：</td>
            <td class='fitem'>
                <input type='text' name='reg[mobile]' class='text s' style='width:120px;' value='<{if !empty($data.mobile)}><{$data.mobile}><{/if}>' />
            </td>
        </tr>
        <tr>
            <td class='title'>QQ：</td>
            <td class='fitem'>
                <input type='text' name='reg[qq]' class='text s' style='width:120px;' value='<{if !empty($data.qq)}><{$data.qq}><{/if}>' />
            </td>
        </tr>
        <tr>
          <td height="50">&nbsp;</td>
          <td align="left"><input type="submit" name="Submit" class='btn' value="确定注册">
          <input type="reset" name="Submit2" value=" 重 置 " class='btn'>
          <a href='?ac=login'>已经注册？点击这里登录</a>
        </td>
        </tr>
      </table>
	  </form>
    </div>
  </div>
</div>
</body>
</html>