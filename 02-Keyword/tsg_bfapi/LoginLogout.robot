*** Settings ***
Resource          ../../03-Variable/BifangApiVariable.txt
Library           REST    http://${host}:${port}
Library           Collections
Library           SSHLibrary    
Resource          PolicyObject.robot
Resource          ../tsg_ui/Logout/Logout.robot
Resource          ../tsg_ui/Login/Login.robot
Resource    Tag.robot

*** Keywords ***
Login
    #[Arguments]    ${username}    ${password}    ${authmode}    ${authCode}    ${ldapId}
    # 毕方接口用户名密码
    GET    /v1/user/encryptpwd?password=${password}
    Object    response body
    #OUTPUT    response body
    #${rescode}    Integer    $.code
    Integer    $.code    200
    #log    ${rescode}
    ${pwd}    String    $.data.encryptpwd
    #log    ${pwd}
    ${pwdstr}    Get From List    ${pwd}    0
    #log    aaaaaaa
    log    ${pwdstr}
    #log    bbb
    SET GLOBAL VARIABLE    ${encodePassword}    ${pwdstr}
    #log    aaaaaaa
    log    ${encodePassword}
    #log    aaaaaaa
    #log    ${host}:${port}
    #getToken##################################################################################
    #log    ${username}
    #log    ${pwdstr}
    POST    /v1/user/login?username=${username}&password=${encodePassword}&authMode=${authmode}
    Object    response body
    #OUTPUT    response body
    Integer    $.code    200
    #${rescodelist}    Integer    $.code
    #${rescode}    Get From List    ${rescodelist}    0
    ${rescode}    Integer    $.code
    log    ${rescode}
    ${tokenGlobal}    String    $.data.token
    ${tokenStr}    Get From List    ${tokenGlobal}    0
    log    ${tokenStr}
    SET GLOBAL VARIABLE    ${token}    ${tokenStr}
    log    ${token}
    SET GLOBAL VARIABLE    ${headers}    {"Contest-Type":"application/json","Authorization":"${token}"}
    #Return    ${rescode}

Logout
    POST    /v1/user/logout    headers=${headers}
    Object    response body
    Integer    $.code    200
    ${rescode}    Integer    $.code
    #[Return]    ${rescode}

ApiLoginAndAddLocalIP
    [Arguments]    ${tempparm}
    log    ApiLoginAndAddLocalIP${tempparm}
    loginlogout.Login
    #log    **********
    Run Keyword If    ${addTestClentIPFlag}==1    AddLocalIPObject
    log    ApiLoginAndAddLocalIP
    #ApiAddAutoTagsCase
    #[Return]    ${rescode}

ApiLogoutAndDelLocalIP
    [Arguments]    ${tempparm}
    log    ApiLogoutAndDelLocalIP${tempparm}
    log    to_LogoutAndDelLocalIP_LogoutAndDelLocalIP
    Run Keyword If    ${addTestClentIPFlag}==1    DelLocalIPObject
    #ApiDeleteAutoTagsCase
    loginlogout.Logout
    #[Return]    ${rescode}

CliLogin
    Open Connection    ${cliHost}
    SSHLibrary.Login    ${cliUsername}    ${cliPassword}        

CliLogout    
    Close Connection
    Log    Close connection
    #exit