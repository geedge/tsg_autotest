*** Settings ***
Resource          ../../03-Variable/BifangApiVariable.txt
Library           REST    http://${host}:${port}
Library           Collections
Library           RequestsLibrary
Resource          Common.robot

*** Keywords ***
ApiAddTags
    [Arguments]    ${body}
    #ApiAddTags#################################################################################
    ${response}    BasePostRequest    /v1/customize/tags    body=${body}
    #log    ${response} 
    ${tagId}    Set Variable     ${response['data']['tagList'][0]['id']}
    ${rescodeReturn}    Set Variable     ${response['code']}
    [Return]    ${rescodeReturn}    ${objectId}     

ApiEditTags
    [Arguments]    @{body}
    [Return]    ${rescode}    ${objectId}

ApiDeleteTags
    [Arguments]    ${body}
    #删除策略
    log    toApiDeleteTags
    ${response}    BaseDeleteRequest    /v1/customize/tags    ${body}
    ${response_code}    Get From Dictionary    ${response}    code
    Should Be Equal As Strings    ${response_code}    200
    ${response}    Convert to String    ${response}
    Should Be Equal As Strings    ${response}    {'code': 200, 'msg': 'Success', 'success': True}

ApiAddAutoTagsCase
    #ApiAddTags#################################################################################
     ${rescode}    ${tag_id}    ApiAddTags    {"tagList":{"id":0,"isValid":1,"opTime":1585652133641,"opUser":0,"optionType":2,"pid":0,"tagId":"","tagColor":"rgb(21, 101, 192)","tags":[{"tagId":"","tagName":"ApiAutoTest","key":1585652121540}],"tagList":[],"tagCategory":"AutoTest"},"returnData":0}
     log    ${tag_id}
     SET GLOBAL VARIABLE    ${userTagIds}    ${tag_id}
    
ApiDeleteAutoTagsCase
    #ApiAddTags#################################################################################
     ApiDeleteTags    {"ids":[${userTagIds}]}
    