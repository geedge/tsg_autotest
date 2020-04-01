*** Settings ***
Library    String
Library    OperatingSystem
Library    RequestsLibrary
Library    Selenium2Library
Library    Collections
Resource    ../../../02-Keyword/tsg-bf-api/common.txt
Resource    ../../../02-Keyword/tsg-bf-api/apirequest.txt
Resource    ../../../03-Variable/bifangapivariable.txt


*** Keywords ***
QueryPolicyFile
    [Arguments]    ${url}       ${suffix}
    ${content_quary}    Get-Request    ${url}?isValid=1&${suffix}
    ${msg_quary}    Set Variable    ${content_quary['msg']} 
    ${length}    Get Length    ${content_quary['data']['list']}
    Should Be True    ${length}>0    
    Log    quary operation:${msg_quary}
    Log    data:${content_quary['data']['list']}

QueryPolicyFile2
    [Arguments]    ${url}       ${suffix}
    ${content_quary}    Get-Request    ${url}?${suffix}
    ${msg_quary}    Set Variable    ${content_quary['msg']} 
    ${length}    Get Length    ${content_quary['data']['list']}
    Should Be True    ${length}>0    
    Log    quary operation:${msg_quary}
    Log    data:${content_quary['data']['list']}
    ${certId}    Set Variable    ${content_quary['data']['list'][0]['certId']}
    [Return]    ${certId} 
    
CreatePolicyFile
    [Documentation]    
    ...    必传参数：url、filePath（文件路径）、fileName（文件名称）
    ...    可选参数：header（不传时使用默认值）
    [Arguments]    ${url}    ${filePath}    ${fileName}    @{header}
    ${suffix}    Generate Random String
    ${certName}    Catenate    SEPARATOR=_    test    ${suffix}
    ${header}    Run Keyword If    ${header}==[]   Set Variable    {"isValid":1,"opAction":"add","certName":"${certName}","certId":null,"returnData":1}
                 ...    ELSE    Get From List    ${header}    0    

    ${binFile}    Evaluate    open(r"${path}/${filePath}${fileName}",'rb')
    ${fileDict}    Create Dictionary    file=${binFile}
    ${requestData}    Create Dictionary    name="file"    filename="${fileName}"    Content-Type=application/octet-stream
    ${fileDesc}    Create Dictionary    File-Desc=${header}
    ${content}    UpFilePostRequest    ${url}    ${requestData}    ${fileDict}    ${fileDesc}
    ${msg}    Set Variable    ${content['msg']} 
    ${list}    Set Variable    ${content['data']['list']}
    ${cerId}    Set Variable    ${list[0]['certId']}
    ${certName}    Set Variable    ${list[0]['certName']}
    ${response}    Create Dictionary    msg=${msg}    certId=${cerId}    certName=${certName}
    Log    add operation:${msg}
    Log    cerId:${cerId}
    [Return]    ${response}

CreatePolicyFile2
    [Documentation]    
    ...    必传参数：url、filePath（文件路径）、fileName（文件名称）、flag(模块标识)
    ...    可选参数：header（不传时使用默认值）
    [Arguments]    ${url}    ${filePath}    ${fileName}    ${flag}   @{header}
    ${suffix}    Generate Random String
    ${randomName}    Catenate    SEPARATOR=_    test    ${suffix}
    ${value}    Run Keyword If    '${flag}'=='resPages'  Set Variable   {"isValid":1,"format":"html","opAction":"add","profileName":"${randomName}","profileId":null,"returnData":1}        
                ...    ELSE IF    '${flag}'=='hijack'    Set Variable   {"isValid":1,"contentType":"text/html","opAction":"add","profileName":"${randomName}","contentName":"${fileName}","profileId":null,"returnData":1} 
                ...    ELSE IF    '${flag}'=='insert'    Set Variable   {"isValid":1,"format":"js","insertOn":"after_page_load","opAction":"add","profileName":"${randomName}","profileId":null,"returnData":1}
    
    ${header}    Run Keyword If    ${header}==[]   Set Variable    ${value}    
                 ...    ELSE    Get From List    ${header}    0    

    ${binFile}    Evaluate    open(r"${path}/${filePath}${fileName}",'rb')
    ${fileDict}    Create Dictionary    file=${binFile}
    ${requestData}    Create Dictionary    name="file"    filename="${fileName}"    Content-Type=application/octet-stream
    ${suffix}    Generate Random String
    ${profileName}    Catenate    SEPARATOR=_    test    ${suffix}
    ${fileDesc}    Create Dictionary    File-Desc=${header}
    ${content}    UpFilePostRequest    ${url}    ${requestData}    ${fileDict}    ${fileDesc}
    ${msg}    Set Variable    ${content['msg']} 
    ${list}    Set Variable    ${content['data']['list']}
    ${profileId}    Set Variable    ${list[0]['profileId']}
    ${profileName}    Set Variable    ${list[0]['profileName']}
    ${response}    Create Dictionary    msg=${msg}    profileId=${profileId}    profileName=${profileName}
    Log    add operation:${msg}
    Log    profileId:${profileId}
    [Return]    ${response}
    
CreatePolicyFile3
    [Documentation]    
    ...    必传参数：url
    ...    可选参数：data（不传时使用默认值）
    [Arguments]    ${url}    @{data}
    ${suffix}    Generate Random String
    ${profileName}    Catenate    SEPARATOR=_    test    ${suffix}
    ${data}    Run Keyword If    ${data}==[]   Set Variable    {"opAction":"add","returnData":1,"trafficMirrorList":[{"profileName":"${profileName}","addrType":"mac","isValid":1,"addrArray":["00:A1:B2:06:C3:29"]}]}    
                 ...    ELSE    Get From List    ${data}    0    

    ${content}    Post-Request    ${url}    ${data}
    ${msg}    Set Variable    ${content['msg']} 
    ${list}    Set Variable    ${content['data']['list']}
    ${profileId}    Set Variable    ${list[0]['profileId']}
    ${profileName}    Set Variable    ${list[0]['profileName']}
    ${response}    Create Dictionary    msg=${msg}    profileId=${profileId}    profileName=${profileName}
    Log    add operation:${msg}
    Log    profileId:${profileId}
    [Return]    ${response}

CreatePolicyMutipartFile
    [Documentation]    
    ...    必传参数：url、filePath（文件路径）、pubFileName（证书文件名）、priFileName（私钥文件名）
    ...    可选参数：header（不传时使用默认值）
    [Arguments]    ${url}    ${filePath}    ${pubFileName}    ${priFileName}    @{header}
    ${suffix}    Generate Random String
    ${certName}    Catenate    SEPARATOR=_    test    ${suffix}
    ${header}    Run Keyword If    ${header}==[]   Set Variable    {"isValid":1,"opAction":"add","returnData":1,"keyringName":"${certName}","keyringType":"root","reissueExpiryHour":0,"crl":"null","publicKeyAlgo":"rsa1024","keyringId":null,"includeRoot":0}
                 ...    ELSE    Get From List    ${header}    0

    ${pubFile}    Evaluate    open(r"${path}/${filePath}${pubFileName}",'rb')
    ${priFile}    Evaluate    open(r"${path}/${filePath}${priFileName}",'rb')
    ${fileDict}    Create Dictionary    publicFile	${pubFile}
    Set To Dictionary    ${fileDict}    privateFile	${priFile}
    ${requestData}    Create Dictionary    name="publicFile"    filename="${pubFileName}"    Content-Type=application/octet-stream
    Set To Dictionary    ${requestData}    name    privateFile
    Set To Dictionary    ${requestData}    filename    ${priFileName}
    Set To Dictionary    ${requestData}    Content-Type    application/octet-stream
    ${fileDesc}    Create Dictionary    File-Desc=${header}
    
    ${content}    UpFilePostRequest    ${url}    ${requestData}    ${fileDict}    ${fileDesc}
    ${msg}    Set Variable    ${content['msg']} 
    ${list}    Set Variable    ${content['data']['list']}
    ${keyringId}    Set Variable    ${list[0]['keyringId']}
    ${keyringName}    Set Variable    ${list[0]['keyringName']}
    ${response}    Create Dictionary    msg=${msg}    keyringId=${keyringId}    keyringName=${keyringName}
    Log    add operation:${msg}
    Log    keyringId:${keyringId}
    [Return]    ${response}
    
UpdatePolicyMutipartFile
    [Arguments]    ${url}    ${filePath}    ${pubFileName}    ${priFileName}   ${reqHeader}
    ${pubFile}    Evaluate    open(r"${path}/${filePath}${pubFileName}",'rb')
    ${priFile}    Evaluate    open(r"${path}/${filePath}${priFileName}",'rb')
    ${fileDict}    Create Dictionary    publicFile	${pubFile}
    Set To Dictionary    ${fileDict}    privateFile	${priFile}

    ${requestData}    Create Dictionary    name="publicFile"    filename="${pubFileName}"    Content-Type=application/octet-stream
    Set To Dictionary    ${requestData}    name    privateFile
    Set To Dictionary    ${requestData}    filename    ${priFileName}
    Set To Dictionary    ${requestData}    Content-Type    application/octet-stream

    ${fileDesc}    Create Dictionary    File-Desc	${reqHeader}
    ${content}    UpFilePutRequest    ${url}    ${requestData}    ${fileDict}    ${fileDesc}
    ${msg}    Set Variable    ${content['msg']} 
    Log    update operation:${msg}
    Log    update condition:${reqHeader}

UpdatePolicyFile
    [Arguments]    ${url}    ${filePath}    ${fileName}   ${reqHeader}
    ${binFile}    Evaluate    open(r"${path}/${filePath}${fileName}",'rb')
    ${fileDict}    Create Dictionary    file=${binFile}
    ${requestData}    Create Dictionary    name="file"    filename="${fileName}"    Content-Type=application/octet-stream
    ${fileDesc}    Create Dictionary    File-Desc=${reqHeader}
    ${content}    UpFilePutRequest    ${url}    ${requestData}    ${fileDict}    ${fileDesc}
    ${msg}    Set Variable    ${content['msg']} 
    Log    update operation:${msg}
    Log    update condition:${reqHeader}

UpdatePolicyFile2
    [Arguments]    ${url}    ${data}
    ${header}    Create Dictionary    Content-Type=application/json    Authorization=${token}
    Create Session    api    http://${host}:${port}/${version}    headers=${header}
    ${remoteResponse}    Put Request    api    ${url}    data=${data}    headers=${header}
    ${response}    to json    ${remoteResponse.content}
    Should Be Equal As Strings    ${remoteResponse.status_code}    200
    ${msg}    Set Variable    ${response['msg']}
    Log    update operation:${msg}
    Log    update condition:${data}
    
DeletePolicyFile
    [Arguments]    ${url}    ${data}
    ${content}    Delete-Request    ${url}    ${data}
    ${msg}    Set Variable    ${content['msg']} 
    Log    delete operation:${msg}
    Log    delete condition:${data}
    
TeardownDelete
    [Arguments]    ${url}    ${key}    ${value}
    ${ids}    Create List    ${value}
    ${data}    Create Dictionary    ${key}=${ids}
    ${content}    Delete-Request    ${url}    ${data}
    ${msg}    Set Variable    ${content['msg']} 
    Log    teardown operation:${msg}
    Log    teardown condition:${data}

