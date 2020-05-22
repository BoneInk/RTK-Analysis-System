<%@ page import="java.io.*" %>
<%@ page import="java.lang.reflect.Array" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="cn.edu.ncu.RTKanaly.entity.User" %><%--
  Created by IntelliJ IDEA.
  User: 59012
  Date: 2020/5/10
  Time: 23:44
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>《三国演义》在线分析系统</title>
    <link href="/css/bootstrap.min.css" rel="stylesheet"/>
    <script src="/js/jquery.js"></script>
    <script src="/js/bootstrap.min.js"></script>
    <link href="/css/style.css" rel="stylesheet"/>
    <script src="/js/logState.js"></script>
</head>
<body style="background-image: url('/image/bg.jpg');background-repeat:no-repeat;
    background-attachment:fixed">
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
<nav class="navbar navbar-inverse" role="navigation">
    <div class="container-fluid">
        <div class="navbar-header">
            <a class="navbar-brand" href="/main.jsp">《三国演义》在线分析与统计系统</a>

        </div>
        <a class="navbar-text navbar-right" style="color: white;margin-right: 20px;font-size: 15px;"
           href="javascript:out()">注销</a><!-- 注销的链接-->

        <p class="navbar-text navbar-right" id="acountt" style="color: white;margin-right: 20px;font-size: 15px;">
            你好，<%=session.getAttribute("username")%>
        </p>
    </div>
</nav>


<%
    ArrayList<String> arrayList = (ArrayList<String>) session.getAttribute("content");

%>
<script>
    $.post(function () {
        $("#name").blur(function () {
            $.post("/content", {
                    name: $(this).val(),

                },
                function (data) {
                    if (data.res == "no") {
                        $("#ajax").html("用户名已存在！");
                        $(this).select();
                    } else {
                        $("#ajax").html("用户名可用");
                    }
                }, "json");
        });
    });

</script>


<div class="opt">
    <form action="/SelectServlet" method="post">
        <nobr style="color: white">
            检索方式：
        </nobr>
        <select name="range">
            <option value="all">全篇检索</option>
            <option value="part">章节检索</option>
        </select>
        <nobr style="color: white">
            检索关键词：
        </nobr>
        <select name="key">
            <%
                if (session.getAttribute("self").equals("0")) {
            %>
            <option value="name">人名</option>
            <option value="place">地名</option>
            <option value="noUse">虚词</option>
            <%
                }
            %>
            <option value="custom">自定义</option>
            <option value="noKey">无筛选</option>
        </select>
        <div>
            <p style="color: white">
                自定义关键词(每行为一个关键词，同义词通过空格分隔):
            </p>
            <textarea name="cusKey" rows="18" cols="90"
                      style="border-radius: 2px;overflow:visible;resize: none "></textarea>
        </div>
        <% if (session.getAttribute("self").equals("1")) {

        %>
        <div class="pText">
            <p style="color: white">
            <p style="margin-top: 10px;margin-bottom: 10px;color: white">
                自定义文本需输入章节划分特征：
            </p>
            <textarea name="splitKey" rows="1" cols="90"
                      style="border-radius: 2px;overflow:visible;resize: none"></textarea>
            </p>

        </div>
        <%
            }
        %>
        <input type="submit" class="btn-sgst" value="开始检索" style="margin-top: 10px">
    </form>
</div>

<div name="cont" class="card card-cont">
    <% for (String line : arrayList) {
        out.print(line);%><BR><%
    }%>
</div>


</body>
</html>
