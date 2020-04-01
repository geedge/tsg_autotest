*** Settings ***
Library           Selenium2Library

*** Keywords ***
CreateButton
    [Arguments]    ${objType}
    Wait Until Element Is Enabled    id=objectCreate
    sleep    3
    Click element    id=objectCreate
    run keyword if    "${objType}"=="Ip"    run keywords    sleep    2
    ...    AND    Click element    id=object1
    ...    ELSE IF    "${objType}"=="Fqdn"    run keywords    sleep    2
    ...    AND    Click element    id=object2
    ...    ELSE IF    "${objType}"=="Sub"    run keywords    sleep    2
    ...    AND    Click element    id=object3
    ...    ELSE IF    "${objType}"=="ReqRes"    run keywords    sleep    2
    ...    AND    Click element    id=object4
    ...    ELSE IF    "${objType}"=="Key"    run keywords    sleep    2
    ...    AND    Click element    id=object5
    ...    ELSE IF    "${objType}"=="Url"    run keywords    sleep    2
    ...    AND    Click element    id=object6
    ...    ELSE IF    "${objType}"=="Category"    run keywords    sleep    2
    ...    AND    Click element    id=object7
    ...    ELSE IF    "${objType}"=="Account"    run keywords    sleep    2
    ...    AND    Click element    id=object8
    ...    ELSE IF    log    对象类型有误

Create-name
    [Arguments]    ${objName}
    sleep    2
    input text    id=objectAdd_name    ${objName}

Create-item
    click element    id=objectAddItemAdd

Create-item-Add
    [Arguments]    ${Type}
    click element    id=objectAddItem${Type}Add

Create-item-ok
    [Arguments]    ${Type}
    sleep    2
    run keyword if    "${Type}"=="Category"    click element    id=objectAddItemFqdnOk
    ...    ELSE IF    "${Type}"=="Account"    click element    id=objectItemAccountOk
    ...    ELSE    click element    id=objectAddItem${Type}Ok

Create-item-Cancel
    [Arguments]    ${Type}
    click button    id=objectAddItem${Type}Cancel

Create-ip-AddressType
    [Arguments]    ${AdsType}
    sleep    2
    click element    id=objectItemIpType0
    sleep    2
    run keyword if    "${AdsType}"=="ipv4"    run keywords    click element    xpath=/html/body/div[2]/div[1]/div[1]/ul/li[1]
    ...    AND    sleep    1
    ...    ELSE IF    "${AdsType}"=="ipv6"    run keywords    click element    xpath=/html/body/div[2]/div[1]/div[1]/ul/li[2]
    ...    ELSE    run keywords    log    'Address Type错误'

Create-ip-Protocol
    [Arguments]    ${Protocol}
    run keyword if    ${Protocol}=="any"    click element    id=objectItemIpProtocol10
    ...    ELSE IF    ${Protocol}=="tcp"    click element    id=objectItemIpProtocol20
    ...    ELSE IF    ${Protocol}=="udp"    click element    id=objectItemIpProtocol30

Create-ip-Directed
    [Arguments]    ${Directed}
    run keyword if    ${Directed}=="no"    click element    id=objectItemIpDirection10
    ...    ELSE IF    ${Directed}=="yes"    click element    id=objectItemIpDirection20

Create-ip-ClientIP
    [Arguments]    ${clientIPType}
    sleep    2
    click element    id=object_ip_sourecip0
    sleep    2
    run keyword if    "${clientIPType}"=="range"    run keywords    sleep    1
    ...    AND    click element    id=range0
    ...    ELSE IF    "${clientIPType}"=="cidr"    run keywords    sleep    1
    ...    AND    click element    id=CIDR0
    ...    ELSE IF    "${clientIPType}"=="masks"    run keywords    sleep    1
    ...    AND    click element    xpath=/html/body/div[3]/div[1]/div[1]/ul/li[3]
    sleep    2

Create-ip-ClientIP-text
    [Arguments]    ${clientIPType}    ${clientIPStart}    ${clientIPEnd}
    sleep    2
    run keyword if    "${clientIPType}"=="range"    run keywords    input text    id=object_ip_clientip10    ${clientIPStart}
    ...    AND    input text    id=object_ip_clientip20    ${clientIPEnd}
    run keyword if    "${clientIPType}"=="cidr"    run keywords    input text    id=object_ip_clientip30    ${clientIPStart}
    ...    AND    input text    id=object_ip_clientip40    ${clientIPEnd}
    run keyword if    "${clientIPType}"=="masks"    run keywords    input text    id=object_ip_clientip50    ${clientIPStart}
    ...    AND    input text    id=object_ip_clientip60    ${clientIPEnd}

Create-ip-ClientPort

Create-ip-ClientPort-text

Create-ip-ServerIP

Create-ip-ServerPort

Create-subobjects
    click element    id=objectAddSubAdd

Create-Description
    [Arguments]    ${objDesc}
    input text    id=objectAdd_description    ${objDesc}

Create-ok
    sleep    1
    click button    id=objectAdd_ok

Create-cancel
    click button    id=objectAdd_cancel

SelectOne
    sleep    3
    click element    xpath=//*[@id="ly-table1-listcontent"]/div/div[3]/table/tbody/tr[1]

UpButton
    click button    id=objectEdit

DeleteButton
    click button    id=objectDel

Delete-delete
    sleep    2
    click button    id=object-objectDel-confirm

Delete-cancel
    click button    xpath=/html/body/div[2]/div/div[3]/button[1]

UpName
    [Arguments]    ${name}
    clear element text    id=objectAdd_name
    input text    id=objectAdd_name    ${name}

UpOk
    click button    id=objectAdd_ok

UploadButton
    sleep    3
    click button    id=objectImprt

ExportButton
    sleep    3
    click button    id=objectExport

Upload-name
    [Arguments]    ${name}
    sleep    2
    input text    xpath=//*[@id="app"]/div/div[3]/div/div/div[14]/div/div[1]/div[1]/div/input    ${name}

Upload-objectType
    click button    id=object_select_Import
    sleep    2
    click element    xpath=/html/body/div[2]/div[1]/div[1]/ul/li[1]

Upload-uploadedFile
    [Arguments]    ${ads}
    sleep    3
    Choose File    xpath=//*[@id="app"]/div/div[3]/div/div/div[14]/div/div[2]/div/div[1]/input    ${ads}

Upload-ok
    click button    id=objectUploadedOk

Export-objectType
    [Arguments]    ${objType}
    click element    id=object_select_Import1
    run keyword if    "${objType}"=="ip"    run keywords    sleep    2
    ...    AND    click element    xpath=/html/body/div[2]/div[1]/div[1]/ul/li[1]
    ...    ELSE IF    "${objType}"=="fqdn"    run keywords    sleep    2
    ...    AND    Click element    xpath=/html/body/div[2]/div[1]/div[1]/ul/li[2]
    ...    ELSE IF    "${objType}"=="subscriberid"    run keywords    sleep    2
    ...    AND    Click element    xpath=/html/body/div[2]/div[1]/div[1]/ul/li[3]
    ...    ELSE IF    "${objType}"=="httpsignature"    run keywords    sleep    2
    ...    AND    Click element    xpath=/html/body/div[2]/div[1]/div[1]/ul/li[4]
    ...    ELSE IF    "${objType}"=="keywords"    run keywords    sleep    2
    ...    AND    Click element    xpath=/html/body/div[2]/div[1]/div[1]/ul/li[5]
    ...    ELSE IF    "${objType}"=="url"    run keywords    sleep    2
    ...    AND    Click element    xpath=/html/body/div[2]/div[1]/div[1]/ul/li[6]
    ...    ELSE IF    "${objType}"=="category"    run keywords    sleep    2
    ...    AND    Click element    xpath=/html/body/div[2]/div[1]/div[1]/ul/li[7]
    ...    ELSE IF    "${objType}"=="account"    run keywords    sleep    2
    ...    AND    Click element    xpath=/html/body/div[2]/div[1]/div[1]/ul/li[8]

Export-format
    [Arguments]    ${filetype}
    sleep    2
    click element    id=object_select_export
    run keyword if    "${filetype}"=="txt"    run keywords    sleep    2
    ...    AND    click element    xpath=/html/body/div[3]/div[1]/div[1]/ul/li[1]
    ...    ELSE IF    "${filetype}"=="csv"    run keywords    sleep    2
    ...    AND    click element    xpath=/html/body/div[3]/div[1]/div[1]/ul/li[2]

Export-ok
    click button    id=objectImportOk

Export-cancel
    click button    id=objectImportCancel

Create-keyword-text
    [Arguments]    ${type}    ${keywordtext}
    sleep    1
    run keyword if    "${type}"=="Fqdn"    run keywords    sleep    1
    ...    AND    input text    id=object_fqdn0    ${keywordtext}
    ...    ELSE IF    "${type}"=="Sub"    run keywords    sleep    1
    ...    AND    input text    id=object_sub0    ${keywordtext}
    ...    ELSE IF    "${type}"=="Url"    run keywords    sleep    1
    ...    AND    input text    id=object_url0    ${keywordtext}
    ...    ELSE IF    "${type}"=="Category"    run keywords    sleep    1
    ...    AND    input text    id=object_fqdn0    ${keywordtext}
    ...    ELSE IF    "${type}"=="Account"    run keywords    sleep    1
    ...    AND    input text    id=object_account0    ${keywordtext}
    ...    ELSE    log    2

Create-ReqRes-type
    [Arguments]    ${type}
    sleep    1
    run keyword if    '${type}'=='req'    click element    xpath=//*[@id="objectAddItemReqRes"]/label[1]
    ...    ELSE IF    '${type}'=='res'    click element    xpath=//*[@id="objectAddItemReqRes"]/label[2]
    sleep    1

Create-ReqRes-header
    [Arguments]    ${type}    ${header}
    sleep    1
    run keyword if    '${type}'=='req' and '${header}'=='ua'    click element    xpath=//*[@id="objectAddItemReqResType1"]/label[1]
    ...    ELSE IF    '${type}'=='req' and '${header}'=='ck'    click element    xpath=//*[@id="objectAddItemReqResType1"]/label[2]
    ...    ELSE IF    '${type}'=='res'and '${header}'=='sck'    click element    xpath=//*[@id="objectAddItemReqResType"]/label[1]
    ...    ELSE IF    '${type}'=='res'and '${header}'=='ct'    click element    xpath=//*[@id="objectAddItemReqResType"]/label[2]
    sleep    1

Create-ReqRes-text
    [Arguments]    ${keywordtext}
    sleep    1
    input text    id=object_sig0    ${keywordtext}
    sleep    1

Create-ReqRes-hexmode
    [Arguments]    ${hex}
    sleep    1
    run keyword if    "${hex}"=="open"    click element    id=objectAddItemReqResIsHexbin0_swith
    sleep    1

Create-Key-text
    [Arguments]    ${keywordtext}
    sleep    1
    input text    id=object_key0    ${keywordtext}
    sleep    1

Create-Key-hexmode
    [Arguments]    ${hex}
    sleep    1
    run keyword if    "${hex}"=="open"    click element    id=objectAddItemKeyIsHexbin0_swith
    sleep    1
