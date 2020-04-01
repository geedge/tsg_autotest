#coding=utf-8
import	sys
reload(sys)
sys.setdefaultencoding("utf-8")

""" 变量文件操作 """

class	filetool():
	def	__init__(self):
		pass
	
	def	alter_dict(self, path, k, v):
		data = ''
		flag = True
		key = '${%s}' % (k)
		add = key + '\t%s' % (v) + '\n'		
		with open(path, 'r+') as f:
			for	line in f.readlines():
				if(line.find(key + '\t') == 0):
					line = add
					flag = False
				data += line
			if(flag):
				data += add
		print data		
		with open(path, 'w+') as f:
			f.writelines(data)			