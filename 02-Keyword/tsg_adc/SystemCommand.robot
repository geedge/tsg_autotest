*** Settings ***
Library           OperatingSystem
Library           Selenium2Library
Library           RequestsLibrary
Library           Collections

*** Keywords ***
SystemCommands
    [Arguments]    ${commandstr}    ${stringlist}
    log    toSystemCommand_SystemCommandTest
    ${commandreturn}    OperatingSystem.Run    ${commandstr}
    ${listlenth}=    Get Length    ${stringlist}
    FOR    ${var}    IN RANGE    ${listlenth}
        #log    ${var}
        Should Contain    ${commandreturn}    ${stringlist}[${var}]
    END
    ${rescode}    Set Variable    200
    log    ${rescode}
    [Return]    ${rescode}

SystemCommand
    [Arguments]    ${commandstr}    @{stringlist}
    log    dxytest${commandstr}
    ${commandreturn}    OperatingSystem.Run    ${commandstr}
    #nslookup -d www.jd.com
    log    ${commandreturn}
    FOR    ${var}    IN    @{stringlist}
        log    dxytest
        log    ${var}
        Should Contain    ${commandreturn}    ${var}
    END
    #Should Contain    ${commandreturn}    ${qatype}
    ${rescode}    Set Variable    200
    log    ${rescode}
    [Return]    ${rescode}
