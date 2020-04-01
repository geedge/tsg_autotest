*** Settings ***
Resource          ../../03-Variable/BifangApiVariable.txt
Library           REST    http://${host}:${port}
Library           Collections
Library           RequestsLibrary

*** Keywords ***
BasePostRequest
    [Arguments]    ${apistr}    ${body}    
    Set Headers    {"Authorization":"${token}","Content-Type":"application/json"}
    &{httpResponse}    Post	${apistr}    ${body}
    Output    response body
    Object    response body
    #Integer    $.code    200
    #Array    $.data.policyList
    ${response}    Set Variable    ${httpResponse.body}
    [Return]    ${response}
BaseDeleteRequest
    [Arguments]    ${requestUri}    ${data}
    ${headers}    set variable    {"Authorization":"${token}","Content-Type":"application/json"}
    create session    api    http://${host}:${port}    ${headers}
    ${response}=    Delete Request    api    ${requestUri}    data=${data}
    log    return data =${response}
    Should Be Equal As Strings    ${response.status_code}    200
    ${response}    to json    ${response.content}
    [Return]    ${response}

BaseEditRequest
    [Arguments]    ${requestUri}    ${data}
    ${headers}    set variable    {"Authorization":"${token}","Content-Type":"application/json"}
    create session    api    http://${host}:${port}    ${headers}
    ${response}=    Put Request    api    ${requestUri}    data=${data}
    log    return data =${response}
    Should Be Equal As Strings    ${response.status_code}    200
    ${response}    to json    ${response.content}
    [Return]    ${response}
