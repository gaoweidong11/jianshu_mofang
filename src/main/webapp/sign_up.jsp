<%--
    Created by mingfei.net@gmail.com
    6/27/17 10:47
    https://github.com/thu/jianshu/
--%>
<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>注册 - 简书</title>
    <link rel='shortcut icon' type='image/x-icon' href='favicon.ico'>
    <link rel="stylesheet" href="static/css/bootstrap.min.css">
    <link rel="stylesheet" href="static/css/bootstrap-switch.min.css">
    <style>
        @import "static/css/nav.css";
    </style>
    <style>
        body {
            background: #f1f1f1;
        }

        #logo {
            margin-bottom: 15px;
        }

        h3 a {
            display: inline-block;
            margin: 30px 10px;
        }

        #sign-up {
            color: #ea6f5a;
        }

        #form-box {
            border-radius: 5px;
            box-shadow: 1px 1px 1px #0f0f0f;
        }

        #form-box {
            background: #fff;
            padding: 50px;
        }

        #form-box div {
            margin-bottom: 15px;
        }

        #form-box button {
            margin: 30px 0 15px;
        }

    </style>
    <script src="static/js/jquery.min.js"></script>
    <script src="static/js/bootstrap.min.js"></script>
    <script src="static/js/bootstrap-switch.min.js"></script>
    <script src="static/js/nav.js"></script>
    <script>
        $(function () {
            $('#index').removeClass('active');
        });
    </script>
</head>
<body>
<%@ include file="nav.jsp" %>
<div class="container">
    <div id="logo"><img src="static/image/logo.png" alt="简书"></div>
    <div id="form-box" class="col-md-4 col-md-offset-4">
        <h3 class="text-center"><a class="text-muted" href="">登录</a> · <a id="sign-up" href="">注册</a></h3>
        <form class="form-horizontal" action="">
            <div class="input-group">
                <span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span>
                <input class="form-control input-lg" type="text" placeholder="你的昵称">
            </div>
            <div class="input-group">
                <span class="input-group-addon"><i class="glyphicon glyphicon-phone"></i></span>
                <input class="form-control input-lg" type="text" placeholder="手机号">
            </div>
            <div class="input-group">
                <span class="input-group-addon"><i class="glyphicon glyphicon-lock"></i></span>
                <input class="form-control input-lg" type="text" placeholder="设置密码">
            </div>
            <button class="btn btn-success btn-lg btn-block">注册</button>
            <p class="text-center">
                <small>点击 “注册” 即表示您同意并愿意遵守简书</small>
            </p>
            <p class="text-center">
                <small><a href="">用户协议</a> 和 <a href="">隐私政策</a> 。</small>
            </p>
        </form>
    </div>
</div>
</body>
</html>
