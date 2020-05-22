<%@ page import="java.util.Map" %>
<%@ page import="java.util.List" %><%--
  Created by IntelliJ IDEA.
  User: 59012
  Date: 2020/5/20
  Time: 23:07
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
    <script src="/js/echarts.min.js"></script>
</head>
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
<%
    int start = (int) request.getAttribute("start");
    int to = (int) request.getAttribute("to");
    String key = (String) session.getAttribute("key");
    List<List<Map.Entry<String, Integer>>> resList = (List<List<Map.Entry<String, Integer>>>) session.getAttribute("resList");
    List<Map.Entry<String, Integer>> list1 = (List<Map.Entry<String, Integer>>) request.getAttribute("list1");
    List<Map.Entry<String, Integer>> list2 = (List<Map.Entry<String, Integer>>) request.getAttribute("list2");
    List<Map.Entry<String, Integer>> list3 = (List<Map.Entry<String, Integer>>) request.getAttribute("list3");

%>
<body style="background-image: url('/image/bg1.png');background-repeat:no-repeat;
      background-attachment:fixed">
<nav class="navbar navbar-inverse" role="navigation">
    <div class="container-fluid">
        <div class="navbar-header">
            <a class="navbar-brand" href="/">《三国演义》在线分析与统计系统</a>

        </div>
        <a class="navbar-text navbar-right" style="color: white;margin-right: 20px;font-size: 15px;"
           href="javascript:out()">注销</a><!-- 注销的链接-->

        <p class="navbar-text navbar-right" id="acountt" style="color: white;margin-right: 20px;font-size: 15px;">
            你好，<%=session.getAttribute("username")%>
        </p>
    </div>
</nav>

<div class="card card-cont" style="border: 1px;text-align: center">
    <div id="main" style="width: 100%;height: 1500px"></div>

    <script>
        var myChart = echarts.init(document.getElementById('main'));
        var option = {
            title: {
                text: ' 第1章至第<%=start%>章：'
            },
            grid: {
                left: '3%',
                right: '4%',
                bottom: '3%',
                containLabel: true
            },
            tooltip: {
                trigger: 'axis',
                axisPointer: {
                    type: 'shadow'
                }
            },
            xAxis: {
                type: 'value',
            },
            yAxis: {
                type: 'category',
                inverse: true,
                axisLabel: {
                    interval: 0,

                },
                data: [<%
            int m=0;
            if(key.equals("noKey")) m=30;
            else m=list1.size();
            for(int i=0;i<m&&i<list1.size();i++){
                Map.Entry<String ,Integer> mapping=list1.get(i);
            %>"<%=mapping.getKey()%>",
                    <%
                    }
                    %>
                ]
            },
            series: [{
                name: '词频',
                type: 'bar',
                data: [<%
            for(int i=0;i<m&&i<list1.size();i++){
                Map.Entry<String ,Integer> mapping=list1.get(i);
            %>"<%=mapping.getValue()%>",
                    <%
                    }
                    %>
                ],
                itemStyle: {
                    normal: {
                        color: function (params) {
                            var colorList = ['#c23531', '#2f4554', '#61a0a8', '#d48265', '#91c7ae', '#749f83', '#ca8622', '#bda29a', '#6e7074', '#546570', '#c4ccd3'];
                            var index;
                            //给大于颜色数量的柱体添加循环颜色的判断
                            if (params.dataIndex >= colorList.length) {
                                index = params.dataIndex % colorList.length;
                                return colorList[index];
                            }
                            return colorList[params.dataIndex];
                        }
                    }
                },
                label: {
                    show: true, //开启显示
                    position: 'right', //在上方显示
                    textStyle: { //数值样式
                        color: 'black',
                        fontSize: 13,
                        fontWeight: 200
                    }
                }
            }]
        };
        myChart.setOption(option);
        window.onresize = myChart.resize;
    </script>

    <div id="main0" style="width: 100%;height: 1500px"></div>
    <script>
        var myChart = echarts.init(document.getElementById('main0'));
        var option = {
            title: {
                text: ' 第<%=start+1%>章至第<%=to%>章：'
            },
            grid: {
                left: '3%',
                right: '4%',
                bottom: '3%',
                containLabel: true
            },
            tooltip: {
                trigger: 'axis',
                axisPointer: {
                    type: 'shadow'
                }
            },
            xAxis: {
                type: 'value',
            },
            yAxis: {
                type: 'category',
                inverse: true,
                axisLabel: {
                    interval: 0,

                },
                data: [<%
                m=0;
            if(key.equals("noKey")) m=30;
            else m=list2.size();
            for(int i=0;i<m&&i<list2.size();i++){
                Map.Entry<String ,Integer> mapping=list2.get(i);
            %>"<%=mapping.getKey()%>",
                    <%
                    }
                    %>
                ]
            },
            series: [{
                name: '词频',
                type: 'bar',
                data: [<%
            for(int i=0;i<m&&i<list2.size();i++){
                Map.Entry<String ,Integer> mapping=list2.get(i);
            %>"<%=mapping.getValue()%>",
                    <%
                    }
                    %>
                ],
                itemStyle: {
                    normal: {
                        color: function (params) {
                            var colorList = ['#c23531', '#2f4554', '#61a0a8', '#d48265', '#91c7ae', '#749f83', '#ca8622', '#bda29a', '#6e7074', '#546570', '#c4ccd3'];
                            var index;
                            //给大于颜色数量的柱体添加循环颜色的判断
                            if (params.dataIndex >= colorList.length) {
                                index = params.dataIndex % colorList.length;
                                return colorList[index];
                            }
                            return colorList[params.dataIndex];
                        }
                    }
                },
                label: {
                    show: true, //开启显示
                    position: 'right', //在上方显示
                    textStyle: { //数值样式
                        color: 'black',
                        fontSize: 13,
                        fontWeight: 200
                    }
                }
            }]
        };
        myChart.setOption(option);
        window.onresize = myChart.resize;
    </script>

    <%
        if (to < 120) {
    %>
    <div id="main1" style="width: 100%;height: 1500px"></div>
    <script>
        var myChart = echarts.init(document.getElementById('main1'));
        var option = {
            title: {
                text: ' 第<%=to+1%>章至第<%=resList.size()%>章：'
            },
            grid: {
                left: '3%',
                right: '4%',
                bottom: '3%',
                containLabel: true
            },
            tooltip: {
                trigger: 'axis',
                axisPointer: {
                    type: 'shadow'
                }
            },
            xAxis: {
                type: 'value',
            },
            yAxis: {
                type: 'category',
                inverse: true,
                axisLabel: {
                    interval: 0,

                },
                data: [<%
            m=0;
            if(key.equals("noKey")) m=30;
            else m=list3.size();
            for(int i=0;i<m&&i<list3.size();i++){
                Map.Entry<String ,Integer> mapping=list3.get(i);
            %>"<%=mapping.getKey()%>",
                    <%
                    }
                    %>
                ]
            },
            series: [{
                name: '词频',
                type: 'bar',
                data: [<%
           for(int i=0;i<m&&i<list3.size();i++){
                Map.Entry<String ,Integer> mapping=list3.get(i);
            %>"<%=mapping.getValue()%>",
                    <%
                    }
                    %>
                ],
                itemStyle: {
                    normal: {
                        color: function (params) {
                            var colorList = ['#c23531', '#2f4554', '#61a0a8', '#d48265', '#91c7ae', '#749f83', '#ca8622', '#bda29a', '#6e7074', '#546570', '#c4ccd3'];
                            var index;
                            //给大于颜色数量的柱体添加循环颜色的判断
                            if (params.dataIndex >= colorList.length) {
                                index = params.dataIndex % colorList.length;
                                return colorList[index];
                            }
                            return colorList[params.dataIndex];
                        }
                    }
                },
                label: {
                    show: true, //开启显示
                    position: 'right', //在上方显示
                    textStyle: { //数值样式
                        color: 'black',
                        fontSize: 13,
                        fontWeight: 200
                    }
                }
            }]
        };
        myChart.setOption(option);
        window.onresize = myChart.resize;
    </script>
    <%
        }
    %>

</div>
</body>
</html>
