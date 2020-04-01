*** Settings ***
Library           Selenium2Library

*** Keywords ***
Menu
    [Arguments]    ${menuOne}    ${menuTwo}
    Wait Until Element Is Enabled    id=routerEvent0
    #    一级菜单
    ${dict}    create dictionary    dashboard=routerEvent0    policy&objects=children1    log=children2    report=children3    device=children4    settings=children5    administartion=children6
    #    二级菜单
    ${policy&objects}    create dictionary    Security Policy=sidebarObjects_ProxyInterception    Proxy Policy=sidebarObjects_ProxyManipulation    Objects=sidebarObjects_Objects    Schedules=sidebarObjects_Schedule    Tags=sidebarObjects_Tags
    ${log}    create dictionary    Security Event Logs=sidebarLog_SecurityEventLogs    Proxy Event Logs=sidebarLog_ProxyEventLogs    Session Records=sidebarLog_SesssionRecords    Radius Logs=sidebarLog_RadiusLogs
    #    遍历一级菜单
    FOR    ${list}    ${num}    IN ENUMERATE    @{dict}
        run keyword if    "${num}"=="${menuOne}"    run keywords    sleep    5
        ...    AND    click element    id=${dict}[${num}]
    END
    #    遍历二级菜单
    FOR    ${list}    ${num}    IN ENUMERATE    @{${menuOne}}
        run keyword if    "${num}"=="dashboard"    Exit For Loop
        ...    ELSE IF    "${num}"=="${menuTwo}"    run keywords    sleep    3
        ...    AND    click element    id=${${menuOne}}[${num}]
    END
