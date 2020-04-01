*** Settings ***
Resource          ../../03-Variable/BifangApiVariable.txt
Library           REST    http://${host}:${port}
Library           Collections
Library           RequestsLibrary
Resource          Common.robot

*** Keywords ***
AddLocalIPObject
    #创建对象IP
    log    to_AddLocalIPObject
    ${localIP}    set variable    {"opAction":"add","returnData":1,"objectList":{"objectType":"ip","objectSubType":"endpoint","isValid":1,"isInitialize":0,"isExclusion":0,"objectName":"autotestLocalIPObject_${testClentIP}","objectDesc":"LocalIPObject_${testClentIP}自动化测试机IP","subObjectIds":[],"addItemList":[{"addrType":4,"protocol":0,"direction":0,"isSession":"endpoint","clientIp1":"${testClentIP}","clientIp2":"${testClentIP}","clientIpFormat":"range","clientPortFormat":"range","clientPort1":0,"clientPort2":0,"serverIpFormat":"range","serverIp1":"","serverIp2":"","serverPortFormat":"range","serverPort1":0,"serverPort2":0}],"updateItemList":[],"deleteItemIds":[]}}
    ${rescodeip}    ${objidip}    AddObject    ${localIP}
    log    ${rescodeip}
    log    LocalIP：${objidip}
    SET GLOBAL VARIABLE    ${testClentID}    ${objidip}

DelLocalIPObject
    log    to_DelLocalIPObject
    ${response}    BaseDeleteRequest    /v1/policy/object    {"objectIds":[${testClentID}]}
    #${response_code}    Get From Dictionary    ${response}    code
    Should Be Equal As Strings    ${response}    {'code': 200, 'msg': 'Success', 'success': True}
    SET GLOBAL VARIABLE    ${testClentID}    ${EMPTY}

AddObject
    [Arguments]    ${body}
    #addIPobject#################################################################################
    ${response}    BasePostRequest    /v1/policy/object    body=${body}
    #log    ${response} 
    ${objectId}    Set Variable     ${response['data']['objectList'][0]['objectId']}
    ${rescodeReturn}    Set Variable     ${response['code']}
    [Return]    ${rescodeReturn}    ${objectId} 

EditObject
    [Arguments]    @{body}
    [Return]    ${rescode}    ${objectId}

DeleteObjectbak
    [Arguments]    ${objectids}
    ${body}    String    {"objectIds":[${objectids}]}
    DELETE    /v1/policy/object    body=${body}    headers=${headers}
    Object    response body
    log    DeleteObject
    log    dxytestOUtputstart
    Output    response body
    log    dxytestOUtputstart
    ${rescode}    Integer    $.code
    ${rescodeReturn}    Get From List    ${rescode}    0
    [Return]    ${rescodeReturn}

AddPolicy
    [Arguments]    ${body}
    ${response}    BasePostRequest    /v1/policy/compile    body=${body}
    #log    ${response} 
    ${policyId}    Set Variable     ${response['data']['policyList'][0]['policyId']}
    ${rescode}    Set Variable     ${response['code']}
    [Return]    ${rescode}    ${policyId}
    
EditPolicy
    [Arguments]    @{body}
    [Return]    ${rescode}    ${objectId}

DeletePolicybak
    [Arguments]    ${policyids}
    ${body}    String    {"policyType":"tsg_security","policyIds":[${policyids}]}
    DELETE    /v1/policy/compile    body=${body}    headers=${headers}
    Object    response body
    log    DeletePolicy
    Output    response body
    ${rescode}    Integer    $.code
    ${rescodeReturn}    Get From List    ${rescode}    0
    [Return]    ${rescodeReturn}

DeletePolicy
    [Arguments]    ${body}
    #删除策略
    log    toDeletePolicy_DeletePolicyDeletePolicy
    ${response}    BaseDeleteRequest    /v1/policy/compile    ${body}
    #{"policyType":"tsg_security","policyIds":[${policyids}]}
    ${response_code}    Get From Dictionary    ${response}    code
    Should Be Equal As Strings    ${response_code}    200
    ${response}    Convert to String    ${response}
    Should Be Equal As Strings    ${response}    {'code': 200, 'msg': 'Success', 'success': True}

DeleteObject
    [Arguments]    ${objectids}
    #删除对象
    log    todeleteobj
    ${response}    BaseDeleteRequest    /v1/policy/object    {"objectIds":[${objectids}]}
    ${response_code}    Get From Dictionary    ${response}    code
    #log    aaaaaaaaaa:${response_code}
    Should Be Equal As Strings    ${response_code}    200
    #Integer    ${response_code}    200
    ${response}    Convert to String    ${response}
    Should Be Equal As Strings    ${response}    {'code': 200, 'msg': 'Success', 'success': True}

DeletePolicyAndObject
    [Arguments]    ${policyids}    ${objectids}
    #删除和对象
    #删除策略
    log    toDeletePolicy_DeletePolicyAndObject
    ${listlenth}=    Get Length    ${policyids}
    FOR    ${var}    IN RANGE    ${listlenth}
        #log    dxytest111111
        log    ${var}
        DeletePolicy    ${policyids}[${var}]
    #Should Contain    ${commandreturn}    ${ca}
    END
    #删除对象
    log    todeleteobj_DeletePolicyAndObject
    DeleteObject    ${objectids}
