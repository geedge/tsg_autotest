*** Settings ***
Library     Collections
Library     RequestsLibrary
Resource    ../../03-Variable/BifangApiVariable.txt

*** Keywords ***
Post-Request
    [Arguments]    ${url}    ${data}
    ${header}    Create Dictionary    Content-Type=application/json    Authorization=${token}
    Create Session    api    http://${host}:${port}/${version}    headers=${header}
    ${remoteResponse}    Post Request    api    ${url}    data=${data}    headers=${header}
    ${response}    to json    ${remoteResponse.content}
    Should Be Equal As Strings    ${remoteResponse.status_code}    200
    [Return]    ${response}

Get-Request
    [Arguments]    ${url}
    ${header}    Create Dictionary    Content-Type=application/json    Authorization=${token}
    Create Session    api    http://${host}:${port}/${version}    headers=${header}
    ${remoteResponse}    Get Request    api    ${url}    headers=${header}
    ${response}    to json    ${remoteResponse.content}
    Should Be Equal As Strings    ${remoteResponse.status_code}    200
    [Return]    ${response}
    
Delete-Request
    [Arguments]    ${url}    ${data}
    ${header}    Create Dictionary    Content-Type=application/json    Authorization=${token}
    Create Session    api    http://${host}:${port}/${version}    headers=${header}
    ${remoteResponse}    Delete Request    api    ${url}    data=${data}        headers=${header}
    ${response}    to json    ${remoteResponse.content}
    Should Be Equal As Strings    ${remoteResponse.status_code}    200
    [Return]    ${response}
    
UpFilePostRequest
    [Arguments]    ${url}    ${data}    ${files}    ${fileDesc}
    ${header}    Set To Dictionary    ${fileDesc}    Authorization=${token}
    Create Session    api    http://${host}:${port}/${version}    headers=${header}
    ${remoteResponse}    Post Request    api    ${url}    data=${data}    files=${files}     headers=${header}
    ${response}    to json    ${remoteResponse.content}
    Should Be Equal As Strings    ${remoteResponse.status_code}    200
    [Return]    ${response}
    
UpFilePutRequest
    [Arguments]    ${url}    ${data}    ${files}    ${fileDesc}
    ${header}    Set To Dictionary    ${fileDesc}   Authorization=${token}
    Create Session    api    http://${host}:${port}/${version}    headers=${header}
    ${remoteResponse}    Put Request    api    ${url}    params=${data}    files=${files}     headers=${header}
    ${response}    to json    ${remoteResponse.content}
    Should Be Equal As Strings    ${remoteResponse.status_code}    200
    [Return]    ${response}        
