*** Settings ***
Library           Selenium2Library

*** Keywords ***
CreateButton
    Wait Until Element Is Enabled    id=proxyInterception_create
    sleep    3
    click element    id=proxyInterception_create

Create-name
    [Arguments]    ${name}
    sleep    2
    input text    id=interceptionadd_name    ${name}

Create-action
    [Arguments]    ${action}
    run keyword if    "${action}"=="allow"    run keywords    sleep    1
    ...    AND    click element    id=security_action_Allow
    ...    ELSE IF    "${action}"=="deny"    run keywords    sleep    1
    ...    AND    click element    id=security_action_Deny
    ...    ELSE IF    "${action}"=="monitor"    run keywords    sleep    1
    ...    AND    click element    id=security_action_Monitor
    ...    ELSE IF    "${action}"=="intercept"    run keywords    sleep    1
    ...    AND    click element    id=security_action_Intercept

Create-Conditions
    sleep    2
    click element    id=interceptionadd_object

Create-Conditions-ip
    [Arguments]    ${objname}
    sleep    2
    click element    id=interceptionadd_procolall1
    sleep    2
    SecurityPolicy.SelectOne    ${objname}

Create-Conditions-sub
    [Arguments]    ${objname}
    sleep    2
    click element    id=interceptionadd_procolall2
    sleep    2
    SecurityPolicy.SelectOne    ${objname}

Create-Conditions-protocol
    [Arguments]    ${protocol}
    sleep    2
    click element    id=interceptionadd_procolall3
    sleep    2
    run keyword if    '${protocol}'=='http'    run keywords    sleep    1
    ...    AND    click element    id=interceptionadd_prochange0
    ...    ELSE IF    '${protocol}'=='ssl'    run keywords    sleep    1
    ...    AND    click element    id=interceptionadd_prochange1
    ...    ELSE IF    '${protocol}'=='dns'    run keywords    sleep    1
    ...    AND    click element    id=interceptionadd_prochange2
    ...    ELSE IF    '${protocol}'=='mail'    run keywords    sleep    1
    ...    AND    click element    id=interceptionadd_prochange3
    ...    ELSE IF    '${protocol}'=='ftp'    run keywords    sleep    1
    ...    AND    click element    id=interceptionadd_prochange4
    ...    ELSE    log    协议内容错误

Create-Conditions-Search
    [Arguments]    ${Search}
    input text    xpath=//*[@id="proxy"]/div[5]/div[2]/div[2]/div/div[1]/input    ${Search}
    sleep    2

Create-Conditions-Close
    click button    id=interceptionadd_allcancelobject
    sleep    2

Create-Tag

Create-EffectiveDevices

Create-Schedule

Create-Log Session

Create-Description

Create-Enabled
    [Arguments]    ${state}
    sleep    2
    run keyword if    "${state}"=="open"    run keywords    click element    id=enablencheck_swith
    ...    AND    sleep    2
    ...    AND    click button    id=interceptionadd-enable-confirm

Create-ok
    execute javascript    document.documentElement.scrollTop=1000
    sleep    2
    click button    id=interceptionadd_sub
    sleep    1
    execute javascript    document.documentElement.scrollTop=0

Create-cancel
    click button    id=interceptionadd_back

Create-Conditions-obj
    [Arguments]    ${action}    ${protocol}    ${objtype}    ${objname}    ${objtype1}=null
    run keyword if    '${action}'=='allow' and '${protocol}'=='http'    run keywords    sleep    1
    ...    AND    click element    id=interceptionadd_prochange0
    ...    AND    Create-Conditions-allow&intercept-http    ${objtype}    ${objname}
    ...    ELSE IF    '${action}'=='intercept' and '${protocol}'=='http'    run keywords    sleep    1
    ...    AND    click element    id=interceptionadd_prochange0
    ...    AND    Create-Conditions-allow&intercept-http    ${objtype}    ${objname}
    ...    ELSE IF    '${action}'=='allow' and '${protocol}'=='ssl'    run keywords    sleep    1
    ...    AND    click element    id=interceptionadd_prochange1
    ...    AND    Create-Conditions-allow&intercept-ssl    ${objtype}    ${objname}
    ...    ELSE IF    '${action}'=='intercept' and '${protocol}'=='ssl'    run keywords    sleep    1
    ...    AND    click element    id=interceptionadd_prochange1
    ...    AND    Create-Conditions-allow&intercept-ssl    ${objtype}    ${objname}
    ...    ELSE IF    '${action}'=='deny' and '${protocol}'=='http'    run keywords    sleep    1
    ...    AND    click element    id=interceptionadd_prochange0
    ...    AND    Create-Conditions-deny&monitor-http    ${objtype}    ${objname}
    ...    ELSE IF    '${action}'=='monitor' and '${protocol}'=='http'    run keywords    sleep    1
    ...    AND    click element    id=interceptionadd_prochange0
    ...    AND    Create-Conditions-deny&monitor-http    ${objtype}    ${objname}
    ...    ELSE IF    '${action}'=='deny' and '${protocol}'=='ssl'    run keywords    sleep    1
    ...    AND    click element    id=interceptionadd_prochange1
    ...    AND    Create-Conditions-deny&monitor-ssl    ${objtype1}    ${objtype}    ${objname}
    ...    ELSE IF    '${action}'=='monitor' and '${protocol}'=='ssl'    run keywords    sleep    1
    ...    AND    click element    id=interceptionadd_prochange1
    ...    AND    Create-Conditions-deny&monitor-ssl    ${objtype1}    ${objtype}    ${objname}
    ...    ELSE IF    '${action}'=='deny' and '${protocol}'=='dns'    run keywords    sleep    1
    ...    AND    click element    id=interceptionadd_prochange2
    ...    AND    Create-Conditions-deny&monitor-dns    ${objtype}    ${objname}
    ...    ELSE IF    '${action}'=='monitor' and '${protocol}'=='dns'    run keywords    sleep    1
    ...    AND    click element    id=interceptionadd_prochange2
    ...    AND    Create-Conditions-deny&monitor-dns    ${objtype}    ${objname}
    ...    ELSE IF    '${action}'=='deny' and '${protocol}'=='mail'    run keywords    sleep    1
    ...    AND    click element    id=interceptionadd_prochange3
    ...    AND    Create-Conditions-deny&monitor-mail    ${objtype}    ${objname}
    ...    ELSE IF    '${action}'=='monitor' and '${protocol}'=='mail'    run keywords    sleep    1
    ...    AND    click element    id=interceptionadd_prochange3
    ...    AND    Create-Conditions-deny&monitor-mail    ${objtype}    ${objname}
    ...    ELSE IF    '${action}'=='deny' and '${protocol}'=='ftp'    run keywords    sleep    1
    ...    AND    click element    id=interceptionadd_prochange4
    ...    AND    Create-Conditions-deny&monitor-ftp    ${objtype}    ${objname}
    ...    ELSE IF    '${action}'=='monitor' and '${protocol}'=='ftp'    run keywords    sleep    1
    ...    AND    click element    id=interceptionadd_prochange4
    ...    AND    Create-Conditions-deny&monitor-ftp    ${objtype}    ${objname}
    ...    ELSE    log    对象错误

Create-Conditions-allow&intercept-http
    [Arguments]    ${objtype}    ${objname}
    sleep    2
    run keyword if    '${objtype}'=='Fqdn'    run keywords    click element    xpath=//*[@id="interceptionadd_pro0"]/div[2]
    ...    AND    sleep    2
    ...    ELSE IF    '${objtype}'=='Category'    run keywords    click element    xpath=//*[@id="interceptionadd_pro0"]/div[3]
    ...    AND    sleep    2
    ...    ELSE    log    对象错误
    SecurityPolicy.SelectOne    ${objname}

Create-Conditions-allow&intercept-ssl
    [Arguments]    ${objtype}    ${objname}
    sleep    2
    run keyword if    '${objtype}'=='Fqdn'    run keywords    click element    xpath=//*[@id="interceptionadd_pro0"]/div[2]
    ...    AND    sleep    2
    ...    ELSE IF    '${objtype}'=='Category'    run keywords    click element    xpath=//*[@id="interceptionadd_pro0"]/div[3]
    ...    AND    sleep    2
    ...    ELSE    log    对象错误
    SecurityPolicy.SelectOne    ${objname}

Create-Conditions-deny&monitor-http
    [Arguments]    ${objtype}    ${objname}
    sleep    2
    run keyword if    '${objtype}'=='Fqdn'    run keywords    click element    xpath=//*[@id="interceptionadd_pro0"]/div[2]
    ...    AND    sleep    2
    ...    ELSE IF    '${objtype}'=='Category'    run keywords    click element    xpath=//*[@id="interceptionadd_pro0"]/div[3]
    ...    AND    sleep    2
    ...    ELSE IF    '${objtype}'=='Url'    run keywords    click element    id=interceptionadd_pro1
    ...    AND    sleep    2
    ...    ELSE IF    '${objtype}'=='Reqhdr'    run keywords    click element    id=interceptionadd_pro2
    ...    AND    sleep    2
    ...    ELSE IF    '${objtype}'=='Reshdr'    run keywords    click element    id=interceptionadd_pro3
    ...    AND    sleep    2
    ...    ELSE IF    '${objtype}'=='Reqbody'    run keywords    click element    id=interceptionadd_pro4
    ...    AND    sleep    2
    ...    ELSE IF    '${objtype}'=='Resbody'    run keywords    click element    id=interceptionadd_pro5
    ...    AND    sleep    2
    ...    ELSE    log    对象错误
    SecurityPolicy.SelectOne    ${objname}

Create-Conditions-deny&monitor-ssl
    [Arguments]    ${objtype1}    ${objtype}    ${objname}
    sleep    2
    run keyword if    '${objtype1}'=='sni' and '${objtype}'=='Fqdn'    run keywords    click element    xpath=//*[@id="interceptionadd_pro0"]/div[2]
    ...    AND    sleep    2
    ...    ELSE IF    '${objtype1}'=='sni' and '${objtype}'=='Category'    run keywords    click element    xpath=//*[@id="interceptionadd_pro0"]/div[3]
    ...    AND    sleep    2
    ...    ELSE IF    ${objtype1}'=='cn' and ${objtype}'=='Fqdn'    run keywords    click element    id=interceptionadd_pro1
    ...    AND    sleep    2
    ...    AND    click element    xpath=//*[@id="interceptionadd_pro1"]/div[2]
    ...    AND    sleep    2
    ...    ELSE IF    ${objtype1}'=='cn' and${objtype}'=='Category'    run keywords    click element    id=interceptionadd_pro1
    ...    AND    sleep    2
    ...    AND    click element    xpath=//*[@id="interceptionadd_pro1"]/div[3]
    ...    AND    sleep    2
    ...    ELSE IF    ${objtype1}'=='san' and ${objtype}'=='Fqdn'    run keywords    click element    id=interceptionadd_pro2
    ...    AND    sleep    2
    ...    AND    click element    xpath=//*[@id="interceptionadd_pro2"]/div[2]
    ...    AND    sleep    2
    ...    ELSE IF    ${objtype1}'=='san' and ${objtype}'=='Category'    run keywords    click element    id=interceptionadd_pro2
    ...    AND    sleep    2
    ...    AND    click element    xpath=//*[@id="interceptionadd_pro2"]/div[3]
    ...    AND    sleep    2
    ...    ELSE    log    对象错误
    SecurityPolicy.SelectOne    ${objname}

Create-Conditions-deny&monitor-dns
    [Arguments]    ${objtype}    ${objname}
    sleep    2
    run keyword if    '${objtype}'=='Fqdn'    run keywords    click element    xpath=//*[@id="interceptionadd_pro0"]/div[2]
    ...    AND    sleep    2
    ...    ELSE IF    '${objtype}'=='Category'    run keywords    click element    xpath=//*[@id="interceptionadd_pro0"]/div[3]
    ...    AND    sleep    2
    ...    ELSE    log    对象错误
    SecurityPolicy.SelectOne    ${objname}

Create-Conditions-deny&monitor-mail
    [Arguments]    ${objtype}    ${objname}
    sleep    2
    run keyword if    '${objtype}'=='Subject'    run keywords    click element    id=interceptionadd_pro0
    ...    AND    sleep    2
    ...    ELSE IF    '${objtype}'=='Content'    run keywords    click element    id=interceptionadd_pro1
    ...    AND    sleep    2
    ...    ELSE IF    '${objtype}'=='ATT Name'    run keywords    click element    id=interceptionadd_pro2
    ...    AND    sleep    2
    ...    ELSE IF    '${objtype}'=='ATT CONT'    run keywords    click element    id=interceptionadd_pro3
    ...    AND    sleep    2
    ...    ELSE IF    '${objtype}'=='From'    run keywords    click element    id=interceptionadd_pro4
    ...    AND    sleep    2
    ...    ELSE IF    '${objtype}'=='To'    run keywords    click element    id=interceptionadd_pro5
    ...    AND    sleep    2
    ...    ELSE IF    '${objtype}'=='Account'    run keywords    click element    id=interceptionadd_pro6
    ...    AND    sleep    2
    ...    ELSE    log    对象错误
    SecurityPolicy.SelectOne    ${objname}

Create-Conditions-deny&monitor-ftp
    [Arguments]    ${objtype}    ${objname}
    sleep    2
    run keyword if    '${objtype}'=='url'    run keywords    click element    id=interceptionadd_pro0
    ...    AND    sleep    2
    ...    ELSE IF    '${objtype}'=='content'    run keywords    click element    id=interceptionadd_pro1
    ...    AND    sleep    2
    ...    ELSE IF    '${objtype}'=='account'    run keywords    click element    id=interceptionadd_pro2
    ...    AND    sleep    2
    ...    ELSE    log    对象错误
    SecurityPolicy.SelectOne    ${objname}

SelectOne
    [Arguments]    ${objname}
    sleep    2
    log    ${objname}
    input text    xpath=//*[@id="condistions_protocol"]/div[2]/div[2]/div/div[1]/input    ${objname}
    sleep    1
    press keys    xpath=//*[@id="condistions_protocol"]/div[2]/div[2]/div/div[1]/input    ENTER
    sleep    2
    click element    xpath=//*[@id="interceptionadd_checkouobject"]/ul/li[1]
