import poplib
import base64
import time
from email.parser import Parser
# 用来解析邮件主题
from email.header import decode_header
# 用来解析邮件来源
from email.utils import parseaddr

from robot.api.deco import keyword
from robot.api import logger


class AcceptEmail(object):

    def __init__(self, user_email, password, pop3_server='serverDemon'):
        self.user_email = user_email
        self.password = password
        self.pop3_server = pop3_server

        self.connect_email_server()

    def connect_email_server(self):
        self.server = poplib.POP3(self.pop3_server)
        # 打印POP3服务器的欢迎文字，验证是否正确连接到了邮件服务器
        # print('连接成功 -- ', self.server.getwelcome().decode('utf8'))
        # +OK QQMail POP3 Server v1.0 Service Ready(QQMail v2.0)

        # 开始进行身份验证
        self.server.user(self.user_email)
        self.server.pass_(self.password)

    def __del__(self):
        # 关闭与服务器的连接，释放资源
        self.server.close()

    def get_email_count(self):
        # 返回邮件总数目和占用服务器的空间大小（字节数）， 通过stat()方法即可
        email_num, email_size = self.server.stat()
        # print("消息的数量: {0}, 消息的总大小: {1}".format(email_num, email_size))
        return email_num

    def receive_email_info(self, now_count=None):
        # 返回邮件总数目和占用服务器的空间大小（字节数）， 通过stat()方法即可
        email_num, email_size = self.server.stat()
        # print("消息的数量: {0}, 消息的总大小: {1}".format(email_num, email_size))
        self.email_count = email_num
        self.email_sumsize = email_size

        # 使用list()返回所有邮件的编号，默认为字节类型的串
        rsp, msg_list, rsp_siz = self.server.list()
        # print(msg_list, '邮件数量',len(msg_list))
        # print("服务器的响应: {0},\n消息列表： {1},\n返回消息的大小： {2}".format(rsp, msg_list, rsp_siz))
        # print('邮件总数： {}'.format(len(msg_list)))
        self.response_status = rsp
        self.response_size = rsp_siz

        # 下面获取最新的一封邮件,某个邮件下标(1开始算)
        # total_mail_numbers = len(msg_list)

        # 动态取消息
        total_mail_numbers = now_count

        rsp, msglines, msgsiz = self.server.retr(total_mail_numbers)
        # rsp, msglines, msgsiz = self.server.retr(1)
        # print("服务器的响应: {0},\n原始邮件内容： {1},\n该封邮件所占字节大小： {2}".format(rsp, msglines, msgsiz))

        # 从邮件原内容中解析
        msg_content = b'\r\n'.join(msglines).decode('utf-8')#gbk
        msg = Parser().parsestr(text=msg_content)
        self.msg = msg
        # print('解码后的邮件信息:\n{}'.format(msg))

    def recv(self, now_count=None):
        self.receive_email_info(now_count)
        self.parser()

    def get_email_title(self):
        subject = self.msg['Subject']
        value, charset = decode_header(subject)[0]
        if charset:
            value = value.decode(charset)
        # print('邮件主题： {0}'.format(value))
        self.email_title = value

    def get_sender_info(self):
        hdr, addr = parseaddr(self.msg['From'])
        # name 发送人邮箱名称， addr 发送人邮箱地址
        name, charset = decode_header(hdr)[0]
        if charset:
            name = name.decode(charset)
        self.sender_qq_name = name
        self.sender_qq_email = addr
        # print('发送人邮箱名称: {0}，发送人邮箱地址: {1}'.format(name, addr))

    def get_email_content(self):
        content = self.msg.get_payload()
        # 文本信息
        content_charset = content[0].get_content_charset()  # 获取编码格式
        text = content[0].as_string().split('base64')[-1]
        text_content = base64.b64decode(text).decode(content_charset)  # base64解码
        self.email_content = text_content
        # print('邮件内容: {0}'.format(text_content))

        # 添加了HTML代码的信息
        content_charset = content[1].get_content_charset()
        text = content[1].as_string().split('base64')[-1]
        # html_content = base64.b64decode(text).decode(content_charset)

        # print('文本信息: {0}\n添加了HTML代码的信息: {1}'.format(text_content, html_content))

    def parser(self):
        self.get_email_title()
        self.get_sender_info()
        #self.get_email_content()


def get_new_mail(user_name, pwd, pop3_server, second=5):
    t = AcceptEmail(user_name, pwd, pop3_server)
    now_count = t.get_email_count()
    #print('开启的时候的邮件数量为:%s' % now_count)
    logger.info("开启的时候的邮件数量为:"+str(now_count))
    # 每次需要重新连接邮箱服务器，才能获取到最新的消息
    # 默认每隔5秒看一次是否有新内容
    num = 0
    while True:
        obj = AcceptEmail(user_name, pwd, pop3_server)
        count = obj.get_email_count()
        if count > now_count:
            new_mail_count = count - now_count
            #print('有新的邮件数量:%s' % new_mail_count)
            logger.info("有新的邮件数量:"+str(new_mail_count))
            now_count += 1
            obj.recv(now_count)

            yield {"title": obj.email_title, "sender": obj.sender_qq_name, "sender_email": obj.sender_qq_email}  
            #yield {"title": obj.email_title, "sender": obj.sender_qq_name, "sender_email": obj.sender_qq_email,
            #       "email_content": obj.email_content}
            if new_mail_count > 0:
                return
                # print('-' * 30)
                # print("邮件主题:%s\n发件人:%s\n发件人邮箱:%s\n邮件内容:%s" % (
                #     obj.email_title, obj.sender_qq_name, obj.sender_qq_email, obj.email_content))
                # print('-' * 30)

        #else:
             #print('没有任何新消息.')
        #logger.info("没有任何新消息.")
        time.sleep(second)
        num += 1
        if num == 36:#等待时间粒度，一个粒度是5s，如果num=10意思就是等待接收邮件50s，若没有邮件就返回;36是等待3min
            return


@keyword('Recv Email')
def recv_email(user_name, pwd, pop3_server, send_user, subj):
    '''
        参数说明：
        [user_name]：用户名
        [pwd]：密码，第三方登入密码
        [pop server]：pop服务器
        [sender]：发送者邮箱，注意全称
        [subj_sub]：主题的部分内容，这里是测主题是否包含该参数
        [return]：返回值，成功返回success，失败返回n其他
        其他问题请阅读该库的readme.txt
    '''
    dic = {}
    logger.info("正在监听邮件服务器端是否有新消息---")
    #print('正在监听邮件服务器端是否有新消息---')
    try:
        iterator = get_new_mail(user_name, pwd, pop3_server)
    except TypeError:
        #print('监听的内容有误，有图片数据等,无法解析而报错，不是纯文本内容')
        logger.info("监听的内容有误，有图片数据等,无法解析而报错，不是纯文本内容")
        return  "fail"
    else:
        for dic in iterator:
            #print("邮件主题:%s\n发件人:%s\n发件人邮箱:%s\n邮件内容:%s" % (
            #    dic["title"], dic["sender"], dic["sender_email"], dic["email_content"]))
            #logger.info("邮件主题: " + str(dic["title"]) + " 发件人: " + str(dic["sender"])+"发件人邮箱:"+str(dic["sender_email"]))
            if  dic["sender"] == send_user:
                #logger.info("发送者一样")
                if subj in dic["title"]:
                   #logger.info("主题也包含")
                    return "success" 
                else:
                    #logger.info("主题不包含")
                    return "fail"
            else:
                return "fail"
            

#if __name__ == '__main__':
#    user = 'xxxx@qq.com'
#    pwd = 'xxxx'
#    pop3_server = 'pop.qq.com'
#    send_user = 'zlking_2019@163.com'
#    subj = 'or2020'
#    result = recv_email(user, pwd, pop3_server, send_user, subj)
#    print(result)