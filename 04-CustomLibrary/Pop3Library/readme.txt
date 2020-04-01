导入方法：
1.将该目录放到....\Python\Lib\site-packages 下
2.在测试夹具里面要根据绝对路径导入此包


注意：
1.使用该包的关键字时不要用qq邮箱，qq邮箱测试发现时长会失灵现象，最好用163邮箱等
2.注意关闭邮箱的加密传送方式SSL协议
3.注意邮箱是否支持POP3的协议以及不同邮箱pop服务器的写法


关键字：
[return]  Recv Email  [user_name]  [pwd]   [pop server]  [sender] [subj_sub]
参数说明：
[user_name]：用户名
[pwd]：密码，第三方登入密码
[pop server]：pop服务器
[sender]：发送者邮箱，注意全称
[subj_sub]：主题的部分内容，这里是测主题是否包含该参数
[return]：返回值，成功返回success，失败返回n其他
该关键字默认等待3min，3min内每5s检测邮箱是否收到邮件，
若收到邮件与[sender]参数进行完全匹配，与[subj_sub]部分主题内容参数进行是否包含匹配，匹配成功则返回success；
若收到邮件匹配失败或者超时则返回其他，


若修改等待时间，可查找源码中的num变量将36改为其他值即可，注意时间粒度是5s，若num=3，则您修改的等待时间是15s
