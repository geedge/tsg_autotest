*** Settings ***
Documentation     写用例的话，直接调用关键字，输入关键字参数的值。
...               例如：想查询时间为2020-02-24 00:00:00 到2020-02-25 00:00:00 \ 的policy id为2409的log
...               1、创建一个case，
...               2、输入关键字Security Event Logs
...               3、输入必填参数的值（根据关键字里的要求填入相对应的值）
...               必填参数：${time1} | ${time2} | ${type1} | ${value} | ${element1}
...               ${time1}：为开始时间 \ ${time2}：为结束时间
...               ${type1}：为要查询的类型
...               ${value}：要查询的内容
...               ${element1}：想要获取信息的定位元素
...
...               4、直接运行该case
Library           Selenium2Library
Library           ExcelLibrary

*** Keywords ***
click
    [Arguments]    ${element}
    Click Element    ${element}

input
    [Arguments]    ${element}    ${text}
    Input Text    ${element}    ${text}

ui-login
    Open Browser    http://192.168.40.120    Chrome
    input    xpath=//*[@id="app"]/div/div[2]/div/div[2]/div/input    lyf
    input    xpath=//*[@id="app"]/div/div[2]/div/div[3]/div/input    111111
    click    xpath=//*[@id="app"]/div/div[2]/div/div[4]/button

ui-logout
    Close Browser

Security Event Logs
    [Arguments]    ${time1}    ${time2}    ${type1}    ${value}    ${element1}
    #打开浏览器
    #TSG-登录    lyf    111111
    Sleep    1
    click    id=children2    #点击一级目录log
    Sleep    1
    click    id=sidebarLog_SecurityEventLogs    #点击二级目录Security Event Logs
    sleep    1
    ${result}    ${text1}    Run Keyword And Ignore Error    text    #获取弹出框文本，进行异常处理
    run keyword if    '${result}'=='Pass'    run keywords    click    xpath=/html/body/div/div/div[3]/button
    sleep    1
    Clear Element Text    xpath=//*[@id="app"]/div/div[3]/div/div/div[2]/div/input[1]    #清空输入框
    sleep    1
    input    xpath=//*[@id="app"]/div/div[3]/div/div/div[2]/div/input[1]    ${time1}    #在输入框里输入时间 \ 格式为2020-02-24 18:21:01
    sleep    1
    Clear Element Text    xpath=//*[@id="app"]/div/div[3]/div/div/div[2]/div/input[2]    #清空输入框
    sleep    1
    input    xpath=//*[@id="app"]/div/div[3]/div/div/div[2]/div/input[2]    ${time2}    #在输入框里输入时间 \ 格式为2020-02-24 18:21:01
    sleep    1
    click    xpath=/html/body/div/div[2]/button[2]
    sleep    1
    click    id=one-input
    sleep    1
    click    ${type1}    #选择要查询的类型
    sleep    1
    input    id=sreach_input    ${value}    #在输入框输入查询数据
    sleep    1
    click    xpath=//*[@id="app"]/div/div[3]/div/div/div[1]/div/div[2]    #点击搜索按钮
    sleep    2
    ${result1}    ${text2}    Run Keyword And Ignore Error    text    #获取弹出框文本，进行异常处理
    run keyword if    '${result}'=='Pass'    run keywords    click    xpath=/html/body/div/div/div[3]/button
    sleep    1
    ${text3}    Get text    xpath=//*[@id="app"]/div/div[3]/div/div/div[7]/div/ul/li[1]/span
    #    Evaluate    ${text3}.replace('','Total: ')
    ${t}    Convert To Integer    ${text3}
    ${a1}    Evaluate    ${t}%20    #求余
    ${t1}=    Evaluate    math.ceil(${t}/20)    math    #求整（如果有余数会得出整数加1）
    ${t2}    Evaluate    ${t1}+1
    : FOR    ${j}    IN RANGE    1    ${t2}
    \    ForSElog    ${element1}    ${j}    ${t1}    ${a1}
    \    click    xpath=//*[@id="zhumingmingPageRight"]/i
    #关闭浏览器

text
    sleep    2
    ${text1}    Get Text    xpath=/html/body/div/div/div[3]/button/span

ForSElog
    [Arguments]    ${element}    ${j}    ${t1}    ${a1}
    : FOR    ${i}    IN RANGE    1    21
    \    log    ${i}
    \    click    xpath=//*[@id="ly-table1-listcontent"]/div/div[3]/table/tbody/tr[${i}]/td[3]
    \    sleep    2
    \    ${text4}    Get text    ${element}
    \    log    ${text4}
    \    click    id=securityEvent_logIdClose
    \    run keyword if    '${j}'=='${t1}'    log    yes
    \    IF1    ${i}    ${a1}

IF1
    [Arguments]    ${i}    ${a2}
    run keyword if    '${i}'=='${a2}'    Exit For Loop

Proxy Event Logs
    [Arguments]    ${time1}    ${time2}    ${type1}    ${value}    ${element1}
    #打开浏览器
    #TSG-登录    lyf    111111
    Sleep    1
    click    id=children2    #点击一级目录log
    Sleep    1
    click    id=sidebarLog_ProxyEventLogs    #点击二级目录ProxyEventLogs
    sleep    1
    ${result}    ${text1}    Run Keyword And Ignore Error    text1    #获取弹出框文本，进行异常处理
    run keyword if    '${result}'=='Pass'    run keywords    click    xpath=/html/body/div/div/div[3]/button
    #click    xpath=/html/body/div/div/div[3]/button
    Clear Element Text    id=d    #清空输入框
    sleep    1
    input    id=d    ${time1}    #在输入框里输入时间 \ 格式为2020-02-24 18:21:01
    sleep    1
    Clear Element Text    id=a    #清空输入框
    sleep    1
    input    id=a    ${time2}    #在输入框里输入时间 \ 格式为2020-02-24 18:21:01
    sleep    1
    click    xpath=/html/body/div/div[2]/button[2]    #点击时间组件的ok按钮
    sleep    1
    click    id=one-input    #点击查询输入框
    sleep    1
    click    ${type1}    #选择要查询的类型
    sleep    1
    input    id=sreach_input    ${value}    #在输入框输入查询数据
    sleep    1
    click    xpath=//*[@id="app"]/div/div[3]/div/div/div[1]/div/div[2]    #点击搜索按钮
    sleep    2
    ${result1}    ${text2}    Run Keyword And Ignore Error    text1    #获取弹出框文本，进行异常处理
    run keyword if    '${result}'=='Pass'    run keywords    click    xpath=/html/body/div/div/div[3]/button
    sleep    1
    ${text3}    Get text    xpath=//*[@id="app"]/div/div[3]/div/div/div[7]/div/ul/li[1]/span    #获取列表数量
    #    Evaluate    ${text3}.replace('','Total: ')
    ${t}    Convert To Integer    ${text3}    #text转换为int
    ${a1}    Evaluate    ${t}%20    #求余
    ${t1}=    Evaluate    math.ceil(${t}/20)    math    #求整（如果有余数会得出整数加1）
    ${t2}    Evaluate    ${t1}+1
    : FOR    ${j}    IN RANGE    1    ${t2}
    ForPElog    ${element1}    ${j}    ${t1}    ${a1}
    click    xpath=//*[@id="zhumingmingPageRight"]/i    #点击翻页
    #关闭浏览器

text1
    sleep    2
    ${text1}    Get Text    xpath=/html/body/div[3]/div/div[3]/button/span

SE logs-Export
    [Arguments]    ${time1}    ${time2}    ${type1}    ${value}    ${file}
    #打开浏览器
    #TSG-登录    lyf    111111
    Sleep    1
    click    id=children2    #点击一级目录log
    Sleep    1
    click    id=sidebarLog_SecurityEventLogs    #点击二级目录Security Event Logs
    sleep    1
    ${result}    ${text1}    Run Keyword And Ignore Error    text    #获取弹出框文本，进行异常处理
    run keyword if    '${result}'=='Pass'    run keywords    click    xpath=/html/body/div/div/div[3]/button
    #click    xpath=/html/body/div[2]/div/div[3]/button
    Clear Element Text    xpath=//*[@id="app"]/div/div[3]/div/div/div[2]/div/input[1]    #清空输入框
    sleep    1
    input    xpath=//*[@id="app"]/div/div[3]/div/div/div[2]/div/input[1]    ${time1}    #在输入框里输入时间 \ 格式为2020-02-24 18:21:01
    sleep    1
    Clear Element Text    xpath=//*[@id="app"]/div/div[3]/div/div/div[2]/div/input[2]    #清空输入框
    sleep    1
    input    xpath=//*[@id="app"]/div/div[3]/div/div/div[2]/div/input[2]    ${time2}    #在输入框里输入时间 \ 格式为2020-02-24 18:21:01
    sleep    1
    click    xpath=/html/body/div/div[2]/button[2]
    sleep    1
    click    id=one-input
    sleep    1
    click    ${type1}    #选择要查询的类型
    sleep    1
    input    id=sreach_input    ${value}    #在输入框输入查询数据
    sleep    1
    click    xpath=//*[@id="app"]/div/div[3]/div/div/div[1]/div/div[2]    #点击搜索按钮
    sleep    2
    ${result1}    ${text2}    Run Keyword And Ignore Error    text    #获取弹出框文本，进行异常处理
    run keyword if    '${result}'=='Pass'    ui-logout    else    log    有数据
    sleep    1
    ${text3}    Get text    xpath=//*[@id="app"]/div/div[3]/div/div/div[7]/div/ul/li[1]/span
    ${t}    Convert To Integer    ${text3}
    click    xpath=//*[@id="log_securityEventExport"]/i
    sleep    20
    Open Excel    ${file}    #打开Excel表
    sleep    2
    ${row}    Get Row Count    Sheet1    #获取Excel表的行数
    Should Be Equal As Numbers    ${row}    ${t}    #断言 \ 获取到的log列表数量和获取到的Excel表的行数对比

PE Logs-Export

Session Records
    [Arguments]    ${time1}    ${time2}    ${type1}    ${value}    ${element1}
    #打开浏览器
    #TSG-登录    lyf    111111
    Sleep    1
    click    id=children2    #点击一级目录log
    Sleep    1
    click    id=sidebarLog_SesssionRecords    #点击二级目录Session Records
    sleep    1
    ${result}    ${text1}    Run Keyword And Ignore Error    text    #获取弹出框文本，进行异常处理
    run keyword if    '${result}'=='Pass'    run keywords    click    xpath=/html/body/div/div/div[3]/button
    #    xpath=/html/body/div[2]/div/div[3]/button
    Clear Element Text    xpath=//*[@id="app"]/div/div[3]/div/div/div[2]/div/input[1]    #清空输入框
    sleep    1
    input    xpath=//*[@id="app"]/div/div[3]/div/div/div[2]/div/input[1]    ${time1}    #在输入框里输入时间 \ 格式为2020-02-24 18:21:01
    sleep    1
    Clear Element Text    xpath=//*[@id="app"]/div/div[3]/div/div/div[2]/div/input[2]    #清空输入框
    sleep    1
    input    xpath=//*[@id="app"]/div/div[3]/div/div/div[2]/div/input[2]    ${time2}    #在输入框里输入时间 \ 格式为2020-02-24 18:21:01
    sleep    1
    click    xpath=/html/body/div/div[2]/button[2]
    sleep    1
    ${result}    ${text1}    Run Keyword And Ignore Error    text    #获取弹出框文本，进行异常处理
    run keyword if    '${result}'=='Pass'    run keywords    click    xpath=/html/body/div/div/div[3]/button
    click    id=one-input
    sleep    1
    click    ${type1}    #选择要查询的类型
    sleep    1
    input    id=sreach_input    ${value}    #在输入框输入查询数据
    sleep    1
    click    xpath=//*[@id="app"]/div/div[3]/div/div/div[1]/div/div[2]    #点击搜索按钮
    sleep    2
    ${result1}    ${text2}    Run Keyword And Ignore Error    text    #获取弹出框文本，进行异常处理
    run keyword if    '${result}'=='Pass'    run keywords    click    xpath=/html/body/div/div/div[3]/button
    sleep    1
    ${text3}    Get text    xpath=//*[@id="app"]/div/div[3]/div/div/div[6]/div/ul/li[1]/span
    #    Evaluate    ${text3}.replace('','Total: ')
    ${t}    Convert To Integer    ${text3}
    ${a1}    Evaluate    ${t}%20    #求余
    ${t1}=    Evaluate    math.ceil(${t}/20)    math    #求整（如果有余数会得出整数加1）
    ${t2}    Evaluate    ${t1}+1
    : FOR    ${j}    IN RANGE    1    ${t2}
    ForSR    ${element1}    ${j}    ${t1}    ${a1}
    click    xpath=//*[@id="zhumingmingPageRight"]/i
    #关闭浏览器

ForPElog
    [Arguments]    ${element}    ${j}    ${t1}    ${a1}
    : FOR    ${i}    IN RANGE    1    21
    \    log    ${i}
    \    click    xpath=//*[@id="ly-table1-listcontent"]/div/div[3]/table/tbody/tr[${i}]/td[3]
    \    sleep    2
    \    ${text4}    Get text    ${element}
    \    log    ${text4}
    \    click    id=proxyEvent_logIdClose
    \    run keyword if    '${j}'=='${t1}'    log    yes
    \    IF1    ${i}    ${a1}

ForSR
    [Arguments]    ${element}    ${j}    ${t1}    ${a1}
    : FOR    ${i}    IN RANGE    1    21
    \    log    ${i}
    \    click    xpath=//*[@id="ly-table1-listcontent"]/div/div[3]/table/tbody/tr[${i}]/td[3]
    \    sleep    2
    \    ${text4}    Get text    ${element}
    \    log    ${text4}
    \    click    id=sessionRecords_logIdClose
    \    run keyword if    '${j}'=='${t1}'    log    yes
    \    IF1    ${i}    ${a1}
