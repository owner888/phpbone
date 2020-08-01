<{include file="member/header.tpl"}>
<div id="main">
<div class='left-bar'>
<table class='content'>
<tr>
    <td class='tips'>
        当前位置：<a href='./'>会员中心</a> &gt;&gt; 主页
    </td>
</tr>
<tr>
<td class='body'>
    <{if $fields.sta < 1}>
        <div class='err_msg'>你的帐号还没通过审核，请联系客服人员进行审核...</div>
    <{else}>
    <table width="100%">
        <tr>
           <td class='fitem'> <strong><{$fields.user_name}>，欢迎登陆</strong> </td>
        </tr>
        <tr bgcolor='#EFF4FC'>
            <td class='fitem'>...</td>
        </tr>
        <tr>
            <td class='fitem'>...</td>
        </tr>
    </table>
    <{/if}>
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