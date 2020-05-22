<%@ page import="java.io.FileInputStream" %>
<%@ page import="java.io.InputStreamReader" %>
<%@ page import="java.io.BufferedReader" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="cn.edu.ncu.RTKanaly.entity.User" %>
<%@ page import="java.net.HttpCookie" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>《三国演义》在线分析系统</title>
    <link href="/css/bootstrap.min.css" rel="stylesheet"/>
    <script src="/js/jquery.js"></script>
    <script src="/js/bootstrap.min.js"></script>
    <link href="/css/style.css" rel="stylesheet"/>
    <style>
        table, td, th, tr {
            border: 0px;
        }
    </style>
    <%
        String name = request.getParameter("username");
        if (name != null) {
            session.setAttribute(name, "username");
        }
    %>
    <script>
        $(function () {
            var name ='<%=session.getAttribute("username")%>';
            if (name == null) {
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
</head>


<body style="background-image: url('/image/bg.jpg');">
<nav class="navbar navbar-inverse" role="navigation">
    <div class="container-fluid">
        <div class="navbar-header">
            <a class="navbar-brand" href="WEB-INF/views/main.jsp">《三国演义》在线分析与统计系统</a>
        </div>
        <a class="navbar-text navbar-right" style="color: white;margin-right: 20px;font-size: 15px;"
           href="javascript:out()">注销</a><!-- 注销的链接-->

        <p class="navbar-text navbar-right" id="acountt" style="color: white;margin-right: 20px;font-size: 15px;">
            你好，<%=session.getAttribute("username")%>
        </p>
    </div>
</nav>
<div class="card">
    <table class="tables">
        <tr>
            <th>
                <div class="card-left">
                    《三国演义》描写了从东汉末年到西晋初年之间近百年的历史风云，以描写战争为主，诉说了东汉末年的群雄割据混战和魏、蜀、吴三国之间
                    的政治和军事斗争，最终司马炎一统三国，建立晋朝的故事。反映了三国时代各类社会斗争与矛盾的转化，并概括了这一时代的历史巨变，
                    塑造了一群叱咤风云的三国英雄人物。
                </div>
                <div class="btn-center">
                    <form action="/StartServlet" method="post">
                        <input type="submit" value="开始分析" class="btn-sgst">
                    </form>
                    <div>
                        <form action="/UploadServlet" enctype="multipart/form-data" method="post">
                            <p>
                                或上传自定义文档：
                            </p>
                            <input type="file" name="txt" style="float:left;width: 150px">
                            <input type="submit" value="确认" class="btn-sgst" style="margin-top: auto"/>
                            <input class="btn-sgst" style="margin-top: auto" type="reset" value="重置"/>
                        </form>
                    </div>


                </div>
            </th>
            <th width="50%">
                <div class="card-right">
                    <img src="/image/sgyy.jpg" class="img-rounded" style="width: 90%">
                </div>
            </th>
        </tr>
    </table>


</div>

</body>
</html>
