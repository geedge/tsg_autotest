*** Settings ***
Library           Smtp3Library

*** Keywords ***
EmailLogin
    [Arguments]    ${SURL}    ${SPORT}    ${SUSER}    ${SPWD}
    [Documentation]    [${SURL}:邮箱发送服务器，比如：腾讯企业邮箱：smtp.exmail.qq.com;qq邮箱：smtp.qq.com;163邮箱：smtp.163.com等]
    ...    [${SPORT}：邮箱发送服务器的端口，无论是哪种邮箱的，一般是25，该值可灵活填充]
    ...    [${SUSER}:邮箱登入用户名，无需转码]
    ...    [${SPWD}:登入密码。对于腾讯企业邮箱，密码无变化；qq邮箱需要第三方授权码登入；163邮箱需要第三方授权码登入]
    ...    [关键字返回值：这是163邮箱的返回结果：不同邮箱可能不太一样(235, b'Authentication successful')]
    [Tags]    function    email    send
    Prepare Connection    ${SURL}    ${SPORT}    ${SUSER}    ${SPWD}
    Connect
    Ehlo
    ${result}    logins
    run keyword if    "${result}"=="fail"    log    ${result}
    ...    ELSE    Quit    Close Connection
    #Quit
    #Close Connection
    [Return]    ${result}    # 返回登入结果

EmailSendFull
    [Arguments]    ${SURL}    ${SPORT}    ${SUSER}    ${PWD}    ${SUBJ}    ${FROM}    ${to}    ${cc}    ${bcc}    ${Sbody}    ${attach}
    [Documentation]    [注意：所有参数都是必填参数]
    ...    [${SURL}:邮箱发送服务器，比如：smtp.qq.com]
    ...    [${SPORT}:邮箱服务器，写法如：25]
    ...    [${SUSER}:登入名，如：zhangsan@qq.com]
    ...    [${PWD}:登入密码，不同类型的邮箱登入密码需求不一样，具体看EmailLogin关键字对于密码的要求]
    ...    [${SUBJ}：主题，如：111111]
    ...    [${FROM} :发送者，例如：zhangsan@qq.com]
    ...    [ ${to} :接收者，可以写多个，写法例如：["lisi@qq.com","wangwu@163.com"] ，若写单个接收者["lisi@qq.com"] ]
    ...    [${cc}:抄送者。可以写多个，写法同${to}]
    ...    [${bcc}:密送者。可以写多个，写法同${to}]
    ...    [${Sbody}:邮件正文，写法如：1234teacher]
    ...    [${attach}:附件文本，可以写多个，注意本地是否有这些文件。写法如:["1.txt","E://abc.txt"]]
    ...    [关键字返回值：发送成功会返回{}，空的内容]
    [Tags]    function    email    send
    Prepare Connection    ${SURL}    ${SPORT}    ${SUSER}    ${PWD}
    ${send_result}    Send Message With All Parameters    ${SURL}    ${SUSER}    ${PWD}    ${SUBJ}    ${FROM}    ${to}    ${cc}    ${bcc}    ${Sbody}    ${attach}
    Comment    Send Message
    Close Connection
    [Return]    ${send_result}    # 返回发送邮件结果
