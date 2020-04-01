import os
import subprocess
from time import sleep


class Order:
    def CMD(self,data):
        result = os.popen(data)
        # res = result.read().encoding('GBK')
        res = result.read()
        result.close()
        # res = res.decode("unicode-escape")
        return res
    def Linux(self):
        pass
    # 根据证书颁发者名字判断证书是否替换
    def Cert_Verification(self,data):
        c = []
        print(1)
        #with open(r'C:\Users\iiesoft\AppData\Local\Programs\Python\Python36\Lib\site-packages\custometest\certificate.yaml', 'r') as foo:
        with open(r'certificate.yaml', 'r') as foo:
            print(2)
            for line in foo.readlines():
                if data in line:
                    print(line)
                    c.append('证书已替换')
                else:
                    pass
            if '证书已替换' in c:
                # print('证书已替换')
                foo.close()
                return '证书已替换'
            else:
                # print('证书未替换')
                foo.close()
                return '证书未替换'

    def Content_Type(self,data):
        d = []
        with open('certificate.yaml', 'r') as foo:
            for line in foo.readlines():
                if data in line:
                    # print(line)
                    d.append('Content_Type已替换')
                else:
                    pass
            if 'Content_Type已替换' in d:
                # print('证书已替换')
                foo.close()
                return 'Content_Type已替换'
            else:
                # print('证书未替换')
                foo.close()
                return 'Content_Type未替换'
    # curl路由内容设置
    def curl_name(self,data):
        #curl_name = 'curl -kv -m 10 -1 --trace C:/Users/iiesoft/AppData/Local/Programs/Python/Python36/Lib/site-packages/custometest/certificate.yaml '+data+'| iconv -f utf-8 -t gbk'
        curl_name = 'curl -kv -m 10 -1 --trace certificate.yaml '+data+'| iconv -f utf-8 -t gbk'
        return curl_name
    # 控制器
    def manu(self,url,Certificate):
        # print(data['url'])
        n = 0
        while n != len(url):
            b = self.curl_name(url[n])
            d = self.CMD(b)
            # print(d)
            sleep(1)
            if Certificate != "":
                c =self.Cert_Verification(Certificate)
                # f = self.Content_Type(data["Content_Type"])
                sleep(1)
                assert_cer = url[n]+c
                # assert_Content_Type = data['Content_Type']+f
            n+=1
        return d,assert_cer
    
    def FTP(self, ftp_type):
        windows_path = os.getcwd()
        linux_path = os.getcwd().replace('\\', '/')
        # 判断FTP执行类型：（下载/登录）
        if ftp_type == "下载":
            # 调用cmd执行FTP下载文件
            data = 'curl -m 20 ftp://202.38.97.230/pub/iso/linux/knoppix/KNOPPIX_V7.7.1DVD-2016-10-22-EN/dpkg-l-dvd-771.txt -u"anonymous:chrome@example.com" -o zmmtext123.txt'
            d = self.CMD(data)
            sleep(5)
            fsize = os.path.getsize(linux_path + "/zmmtext123.txt")  # 435814
            if fsize == 435814:
                return "Success"
            else:
                return "Fail"
        elif ftp_type == "登录":
            data = 'curl -m 10 ftp://202.38.97.230/pub/iso/linux/knoppix/KNOPPIX_V7.7.1DVD-2016-10-22-EN/dpkg-l-dvd-771.txt -u"anonymous:chrome@example.com" | iconv -f utf-8 -t gbk'
            d = self.CMD(data)
            # print(d)
            if "Graphical (Xorg) program starter for ADRIANE" in d:
                return "Success"
            else:
                return "Fail"
    # FTP  下载
    def FTP_down(self, ftp_url,file_size,fiel_name):
        windows_path = os.getcwd()
        linux_path = os.getcwd().replace('\\', '/')
        # 判断FTP执行类型：（下载/登录）
        # 调用cmd执行FTP下载文件
        data = 'curl -m 20 '+ftp_url+ '-o '+ fiel_name + " ' "
        print(data)
        d = self.CMD(data)
        sleep(5)
        fsize = os.path.getsize(linux_path + "/"+fiel_name)  # 435814
        print(fsize)
        if fsize == file_size:
            return "Success"
        else:
            return "Fail"

    # FTP 登录
    def FTP_login(self, ftp_url,file_content):
        data = 'curl -m 10 '+ftp_url+' | iconv -f utf-8 -t gbk'
        d = self.CMD(data)
        # print(d)
        if file_content in d:
            return "Success"
        else:
            return "Fail"

if __name__ == '__main__':
    datas = {"url":['https://www.baidu.com'],
"Certificate":"Tango Secure Gateway CA",
# "Content_Type":"text/html",
'log':'Security Event Logs',
"sni":['baidu'],
"intercept_code":"200",
"log_code":"200",
"certifucate":"1",
"log_content":"true"
}
#     data= {"url":['https://www.baidu.com'],
# "Certificate":"Tango Secure Gateway CA"
#     }
    # url = ['https://www.baidu.com']
    # url = ['https://www.baidu.com']
    # url = ['https://www.baidu.com']
    # # Certificate1 = "Tango Secure Gateway CA"
    # Certificate = "baidu"
    # a='Tango Secure Gateway CA'
    # s = Order()
    # b = s.manu(url,Certificate)
    # print(b[1])
    # FTP下载 传入ftp的路径和文件大小
    ftp_url = 'ftp://202.38.97.230/pub/iso/linux/knoppix/KNOPPIX_V7.7.1DVD-2016-10-22-EN/dpkg-l-dvd-771.txt -u"anonymous:chrome@example.com" '
    ftp_size = 435814
    ftp_issue = s.FTP_down(ftp_url,ftp_size)
    # FTP登录 传入ftp的路径和文件内容
    ftp_url ='ftp://202.38.97.230/pub/iso/linux/knoppix/KNOPPIX_V7.7.1DVD-2016-10-22-EN/dpkg-l-dvd-771.txt -u"anonymous:chrome@example.com" '
    file_content = "Graphical (Xorg) program starter for ADRIANE"
    ftp_issue = s.FTP_login(ftp_url,file_content)
    # for i in b:
    #     print(i)
    # dd = s.CMD('curl -I https://www.baidu.com')
    # print(dd)
    # if "private, no-cache, no-store, proxy-revalidate, no-transform"in dd:
    #     print("ok")
    # a ='curl -kv -1 --trace certificate.yaml https://www.baidu.com | iconv -f utf-8 -t gbk'