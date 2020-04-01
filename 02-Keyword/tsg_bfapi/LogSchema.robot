*** Settings ***
Resource          ../../03-Variable/BifangApiVariable.txt
Library           RequestsLibrary
Library           OperatingSystem
Library           Collections
Library           string
Library           REST    http://${host}:${port}

*** Keywords ***
GetLogCondition
    [Arguments]    ${logname}    ${startTime}    ${endTime}    ${client_ip}    ${policy_id}
    Set Headers    {"Content-Type":"application/x-www-form-urlencoded","Authorization":"${token}"}
    &{LogSchemaResponse}=    GET    /v1/log/schema?logType=${logname}
    log    ${logname}
    Output Schema    response body
    Object    response body
    #Integer    $.code    200
    log    ${LogSchemaResponse.body['data']}
    ${field}    Evaluate    json.dumps(eval(str(${LogSchemaResponse.body['data']['fields']})))    json
    log    ${field}
    ${pageSize}    Set Variable    30
    ${pageNo}    Set Variable    1
    ${condition}    Set Variable    [{"value":["${startTime}","${endTime}"],"symbol":"between","field":"common_recv_time","type":"timestamp"}]
    ${logCondition}    Set Variable    {"pageNo":${pageNo},"pageSize":${pageSize},"logType":"${logname}","fields":${field},"start_common_recv_time":"${startTime}","end_common_recv_time":"${endTime}","conditions":${condition} ,"common_client_ips":"${client_ip}","common_policy_ids":"${policy_id}"}
    log    this time query condition:${logCondition}
    [Return]    ${logCondition}

PostRemoteData
    [Arguments]    ${url}    ${data}
    ${header}    Create Dictionary    Content-Type=application/json    Authorization=${token}
    Create Session    api    http://${host}:${port}/${version}    headers=${header}
    ${remoteResponse}    Post Request    api    ${url}    data=${data}    headers=${header}
    [Return]    ${remoteResponse}
