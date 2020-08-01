<{include file="member/header.tpl"}>
<div id="main">
<div class='left-bar'>
<table class='content'>
<tr>
    <td class='tips'>
        当前位置：<a href='./'>会员中心</a> &gt;&gt; 修改资料
    </td>
</tr>
<tr>
<td class='body'>
    <{if !empty($err_msg)}>
    <div class='err_msg'><{$err_msg}></div>
    <{/if}>
    <form name="form1" method="post" action="?ct=index&ac=edit_info">
	    <input type='hidden' name='data[member_id]' value='<{if !empty($data.member_id)}><{$data.member_id}><{/if}>' />
	    <table width="100%" border="0" cellspacing="3" cellpadding="3">
        <tr>
            <td class='title' width='120'>用户名：</td>
            <td class='fitem'>
                <{$data.user_name}>
            </td>
        </tr>
        <tr>
            <td class='title'>用户密码：</td>
            <td class='fitem'>
                <input type='password' name='data[userpwd]' id='lurd_userpwd1' class='text' value='' />
                <span class='info'>(密码长度必须大于或等于8位，不修改留空)</span>
            </td>
        </tr>
        <tr>
            <td class='title'>确认密码：</td>
            <td class='fitem'>
                <input type='password' name='data[userpwd2]' id='lurd_userpwd2' class='text' value='' />
            </td>
        </tr>
        <tr>
            <td class='title'>邮箱：</td>
            <td class='fitem'>
                <input type='hidden' name='data[old_email]' value='<{if !empty($data.email)}><{$data.email}><{/if}>' />
                <input type='text' name='data[email]' id='lurd_email' class='text' value='<{if !empty($data.email)}><{$data.email}><{/if}>' />
                <span class='info'>(邮箱也可以用于登录)</span>
            </td>
        </tr>
        <tr>
            <td class='title'>真实姓名：</td>
            <td class='fitem'>
                <input type='text' name='data[name]' class='text s' style='width:120px;' value='<{if !empty($data.name)}><{$data.name}><{/if}>' />
            </td>
        </tr>
        <tr>
            <td class='title'>手机：</td>
            <td class='fitem'>
                <input type='text' name='data[mobile]' class='text s' style='width:120px;' value='<{if !empty($data.mobile)}><{$data.mobile}><{/if}>' />
            </td>
        </tr>
        <tr>
            <td class='title'>QQ：</td>
            <td class='fitem'>
                <input type='text' name='data[qq]' class='text s' style='width:120px;' value='<{if !empty($data.qq)}><{$data.qq}><{/if}>' />
            </td>
        </tr>
        <tr>
          <td height="50">&nbsp;</td>
          <td align="left"><input type="submit" name="Submit" class='btn' value="确定保存">
          <input type="reset" name="Submit2" value=" 重 置 " class='btn'>
        </td>
        </tr>
      </table>
    </form>
</td>
</tr>
</table>
</div>
<div class='right-bar'></div>
</div>
<!--/main-->

<{include file="member/footer.tpl"}>

</body>
</html>