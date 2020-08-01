<?php
header('Content-Type: text/html; charset=utf-8');
require '../bone/core/bone.php';

//权限控制配置
$purview_config = array(
    'auto_check' => false,                         //自动加载权限检查（此项为true时，自动执行$app->check_purview(1)模式）
    'user_handler' => 'mod_member',                //获取用户信息的接口类
    'purview_key' => 'member_df_purview',          //获取用户组权限配置的key(针对bone_config)
    'pool_name' => 'member',                       //当前应用池名
    'login_url' => '?ct=index&ac=login',           //用户登录入口地址
);

//APP信息
$app_config = array(
    'app_title' => 'phpbone member',
    'app_name' => 'member',
    'session_start' => false,
    'purview_config' => $purview_config,
);



tpl::assign('title', 'phpbone 会员中心');

$app = new bone( $app_config );

$app->check_purview( 1 );

$app->run();
