
#-*- coding:utf-8 -*-
'''
    created by hch 2019-06-26
'''
 
from custometest.printlog import printlog
from custometest.MD5 import MD5
from custometest.cmd_cer import Order
# from custometest.printlog import printlog

 
__version__ = '1.0'
 
class custometest(printlog,Order,MD5):
    ROBOT_LIBRARY_SCOPE = 'GLOBAL'
