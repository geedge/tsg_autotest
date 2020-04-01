*** Settings ***
Library           Selenium2Library
Resource          ../../../03-Variable/BifangApiVariable.txt
Library           Selenium2Library
Resource          ../Objects/Objects.robot
Resource          ../Objects/ObjectPages.robot

*** Keywords ***
Login
    Open Browser    http://${host}/#/login    ${browserType}
    Maximize Browser Window
    input text    xpath=//*[@id="app"]/div/div[2]/div/div[2]/div/input    ${username}
    input text    xpath=//*[@id="app"]/div/div[2]/div/div[3]/div/input    ${password}
    Click button    id=login

AddLocalIp
    ${obj1}    create dictionary    type=Ip    name=LocahIPName    ipads=${ipType}    ipclient=masks    ipclienttext1=${testClentIP}    ipclienttext2=${ipMask}
    CreatePage    ${obj1}[type]    ${obj1}[name]    ipads=${obj1}[ipads]    ipclient=${obj1}[ipclient]    ipclienttext1=${obj1}[ipclienttext1]    ipclienttext2=${obj1}[ipclienttext2]
    set global variable    ${LocahIPName}    ${obj1}[name]

UiLoginAndAaddLocalIP
    [Arguments]    ${tempParm}
    log    UiLoginAndAaddLocalIP${tempParm}
    Login.Login
    Run Keyword If    ${addTestClentIPFlag}==1    AddLocalIp
    log    UiLoginAndAaddLocalIP:${LocahIPName}
