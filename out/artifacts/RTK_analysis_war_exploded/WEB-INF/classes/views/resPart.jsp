<%@ page import="java.util.ArrayList" %>
<%@ page import="java.lang.reflect.Array" %>
<%@ page import="java.util.Map" %>
<%@ page import="cn.edu.ncu.RTKanaly.entity.User" %>
<%@ page import="java.util.List" %><%--
  Created by IntelliJ IDEA.
  User: 59012
  Date: 2020/5/12
  Time: 1:13
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
    List<List<Map.Entry<String, Integer>>> resList = (List<List<Map.Entry<String, Integer>>>) request.getAttribute("resList");
    String key = request.getParameter("key");
    session.setAttribute("key",key);
    session.setAttribute("resList", resList);
    List<Map.Entry<String, Integer>> mostList = (List<Map.Entry<String, Integer>>) request.getAttribute("mostList");
%>
<script>
    function cChange() {
        var t = document.getElementById("start");
        var tt = t.options[t.selectedIndex].value;
        var opp = document.getElementById('to');
        while (opp.options.length > 0) {
            opp.removeChild(opp.options[0]);
        }
        var max = <%=resList.size()%>;
        var i = tt;
        i++;
        for (; i <= max; i++) {
            opp.add(new Option(i, i));
        }
    }
</script>

<body style="background-image: url('/image/bg1.png');background-repeat:no-repeat;
    background-attachment:fixed">
<nav class="navbar navbar-inverse" role="navigation">
    <div class="container-fluid">
        <div class="navbar-header">
            <a class="navbar-brand" href="WEB-INF/views/res.jsp">《三国演义》在线分析与统计系统</a>

        </div>
        <a class="navbar-text navbar-right" style="color: white;margin-right: 20px;font-size: 15px;"
           href="javascript:out()">注销</a><!-- 注销的链接-->

        <p class="navbar-text navbar-right" id="acountt" style="color: white;margin-right: 20px;font-size: 15px;">
            你好，<%=session.getAttribute("username")%>
        </p>
    </div>
</nav>
<input hidden="hidden" value="<%=resList.size()%>" id="max">


<div class="card card-cont" style="border: 1px;text-align: center">
    <div style="width: 80%;margin-left: 10%;font-size: 18px;font-weight: bold">

        <form action="/CombineServlet" method="post">
            <p>
                合并分析：
            </p>
            起始-><select id="start" name="start" onchange="cChange()"><%
            for (int p = 2; p < resList.size(); p++) {
        %>
            <option value="<%=p%>"><%=p%>
            </option>
            <%
                }
            %>


        </select>
            -><select id="to" name="to">

        </select>->结尾
            <input type="submit" value="确认">
        </form>
    </div>
    <div id="main" style="width: 100%;height:2000px"></div>

    <script>
        var myChart = echarts.init(document.getElementById('main'));
        option = {
            title: {
                text: '章节最高词频统计'
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
                type: 'value'
            },
            yAxis: {
                type: 'category',
                inverse: true,
                axisLabel: {
                    interval: 0,

                },
                data: [
                    <%
                for(int i=0;i<resList.size();i++){
                    List<Map.Entry<String,Integer>> list=resList.get(i);
                    %>'第<%=i+1%>回：<%=list.get(0).getKey()%>', <%
                    }
                    %>
                ]
            },
            series: [{
                name: '词频',
                data: [<%
                    for(List<Map.Entry<String,Integer>> list:resList){
                    %><%=list.get(0).getValue()%>, <%
                    }
                    %>
                ],
                type: 'line',
                somoth: true,
                dataFilter: 'average',
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

    <div id="main0" style="width: 100%;height: 500px">

    </div>

    <script>
        var myChart = echarts.init(document.getElementById('main0'));
        var option = {
            title: {
                text: ' 最高频次词出现次数：'
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
            yAxis: {
                type: 'value',
            },
            xAxis: {
                type: 'category',

                axisLabel: {
                    interval: 0,

                },
                data: [<%
            for(int i=0;i<mostList.size();i++){
                Map.Entry<String ,Integer> mapping=mostList.get(i);
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
            for(int i=0;i<mostList.size();i++){
                Map.Entry<String ,Integer> mapping=mostList.get(i);
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
                    position: 'top', //在上方显示
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

    <h3>
        分章节统计：
    </h3>
    <%
        for (int p = 0; p < resList.size(); p++) {
            List<Map.Entry<String, Integer>> list = resList.get(p);
    %>
    <div id="main<%=p+1%>" style="width: 100%;height: 400px">

    </div>
    <script>
        var myChart = echarts.init(document.getElementById('main<%=p+1%>'));
        var option = {
            title: {
                text: '第<%=p+1%>章'
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
            yAxis: {
                type: 'value',
                // inverse: true,


            },
            xAxis: {
                type: 'category',

                axisLabel: {
                    interval: 0,

                },
                data: [<%
            int m=0;
            if(key.equals("noKey")) m=30;
            else m=list.size();
            for(int i=0;i<m&&i<list.size();i++){
                Map.Entry<String ,Integer> mapping=list.get(i);
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
            for(int i=0;i<m&&i<list.size();i++){
                Map.Entry<String ,Integer> mapping=list.get(i);
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
                    position: 'top', //在上方显示
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
