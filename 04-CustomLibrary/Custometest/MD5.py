# 由于MD5模块在python3中被移除
# 在python3中使用hashlib模块进行md5操作

import hashlib

class MD5:
    def MD5(data,langer,md5_types):
        # 创建md5对象
        # m = hashlib.md5()
        # Tips
        # 此处必须encode
        # 若写法为m.update(str)  报错为： Unicode-objects must be encoded before hashing
        # 因为python3里默认的str是unicode
        # 或者 b = bytes(str, encoding='utf-8')，作用相同，都是encode为bytes
        # b = str.encode(encoding='utf-8')
        # m.update(b)
        # str_md5 = m.hexdigest()
        if langer == "英文":
            # str_md5 = hashlib.md5(b'this is a md5 test.').hexdigest()
            str_md5 = hashlib.md5("b'"+data+"'").hexdigest()
            print('MD5加密前为 ：' + data)
            print('MD5加密后为 ：' + str_md5)
            return str_md5
        elif langer == "中文":
            str_md5 = hashlib.md5('你好'.encode(encoding=md5_types)).hexdigest()
            return str_md5
            # utf8 和gbk 加密结构不一样
            # hashlib.md5('你好'.encode(encoding='GBK')).hexdigest()
            # hashlib.md5('你好'.encode(encoding='GB2312')).hexdigest()
            # hashlib.md5('你好'.encode(encoding='GB18030')).hexdigest()
if __name__ == '__main__':
    data = '小猪'
    langer = '中文'
    md5_types = 'GBK'
    a =MD5(data,langer,md5_types)
    print(a)
    b=r'C:\Users\小猪\AppData\Local\Programs\Python\Python37\Lib\site-packages\custometest\MD5.py'
    with open(b, encoding='utf-8') as f:
        text = f.read()
        print(text)