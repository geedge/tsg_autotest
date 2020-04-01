*** Settings ***
Resource          ../../03-Variable/BifangApiVariable.txt
Resource          LogSchema.robot
Library           REST    http://${host}:${port}/${version}
Library           RequestsLibrary
Library           OperatingSystem
Library           Collections
Library           string

*** Keywords ***
GetLogList
    [Arguments]    ${logType}    ${startTime}    ${endTime}    ${client_ip}    ${policy_id}    ${parmkey}    ${parmvalue}
    ${logCondition}    GetLogCondition    ${logType}    ${startTime}    ${endTime}    ${client_ip}    ${policy_id}
    log    ${logCondition}
    ${LogListResponse}    PostRemoteData    /log/list    ${logCondition}
    Should Be Equal As Strings    ${LogListResponse.status_code}    200
    ${returnData}    To Json    ${LogListResponse.content}
    ${responseCode}    Get From Dictionary    ${returnData}    code
    Log    ${responseCode}
    Should Be Equal    ${responseCode}    ${200}    security_event_log \ \ test query list failed
    log    this time request security_event_log \ table logRecord \ : ${LogListResponse.content}
    ${a}    Set Variable    this time request security_event_log \ table logRecord \ : ${LogListResponse.content}
    log    ${a}
    ${log}    Set Variable    ${LogListResponse.json()}[data][list]
    FOR    ${logs}    IN    ${log}
        log    ${logs}
    END
    log    %%%%%%%%%%%%%%%%%%%%%%%%${logs}
    Should Contain    ${logs}""    ${client_ip}
    Should Contain    ${logs}""    ${policy_id}
    Should Contain    ${logs}""    ${parmkey}
    Should Contain    ${logs}"${parmkey}"    ${parmvalue}