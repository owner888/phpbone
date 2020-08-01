# phpbone
it柏拉图的写的框架，存档一下,phpbone_v21_utf8

# 使用说明：

要求环境PHP 5.2-5.5  MySQL > 5.0

自行创建数据库后，修改 bone/config/inc_config.php 的数据库配置

然后导入 bone/share/phpbone_com.sql 即可使用。

简易文档模块服务器rewrite规则

rewrite ^/catalog-([\d]+).html  /?ct=doc&ac=catalog&cid=$1 last;
rewrite ^/catalog-([\d]+)-([\d]+).html  /?ct=doc&ac=catalog&cid=$1&pageno=$2 last;
rewrite ^/html/show-([\d]+).html     /?ct=doc&ac=show&doc_id=$1 last;
