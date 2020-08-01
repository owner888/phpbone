<div id="side">

      <dl class="cake">
        <dt class='top'> 文档导航 </dt>
        <dd class='top'>
        <{catalog cmid='3' parent=0 item='_v'}>
         <dl class='cat_item' style='margin-top:5px'>
           <dt><a href='/catalog-<{$_v.cid}>.html'><{$_v.cname}></a></dt>
           <{doclist limit='20' item='_vv' cid=$_v.cid }>
           <dd><a href="/html/show-<{$_vv.doc_id}>.html"  title="<{$_vv.title}>"><{$_vv.title}></a></dd>
           <{/doclist}>
         </dl>
       <{/catalog}>
        </dd>
      <dl>
        
      <dl class="cake">
        <dt class='top'> 其它项目 </dt>
        <dd class='top'>
         <dl class='cat_item' style='margin-top:5px'>
           <dt><a href='/phpanalysis'>PHP分词系统(PHPAnalysis)</a></dt>
         </dl>
        </dd>
      <dl>

</div>
