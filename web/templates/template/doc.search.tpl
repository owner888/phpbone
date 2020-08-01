<{include file='doc.header.tpl'}>
 
<table border="0" cellspacing="0" cellpadding="0" id="content">
 <tr>
   <td>
  <div id="body">
<{foreach from=$data.data key=k item=v}>
     <ul class='item'>
        <li class='l'>
            <a href="/html/show-<{$v.doc_id}>.html" class="title" title="<{$v.title}>"><{$v.title}></a>
        </li>
        <li class='r'>
             <{$v.pubtime|date('Y-m-d', @me)}>
        </li>
     </ul>
<{/foreach}>
        
      <div class='list_pagination'>
            <{$data.pagination}>
      </div>
        
    <br class='clear'/>
  </div><!-- //列表 -->
    
    <{include file='doc.side.tpl'}>

  <td>
 </tr>
</table><!-- //content -->
 
<{include file='doc.footer.tpl'}>