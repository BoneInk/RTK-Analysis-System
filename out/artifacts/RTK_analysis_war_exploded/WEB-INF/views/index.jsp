<%@ page import="java.io.PrintWriter" %>
<%@ page import="com.huaban.analysis.jieba.JiebaSegmenter" %>
<%@ page import="com.huaban.analysis.jieba.SegToken" %>
<%@ page import="java.util.*" %>
<%@ page import="java.util.regex.Pattern" %>
<%@ page import="java.util.regex.Matcher" %>
<%@ page import="cn.edu.ncu.RTKanaly.entity.User" %><%--
  Created by IntelliJ IDEA.
  User: 59012
  Date: 2020/5/12
  Time: 22:54
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
    <style>
        .fpName{
            font-family: 幼圆;
            font-size: 50px;
            text-align: center;
            margin-top: 15%;
            color: white;
        }

        .fp-btn{
            color: white;
            font-family: 楷体;
            font-size: 30px;
            text-align: center;
            align-items: center;
            margin-top: 60px;
        }
        .btn-fp{
            margin-left: 20px;
            margin-right: 20px;
            border: 0;
            background-color: #2c2c2c;
            text-align: center;
            border-radius: 3px;
            box-shadow: 0 0 2px #cbcbcb;
        }


    </style>

</head>


<body onload="initAJAX()" style="background-image: url('/image/fpbg.jpg');background-repeat:no-repeat;
    background-attachment:fixed ;background-size: 100% auto">


<div class="fpName">
    <p>《三国演义》在线分析统计系统</p>
</div>
<div class="fp-btn">
    <input href="/html/login.html" rel="tooltip" data-placement="buttom" data-toggle="modal" data-target="#myModal" type="button" class="login btn-fp" value="登录">
    <input href="/html/regis.html" rel="tooltip" data-placement="buttom" data-toggle="modal" data-target="#myModal" type="button" class="register btn-fp" value="注册">
</div>
<div class="modal fade" id="myModal">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header"></div>
            <div class="modal-body"></div>
            <div class="modal-footer"></div>
        </div>
    </div>
</div>
</body>
</html>
