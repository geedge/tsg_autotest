*** Settings ***
Library           Selenium2Library
Resource          Objects.robot
Resource          ../Menu.robot
Library           Collections

*** Keywords ***
CreatePage
    [Arguments]    ${objtype}    ${name}    ${ipads}=null    ${ipclient}=null    ${ipclienttext1}=null    ${ipclienttext2}=null    ${keywordtext}=null    ${hex}=close    ${reqrestype}=null    ${reqresheader}=null
    Menu    policy&objects    Objects
    sleep    3
    Objects.CreateButton    ${objtype}
    Objects.Create-name    ${name}
    Objects.Create-item
    run keyword if    "${objtype}"=="Ip"    run keywords    Objects.Create-ip-AddressType    ${ipads}
    ...    AND    Objects.Create-ip-ClientIP    ${ipclient}
    ...    AND    Objects.Create-ip-ClientIP-text    ${ipclient}    ${ipclienttext1}    ${ipclienttext2}
    run keyword if    "${objtype}"=="Fqdn" or "${objtype}"=="Sub" or "${objtype}"=="Url" or "${objtype}"=="Category" or "${objtype}"=="Account"    run keywords    Objects.Create-keyword-text    ${objtype}    ${keywordtext}
    ...    AND    sleep    1
    run keyword if    '${objtype}'=='Key'    run keywords    Objects.Create-Key-text    ${keywordtext}
    ...    AND    Objects.Create-Key-hexmode    ${hex}
    run keyword if    '${objtype}'=='ReqRes'    run keywords    Objects.Create-ReqRes-type    ${reqrestype}
    ...    AND    Objects.Create-ReqRes-header    ${reqrestype}    ${reqresheader}
    ...    AND    Objects.Create-ReqRes-text    ${keywordtext}
    ...    AND    Objects.Create-ReqRes-hexmode    ${hex}
    Objects.Create-item-ok    ${objtype}
    Objects.Create-ok

UpdateIPPage
    SelectOne
    UpButton
    UpName    yyq_test_up
    Create-item
    Create-ip-ClientIP    range
    Create-ip-ClientIP-text    192.168.255.255    192.168.255.255
    Create-item-ok    Ip    #Ip
    UpOk

DeletePage
    [Arguments]    ${name}
    sleep    1
    click element    id=clear_input_btm
    sleep    1
    input text    id=one-input    ${name}
    press keys    id=one-input    ENTER
    Objects.SelectOne
    Objects.DeleteButton
    Objects.Delete-delete

UploadPage
    UploadButton
    Upload-name    yyq-uploadFile
    Upload-objectType
    Upload-uploadedFile    F:\\yyq\\python\\ip_20200221080650.txt
    Upload-ok

ExportPage
    ExportPage
    Export-objectType    ip
    Export-format    txt
    Export-ok

DeleteObjects
    [Arguments]    ${obj}
    sleep    2
    Menu    policy&objects    Objects
    FOR    ${num}    ${key}    IN ENUMERATE    @{obj}
        sleep    2
        run keyword if    "${key}"!="Ip"    DeletePage    ${obj}[${key}]
        sleep    1
    END
