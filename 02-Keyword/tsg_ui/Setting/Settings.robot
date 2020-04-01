*** Settings ***
Library           Selenium2Library
Library           E:/Program Files (x86)/Python37-32/Lib/site-packages/robot/libraries/String.py

*** Keywords ***
click
    [Arguments]    ${element}
    Click Element    ${element}

input
    [Arguments]    ${element}    ${text}
    Input Text    ${element}    ${text}

ui-logout
    Close Browser

ui-login
    Open Browser    http://192.168.40.120    Chrome
    input    xpath=//*[@id="app"]/div/div[2]/div/div[2]/div/input    lyf
    input    xpath=//*[@id="app"]/div/div[2]/div/div[3]/div/input    111111
    click    xpath=//*[@id="app"]/div/div[2]/div/div[4]/button

Create-Hijack Files
    [Arguments]    ${name}    ${file}    ${type}
    Sleep    1
    click    id=children5    #点击一级目录Settings
    Sleep    1
    click    id=sidebarProxy_Profiles    #点击二级目录Proxy Profiles
    Sleep    2
    click    id=profilesTabs_Profile_HijackFiles    #点击Hijack Files按钮
    Sleep    1
    click    id=hijackAdd    #点击Create
    Sleep    2
    input    id=hijack_profileName    ${name}    #输入name
    Sleep    2
    Choose File    xpath=//*[@id="app"]/div/div[3]/div/div/div[2]/div[1]/div[2]/form/div[2]/div/div/div[1]/input    ${file}    #上传文件
    Sleep    2
    click    id=hijackAddContentType    #点击+ 打开侧滑窗口
    Sleep    1
    click    ${type}    #选择文件类型
    sleep    2
    click    id=hijackAddOk    #点击OK
    Sleep    2
    input    id=one-input    ${name}    #搜索输入框输入name
    Sleep    1
    click    id=select_new_search_btn    #点击搜索按钮
    Sleep    1
    ${text1}    Get Text    xpath=//*[@id="ly-table1-listcontent"]/div/div[3]/table/tbody/tr/td[2]/div/span    #获取点击后页面文本信息
    Should Be Equal As Strings    ${text1}    ${name}    #断言

Create-Insert Scripts
    [Arguments]    ${name}    ${file}    ${type}
    Sleep    1
    click    id=children5    #点击一级目录Settings
    Sleep    1
    click    id=sidebarProxy_Profiles    #点击二级目录Proxy Profiles
    Sleep    2
    click    id=profilesTabs_Profile_Insert    #点击Insert Scripts按钮
    Sleep    1
    click    id=insertAdd    #点击Create
    Sleep    2
    input    id=insert_profileName    ${name}    #输入name
    Sleep    2
    Choose File    xpath=//*[@id="insertAddUpload"]/div[1]/input    ${file}    #上传文件
    Sleep    2
    click    id=insert_select_format    #点击下拉框按钮
    Sleep    1
    click    ${type}    #选择css
    sleep    1
    click    xpath=//*[@id="policy_Manipulation_create8"]/div[2]/form/div[5]/div/div/button[1]    #点击OK
    Sleep    1
    input    xpath=//*[@id="one-input"]    ${name}    #搜索输入框输入name
    Sleep    1
    click    xpath=//*[@id="app"]/div/div[3]/div/div/div[2]/div[1]/div[2]/div[2]/i    #点击搜索按钮
    Sleep    1
    ${text1}    Get Text    xpath=//*[@id="app"]/div/div[3]/div/div/div[2]/div[2]/div/div[3]/table/tbody/tr[1]/td[2]/div/div/span    #获取点击后页面文本信息
    Should Be Equal As Strings    ${text1}    ${name}    #断言
    ui-logout

Create-Traffic Mirror Profiles
    [Arguments]    ${name}    ${type}    ${shuru}
    Sleep    1
    click    id=children5    #点击一级目录Settings
    Sleep    1
    click    id=sidebarProxy_Profiles    #点击二级目录Proxy Profiles
    Sleep    2
    click    id=profilesTabs_Profile_TrafficMirrorProfiles    #点击Traffic Mirror Profiles按钮
    Sleep    1
    click    id=trafficMirrorAdd    #点击Create
    Sleep    2
    input    id=trafficmirror_profileName    ${name}    #输入name
    Sleep    2
    click    xpath=//*[@id="app"]/div/div[3]/div/div/div[2]/div/div[2]/form/div[2]/div/div/div[1]/span/span/i    #点击下拉框
    Sleep    2
    click    ${type}    #选择vlan或者mac
    Sleep    1
    input    id=trafficmirror_addrArray0    ${shuru}
    sleep    2
    click    xpath=//*[@id="app"]/div/div[3]/div/div/div[2]/div/div[2]/form/div[5]/div/div/button[1]    #点击OK
    Sleep    2
    input    id=one-input    ${name}    #搜索输入框输入name
    Sleep    1
    click    id=select_new_search_btn    #点击搜索按钮
    Sleep    1
    ${text1}    Get Text    xpath=//*[@id="app"]/div/div[3]/div/div/div[2]/div[2]/div/div[3]/table/tbody/tr/td[2]/div/div/span    #获取点击后页面文本信息
    Should Be Equal As Strings    ${text1}    ${name}    #断言
    ui-logout

Edit-Insert Scripts
    [Arguments]    ${id-name}    ${name}    ${name1}    ${file}    ${type}
    [Documentation]    引用关键字，填入必填参数
    ...    必填参数：
    ...    ${id-name}:为选择要查询的类型是ID或者Name的元素
    ...    ${name}:为查询输入框输入内容
    ...    ${name1}:为修改页面的name输入框里输入的内容
    ...    ${file}:为修改页面要上传文件的路径
    ...    ${type}:选择文件类型的元素
    Sleep    1
    click    xpath=//*[@id="app"]/div/div[2]/ul/li[6]/div    #点击一级目录Settings
    Sleep    1
    click    id=sidebarProxy_Profiles    #点击二级目录Proxy Profiles
    Sleep    2
    click    id=profilesTabs_Profile_Insert    #点击Insert files按钮
    sleep    1
    click    id=one-input    #搜索点击输入框
    sleep    1
    click    ${id-name}    #选择ID或者name
    sleep    1
    input    id=sreach_input    ${name}    #输入搜索内容
    sleep    1
    click    xpath=//*[@id="select_new_search_btn"]    #点击搜索按钮
    sleep    1
    click    xpath=//*[@id="app"]/div/div[3]/div/div/div[2]/div[2]/div/div[3]/table/tbody/tr[1]    #点击搜素到的列表
    sleep    1
    click    id=insertEdit    #点击Edit
    sleep    1
    Clear Element Text    id=insert_profileName    #清空输入框
    sleep    1
    input    id=insert_profileName    ${name1}    #输入框输入
    sleep    1
    Choose File    xpath=//*[@id="insertAddUpload"]/div[1]/input    ${file}    #上传文件
    sleep    1
    click    id=insert_select_format    #点击下拉框
    sleep    1
    click    ${type}    #选择文件类型
    sleep    1
    click    xpath=//*[@id="policy_Manipulation_create8"]/div[2]/form/div[8]/div/div/button[1]    #点击ok提交

Create-Response Pages
    [Arguments]    ${name}    ${file}
    [Documentation]    引用次关键字，填入必填参数
    ...    必填参数：
    ...    ${name}:新建页面name输入框里的内容
    ...    ${file}：上传文件所在本地的路径
    #打开浏览器
    #ui-login    lyf    111111
    Sleep    1
    click    id=children5    #点击一级目录Settings
    Sleep    1
    click    id=sidebarProxy_Profiles    #点击二级目录Proxy Profiles
    Sleep    2
    click    id=respinseAdd    #Response Pages点击Create
    Sleep    2
    input    id=responsepages_profileName    ${name}    #输入name
    Sleep    2
    Choose File    xpath=//*[@id="policy_Manipulation_create6"]/div[2]/form/div[2]/div/div/div/input    ${file}    #上传文件
    Sleep    2
    click    xpath=//*[@id="policy_Manipulation_create6"]/div[2]/form/div[4]/div/div/button[1]    #点击OK缇交
    Sleep    1
    input    xpath=//*[@id="one-input"]    ${name}    #搜索框输入
    Sleep    1
    click    xpath=//*[@id="app"]/div/div[3]/div/div/div[2]/div[1]/div[1]/div[2]/i    #点击搜索按钮
    Sleep    1
    ${text1}    Get Text    xpath=//*[@id="ly-table1-listcontent"]/div/div[3]/table/tbody/tr/td[2]/div/div/span    #获取点击后页面文本信息
    Should Be Equal As Strings    ${text1}    ${name}    #断言
    #ui-logout

Edit-Response Pages
    [Arguments]    ${id-name}    ${name}    ${name1}    ${file}
    [Documentation]    引用关键字，填入必填参数
    ...    必填参数：
    ...    ${id-name}:为选择要查询的类型是ID或者Name的元素
    ...    ${name}:为查询输入框输入内容
    ...    ${name1}:为修改页面的name输入框里输入的内容
    ...    ${file}:为修改页面要上传文件的路径
    Sleep    1
    click    xpath=//*[@id="app"]/div/div[2]/ul/li[6]/div    #点击一级目录Settings
    Sleep    1
    click    id=sidebarProxy_Profiles    #点击二级目录Proxy Profiles
    Sleep    2
    click    id=one-input    #搜索点击输入框
    sleep    1
    click    ${id-name}    #选择ID或者name
    sleep    1
    input    id=sreach_input    ${name}
    sleep    1
    click    xpath=//*[@id="ly-table1-listcontent"]/div/div[3]/table/tbody/tr[1]    #点击搜素到的列表
    sleep    1
    click    id=resinseEdit    #点击Edit
    sleep    1
    Clear Element Text    id=responsepages_profileName    #清空name输入框
    sleep    1
    input    id=responsepages_profileName    ${name1}
    sleep    1
    Choose File    xpath=//*[@id="policy_Manipulation_create6"]/div[2]/form/div[5]/div/div/div/input    ${file}
    sleep    1
    click    xpath=//*[@id="policy_Manipulation_create6"]/div[2]/form/div[7]/div/div/button[1]

Edit-Hijack Files
    [Arguments]    ${id-name}    ${name}    ${name1}    ${file}    ${type}
    [Documentation]    引用关键字，填入必填参数
    ...    必填参数：
    ...    ${id-name}:为选择要查询的类型是ID或者Name的元素
    ...    ${name}:为查询输入框输入内容
    ...    ${name1}:为修改页面的name输入框里输入的内容
    ...    ${file}:为修改页面要上传文件的路径
    ...    ${type}:为文件类型的元素
    Sleep    1
    click    xpath=//*[@id="app"]/div/div[2]/ul/li[6]/div    #点击一级目录Settings
    Sleep    1
    click    id=sidebarProxy_Profiles    #点击二级目录Proxy Profiles
    Sleep    2
    click    id=profilesTabs_Profile_HijackFiles    #点击Hijack files按钮
    sleep    1
    click    id=one-input    #搜索点击输入框
    sleep    1
    click    ${id-name}    #选择ID或者name
    sleep    1
    input    id=sreach_input    ${name}    #输入搜索内容
    sleep    1
    click    xpath=//*[@id="select_new_search_btn"]    #点击搜索按钮
    sleep    1
    click    xpath=//*[@id="ly-table1-listcontent"]/div/div[3]/table/tbody/tr[1]    #点击搜素到的列表
    sleep    1
    click    id=hijackEdit    #点击Edit
    sleep    1
    Clear Element Text    id=hijack_profileName    #清空输入框
    sleep    1
    input    id=hijack_profileName    ${name1}    #输入框输入
    sleep    1
    Choose File    xpath=//*[@id="app"]/div/div[3]/div/div/div[2]/div[1]/div[2]/form/div[5]/div/div/div[1]/input    ${file}    #上传文件
    sleep    1
    click    id=hijackAddContentType    #点击+号打开侧滑框
    sleep    3
    click    ${type}    #选择类型
    sleep    1
    click    xpath=//*[@id="app"]/div/div[3]/div/div/div[2]/div[2]/div/div[2]/button    #关闭侧滑框
    sleep    1
    click    id=hijackAddOk    #点击ok提交

Edit-Traffic Mirror Profiles
    [Arguments]    ${id-name}    ${name}    ${name1}    ${type}    ${shuju}
    [Documentation]    引用关键字，填入必填参数
    ...    必填参数：
    ...    ${id-name}:为选择要查询的类型是ID或者Name的元素
    ...    ${name}:为查询输入框输入内容
    ...    ${name1}:为修改页面的name输入框里输入的内容
    ...    ${type}:为选择点击vlan或mac的元素
    ...    ${shuju}:为输入框输入内容
    Sleep    1
    click    xpath=//*[@id="app"]/div/div[2]/ul/li[6]/div    #点击一级目录Settings
    Sleep    1
    click    id=sidebarProxy_Profiles    #点击二级目录Proxy Profiles
    Sleep    2
    click    id=profilesTabs_Profile_TrafficMirrorProfiles    #点击Traffic Mirror Profiles按钮
    sleep    1
    click    id=one-input    #搜索点击输入框
    sleep    1
    click    ${id-name}    #选择ID或者name
    sleep    1
    input    id=sreach_input    ${name}    #输入搜索内容
    sleep    1
    click    xpath=//*[@id="select_new_search_btn"]    #点击搜索按钮
    sleep    1
    click    xpath=//*[@id="app"]/div/div[3]/div/div/div[2]/div[2]/div/div[3]/table/tbody/tr[1]    #点击搜素到的列表
    sleep    1
    click    id=trafficMirrorEdit    #点击Edit
    sleep    1
    Clear Element Text    id=trafficmirror_profileName    #清空输入框
    sleep    1
    input    id=trafficmirror_profileName    ${name1}    #输入框输入
    sleep    1
    click    xpath=//*[@id="app"]/div/div[3]/div/div/div[2]/div/div[2]/form/div[5]/div/div/div[1]/input    #点击下拉框
    sleep    1
    click    ${type}    #选择vlan或者mac
    sleep    1
    Clear Element Text    id=trafficmirror_addrArray0    #清空输入框
    sleep    1
    input    id=trafficmirror_addrArray0    ${shuju}    #输入内容
    sleep    1
    click    xpath=//*[@id="app"]/div/div[3]/div/div/div[2]/div/div[2]/form/div[8]/div/div/button[1]    #点击ok

import-Trusted Certificate Authorities
    [Arguments]    ${name}    ${file}
    [Documentation]    引用次关键字，填入必填参数
    ...    必填参数：
    ...    ${name}:新建页面name输入框里的内容
    ...    ${file}：上传文件所在本地的路径
    #打开浏览器
    #ui-login    lyf    111111
    Sleep    1
    click    id=children5    #点击一级目录Settings
    Sleep    1
    click    id=sidebarProxy_CertificateManagement    #点击二级目录Trusted Certificate Authorities
    Sleep    2
    click    id=Authorities_create    #点击Import
    Sleep    2
    input    id=authoritiesAdd_name    ${name}    #输入name
    Sleep    2
    Choose File    xpath=//*[@id="upload_dome"]/div/input    ${file}    #上传文件
    Sleep    2
    click    id=authoritiesAdd_sub    #点击OK缇交
    Sleep    1
    input    xpath=//*[@id="one-input"]    ${name}    #搜索框输入
    Sleep    1
    click    id=select_new_search_btn    #点击搜索按钮
    Sleep    1
    ${text1}    Get Text    xpath=//*[@id="ly-table1-listcontent"]/div/div[3]/table/tbody/tr/td[2]/div/div/div/p/span    #获取点击后页面文本信息
    Should Be Equal As Strings    ${text1}    ${name}    #断言
    #ui-logout

Create-Decryption Keyrings
    [Arguments]    ${name}    ${file}    ${file1}    ${1or2}    ${type}    ${type1}
    [Documentation]    引用次关键字，填入必填参数
    ...    必填参数：
    ...    ${name}:新建页面name输入框里的内容
    ...    ${file}：上传文件所在本地的路径
    ...    ${file1}:上传文件所在本地的路径
    ...    ${1or2}:填入1 或者其他
    ...    ${type}:上传证书类型的元素
    ...    ${type1}:上传证书加密解密算法的元素
    #打开浏览器
    #ui-login    lyf    111111
    Sleep    1
    click    id=children5    #点击一级目录Settings
    Sleep    1
    click    id=sidebarProxy_CertificateManagement    #点击二级目录Trusted Certificate Authorities
    Sleep    2
    click    xpath=//*[@id="proxyTabs"]/div/ul/li[2]    #点击Decryption Keyrings
    sleep    1
    click    id=Keyrings_create    #点击Create
    Sleep    2
    input    id=keyringsadd_name    ${name}    #输入name
    Sleep    2
    Choose File    xpath=//*[@id="app"]/div/div[3]/div/div/div[2]/div/div[2]/form/div[2]/div/div/div/input    ${file}    #上传文件
    Sleep    2
    Choose File    xpath=//*[@id="app"]/div/div[3]/div/div/div[2]/div/div[2]/form/div[4]/div/div/div/input    ${file1}    #上传文件
    ${select}    Set Variable    ${1or2}
    Run Keyword If    '${select}'=='1'    click    id=keyringsadd_customized
    Run Keyword If    '${select}'=='1'    input    id=reissueExpiryDate    10
    sleep    1
    click    xpath=//*[@id="app"]/div/div[3]/div/div/div[2]/div/div[2]/form/div[7]/div/div/div[1]    #点击下拉框
    sleep    1
    click    ${type}    #选择证书类型
    sleep    1
    click    xpath=//*[@id="app"]/div/div[3]/div/div/div[2]/div/div[2]/form/div[8]/div/div/div[1]    #点击下拉框
    sleep    1
    click    ${type1}    #选择加密解密类型
    sleep    1
    click    id=keyringsadd_sub    #点击OK缇交
    Sleep    1
    input    xpath=//*[@id="one-input"]    ${name}    #搜索框输入
    Sleep    1
    click    id=select_new_search_btn    #点击搜索按钮
    Sleep    1
    ${text1}    Get Text    xpath=//*[@id="ly-table1-listcontent"]/div/div[3]/table/tbody/tr/td[2]/div/div/div/p/span    #获取点击后页面文本信息
    Should Be Equal As Strings    ${text1}    ${name}    #断言
    #ui-logout

Create-SSL Decryption Exclusion
    [Arguments]    ${name}    ${value}    ${name1}
    [Documentation]    引用次关键字，填入必填参数
    ...    必填参数：
    ...    ${name}:新建页面name输入框里的内容
    ...    ${value}:输入内容
    ...    ${naem1}:搜索框填入内容
    Sleep    1
    click    id=children5    #点击一级目录Settings
    Sleep    1
    click    id=sidebarProxy_CertificateManagement    #点击二级目录Trusted Certificate Authorities
    Sleep    2
    click    xpath=//*[@id="proxyTabs"]/div/ul/li[3]    #点击SSL Decryption Exclusion按钮
    sleep    1
    click    id=ssl_create    #点击Create
    Sleep    2
    input    id=sslAdd_name    ${name}    #输入name
    Sleep    2
    input    id=sslAdd_itemDesc    ${value}    #输入内容
    Sleep    2
    click    id=ssl_ok    #点击OK缇交
    Sleep    1
    input    xpath=//*[@id="one-input"]    ${name1}    #搜索框输入
    Sleep    1
    click    id=select_new_search_btn    #点击搜索按钮
    Sleep    1
    ${text1}    Get Text    xpath=//*[@id="ly-table1-listcontent"]/div/div[3]/table/tbody/tr/td[2]/div/div/div/p/span    #获取点击后页面文本信息
    Should Be Equal As Strings    ${text1}    ${name}    #断言

Search-Cached Intermediate Certificates
    [Arguments]    ${type}    ${id-sni}    ${enabled}
    [Documentation]    引用关键字，填入必填参数
    ...    ${type}:为搜索类型的元素（id或sni）
    ...    ${enabled}：为enabled开启或关闭按钮的元素
    Sleep    1
    click    id=children5    #点击一级目录Settings
    Sleep    1
    click    id=sidebarProxy_CertificateManagement    #点击二级目录Trusted Certificate Authorities
    Sleep    2
    click    xpath=//*[@id="proxyTabs"]/div/ul/li[4]    #点击Cached Intermediate Certificates按钮
    Sleep    1
    click    id=one-input    #点击搜索框
    Sleep    1
    click    ${type}
    Sleep    1
    input    id=sreach_input    ${id-sni}
    click    id=select_new_search_btn    #点击搜索按钮
    Sleep    1
    click    xpath=//*[@id="ly-table1-listcontent"]/div/div[3]/table/tbody/tr/td[8]/div/div/div/p/a/i    #点击下载
    Sleep    10
    click    ${enabled}    #点击enabled按钮
    sleep    1

Edit-Trusted Certificate Authorities
    [Arguments]    ${id-name}    ${value}    ${name}    ${file}
    [Documentation]    引用关键字，填入必填参数
    ...    必填参数：
    ...    ${id-name}:为选择要查询的类型是ID或者Name的元素
    ...    ${value}:为查询输入框输入内容
    ...    ${name}:为修改页面的name输入框里输入的内容
    ...    ${file}:为修改页面要上传文件的路径
    Sleep    1
    click    id=children5    #点击一级目录Settings
    Sleep    1
    click    id=sidebarProxy_CertificateManagement    #点击二级目录Trusted Certificate Authorities
    Sleep    2
    click    id=one-input    #点击搜索框
    sleep    1
    click    ${id-name}    #选择搜索类型
    sleep    1
    input    id=sreach_input    ${value}    #输入内容
    sleep    1
    click    id=select_new_search_btn    #点击搜索按钮
    sleep    1
    click    xpath=//*[@id="ly-table1-listcontent"]/div/div[3]/table/tbody/tr    #点击搜索列表
    sleep    1
    click    id=Authorities_edit    #点击Edit按钮
    sleep    1
    Clear Element Text    id=authoritiesAdd_name    #清空name输入框
    sleep    1
    input    id=authoritiesAdd_name    ${name}    #输入name
    sleep    1
    Choose File    xpath=//*[@id="upload_dome"]/div/input    ${file}    #上传文件
    sleep    1
    click    id=authoritiesAdd_sub    #点击ok

Edit-Decryption Keyrings
    [Arguments]    ${id-name}    ${value}    ${name}    ${file}    ${file1}    ${1or2}
    ...    ${type}    ${type1}
    [Documentation]    引用次关键字，填入必填参数
    ...    必填参数：
    ...    ${id-name}:为选择要查询的类型是ID或者Name的元素
    ...    ${value}:为查询输入框输入内容
    ...    ${name}:新建页面name输入框里的内容
    ...    ${file}：上传文件所在本地的路径
    ...    ${file1}:上传文件所在本地的路径
    ...    ${1or2}:填入1 或者其他
    ...    ${type}:上传证书类型的元素
    ...    ${type1}:上传证书加密解密算法的元素
    Sleep    1
    click    id=children5    #点击一级目录Settings
    Sleep    1
    click    id=sidebarProxy_CertificateManagement    #点击二级目录Trusted Certificate Authorities
    Sleep    2
    click    xpath=//*[@id="proxyTabs"]/div/ul/li[2]    #点击Decryption Keyrings
    sleep    1
    click    id=one-input    #点击搜索框
    sleep    1
    click    ${id-name}    #选择搜索类型
    sleep    1
    input    id=sreach_input    ${value}    #输入内容
    sleep    1
    click    id=select_new_search_btn    #点击搜索按钮
    sleep    1
    click    xpath=//*[@id="ly-table1-listcontent"]/div/div[3]/table/tbody/tr    #点击搜索列表
    sleep    1
    click    id=Keyrings_edit    #点击Edit按钮
    sleep    1
    Clear Element Text    id=keyringsadd_name    #清空name输入框
    sleep    1
    input    id=keyringsadd_name    ${name}    #输入name
    sleep    1
    Choose File    xpath=//*[@id="app"]/div/div[3]/div/div/div[2]/div/div[2]/form/div[5]/div/div/div/input    ${file}    #上传文件
    Sleep    2
    Choose File    xpath=//*[@id="app"]/div/div[3]/div/div/div[2]/div/div[2]/form/div[7]/div/div/div/input    ${file1}    #上传文件
    ${select}    Set Variable    ${1or2}
    Run Keyword If    '${select}'=='1'    click    id=keyringsadd_customized
    Run Keyword If    '${select}'=='1'    input    id=reissueExpiryDate    10
    sleep    1
    click    xpath=//*[@id="app"]/div/div[3]/div/div/div[2]/div/div[2]/form/div[10]/div/div/div[1]    #点击下拉框
    sleep    1
    click    ${type}    #选择证书类型
    sleep    1
    click    xpath=//*[@id="app"]/div/div[3]/div/div/div[2]/div/div[2]/form/div[11]/div/div/div[1]    #点击下拉框
    sleep    1
    click    ${type1}    #选择加密解密类型
    sleep    1
    click    id=keyringsadd_sub    #点击OK缇交

Edit-SSL Decryption Exclusion
    [Arguments]    ${id-name}    ${value}    ${name}    ${value1}
    [Documentation]    引用关键字，填入必填参数
    ...    ${id-name}:id或者name的元素
    ...    ${value}:输入搜索的内容
    ...    ${name}:输入name
    ...    ${calue1}:输入内容
    Sleep    1
    click    id=children5    #点击一级目录Settings
    Sleep    1
    click    id=sidebarProxy_CertificateManagement    #点击二级目录Trusted Certificate Authorities
    Sleep    2
    click    xpath=//*[@id="proxyTabs"]/div/ul/li[3]    #点击SSL Decryption Exclusion按钮
    sleep    1
    click    id=one-input    #点击搜索框
    sleep    1
    click    ${id-name}    #选择搜索类型
    sleep    1
    input    id=sreach_input    ${value}    #输入内容
    sleep    1
    click    id=select_new_search_btn    #点击搜索按钮
    sleep    1
    click    xpath=//*[@id="ly-table1-listcontent"]/div/div[3]/table/tbody/tr    #点击搜索列表
    Sleep    1
    click    id=ssl_edit    #点击Edit
    Sleep    1
    Clear Element Text    id=sslAdd_name    #清空name输入框
    sleep    1
    input    id=sslAdd_name    ${name}    #输入name
    sleep    1
    input    id=sslAdd_itemDesc    ${value1}    #输入内容
    Sleep    2
    click    id=ssl_ok    #点击OK缇交
