<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<html lang="en">
<head>
    <script src="http://www.jq22.com/jquery/jquery-1.10.2.js"></script>
</head>

<body data-type="login">
    <div class="am-g tpl-g">
        <div class="tpl-login">
            <div class="tpl-login-content">
                <div class="tpl-login-title">注册用户</div>
                <form class="am-form tpl-form-line-form" method="post" action="/books/RegisterServlet">
                    <div class="am-form-group">
                        <input type="text" class="tpl-form-input" id="user-name" name="username" required="required" placeholder="请输入账号">

                    </div>
					<div class="am-form-group">
                        <input type="password" class="tpl-form-input" id="user-name" name="password" required="required" placeholder="请输入密码">
                    </div>
					<div class="am-form-group">
                        <input type="text" class="tpl-form-input" id="user-name" name="name" required="required" placeholder="请输入姓名">
                    </div>
					<div class="am-form-group">
                        <input type="text" class="tpl-form-input" id="user-name" name="email" required="required" placeholder="请输入邮箱">
                    </div>
                    <div class="am-form-group">
                        <input type="text" class="tpl-form-input" id="user-name" name="phone" required="required" placeholder="请输入手机号">
                    </div>
                    
					
					<div class="am-form-group">

                        <button type="submit" class="am-btn am-btn-primary  am-btn-block tpl-btn-bg-color-success  tpl-login-btn">提交</button>

                    </div>
                    <div class="am-form-group">

                        <button type="button" onclick="location.href='/books/login.jsp';" class="am-btn am-btn-primary  am-btn-block tpl-btn-bg-color-success  tpl-login-btn">返回登录</button>

                    </div>
                </form>
            </div>
        </div>
    </div>
    <script src="http://cdn.bootcss.com/amazeui/2.7.2/js/amazeui.min.js"></script>
    <script src="static/assets/js/app.js"></script>

</body>

</html>