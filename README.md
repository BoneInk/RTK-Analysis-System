# RTK-Analysis-System
基于Spring MVC+Mybatis的针对《三国演义》的一个人名，地名等的分析系统

---

## 主要功能：
1. 针对《三国演义》人名、地名和虚词进行分词统计和分析
2. 支持全篇和分章节进行检索
3. 统计结果通过EChart插件进行图表化显示
4. 支持注册登录

## 已知问题
1. 首页登录和注册按钮只能按一次，退出再点会闪退
2. 通过未注册的用户名直接登录会报错。
3. 检测登录状态的js脚本尚未完美
4. 进行分词检索的选择时，代码尚未所有可能的危险操作进行覆盖

## Bonus
支持导入自定义文档进行分析，在该情况下，仅支持自定义关键词或无筛选的分析，分章节统计时需要指定章节划分标志
