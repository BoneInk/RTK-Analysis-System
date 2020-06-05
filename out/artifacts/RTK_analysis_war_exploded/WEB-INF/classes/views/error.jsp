<%--
  Created by IntelliJ IDEA.
  User: 59012
  Date: 2020/5/14
  Time: 17:17
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>《三国演义》在线分析系统</title>
    <link href="/css/bootstrap.min.css" rel="stylesheet"/>
    <script src="/js/jquery.js"></script>
    <script src="/js/bootstrap.min.js"></script>
    <link href="/css/style.css" rel="stylesheet"/>
</head>
<script>
    window.onload = function(){
        setTimeout("history.back()", 3000);
    }
</script>

<body style="background-image: url('/image/bg.jpg');">
<script>
    $(function () {
        var name ='<%=session.getAttribute("username")%>';
        if (name==null){
            alert("请登录后使用！");
            sessionStorage.clear();
            window.location.replace("/");
        }
    })

    function out() {<!-- 用户登陆后想要注销的动作-->
        sessionStorage.clear();
        alert("注销完毕！");
        window.location.replace("/");
    }
</script>


<nav class="navbar navbar-inverse" role="navigation">
    <div class="container-fluid">
        <div class="navbar-header">
            <a class="navbar-brand" href="/main.jsp">《三国演义》在线分析与统计系统</a>

        </div>
        <a  class="navbar-text navbar-right" style="color: white;margin-right: 20px;font-size: 15px;" href="javascript:out()">注销</a><!-- 注销的链接-->

        <p class="navbar-text navbar-right" id="acountt" style="color: white;margin-right: 20px;font-size: 15px;">你好，<%=session.getAttribute("username")%></p>
    </div>
</nav>
<div class="card card-cont" style="text-align: center">
    <p name="errorType" style="width: 100%">缺少关键词！3s后返回上一页</p>
</div>

</body>
</html>
