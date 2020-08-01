<{include file='doc.header.tpl'}>
 
<table border="0" cellspacing="0" cellpadding="0" id="content">
 <tr>
   <td>
    <div id="body">
      <div class='titlebox'>
            <div class='l'>
              <h3><{$fields.title}></h3>
              <span class='info'>
                Source：phpbone.com &nbsp;Author：IT柏拉图 
              </span>
            </div>
            <div class='r'>
              <{$fields.pubtime|date('Y-m-d', @me)}>
            </div>
            <br class='clear'/>
      </div>
      <table width="94%">
        <tr><td class='article'>
        <{$fields.body}>
        </td></tr>
      </table>
      
      <div class='other_info'>
        <{if $site_make_html}>
        <script type='text/javascript' src='/apps/?ac=count_doc&doc_id=<{$fields.doc_id}>'></script>
        <{/if}>
        <!-- Baidu Button BEGIN -->
        <div id="bdshare" class="bdshare_t bds_tools get-codes-bdshare">
        <span class="bds_more">分享到：</span>
        <a class="bds_qzone"></a>
        <a class="bds_tsina"></a>
        <a class="bds_tqq"></a>
        <a class="bds_renren"></a>
        <a class="bds_t163"></a>
        <a class="shareCount"></a>
        </div>
        <script type="text/javascript" id="bdshare_js" data="type=tools&amp;uid=3010432" ></script>
        <script type="text/javascript" id="bdshell_js"></script>
        <script type="text/javascript">
        document.getElementById("bdshell_js").src = "http://bdimg.share.baidu.com/static/js/shell_v2.js?cdnversion=" + Math.ceil(new Date()/3600000)
        </script>
        <!-- Baidu Button END -->
      </div>
        
    </div>
    
    <{include file='doc.side.tpl'}>
    
  <td>
 </tr>
</table><!-- //content -->
 
<{include file='doc.footer.tpl'}>