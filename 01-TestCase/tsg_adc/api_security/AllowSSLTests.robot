*** Settings ***
Test Teardown     DeletePolicyAndObject    ${policyIds}    ${objectids}
Force Tags        tsg_adc    tsg_security
Library           OperatingSystem    
Resource          ../../../02-Keyword/tsg_adc/SystemCommand.robot
Resource          ../../../02-Keyword/tsg_bfapi/PolicyObject.robot
Resource          ../../../02-Keyword/tsg_bfapi/LogVariable.robot

*** Variables ***
${policyIds}      ${EMPTY}
${objectids}      ${EMPTY}

*** Test Cases ***
SecurityPolicy-Allow-SSL-00001
    [Tags]    Allow    IP    FQDN    DENY    HTTP
    #创建对象IP
    #${rescode}    ${object_IP_Id}    AddObject    {"opAction":"add","returnData":1,"objectList":{"objectType":"ip","isValid":1,"isInitialize":0,"isExclusion":0,"objectName":"zmmtest_IP","objectDesc":"","subObjectIds":[],"addItemList":[{"addrType":4,"protocol":0,"direction":0,"clientIp1":"192.168.50.31","clientIp2":"192.168.50.31","clientIpFormat":"range","clientPortFormat":"","clientPort1":"","clientPort2":"","serverIpFormat":"","serverIp1":"","serverIp2":"","serverPortFormat":"","serverPort1":"","serverPort2":""}],"updateItemList":[],"deleteItemIds":[]}}
    #log    ${object_IP_Id}
    #创建对象FQDN
    ${rescodeip}    ${object_FQDN_Id}    AddObject    {"opAction":"add","returnData":1,"objectList":{"objectType":"fqdn","isValid":1,"isInitialize":0,"isExclusion":0,"objectName":"zmmtest_FQDN_icbc","objectDesc":"","subObjectIds":[],"addItemList":[{"keywordArray":["*ww.sogou.com"],"itemId":"","isHexbin":0}],"updateItemList":[],"deleteItemIds":[]}}
    log    ${object_FQDN_Id}
    ${objectids}    set Variable    ${object_FQDN_Id}
    #创建 Deny 搭配Allow
    ${addPolicyStr}    set variable    {"opAction":"add","returnData":1,"policyList":{"policyName":"SecurityPolicy-Allow-SSL-00001_deny","policyType":"tsg_security","action":"deny","userTags":"","doBlacklist":0,"doLog":1,"policyDesc":"","effectiveRange":{"tag_sets":[[]]},"userRegion":{"protocol":"SSL","method":"drop","keyring":1},"referenceObject":[{"objectId":${object_FQDN_Id},"protocolFields":["TSG_FIELD_SSL_SNI"]}],"isValid":1,"scheduleId":[],"appObjectIdArray":[]}}
    ${addPolicyStr}    run keyword if    '${addTestClentIPFlag}'=='1'    set variable    {"opAction":"add","returnData":1,"policyList":{"policyName":"SecurityPolicy-Allow-SSL-00001_deny","policyType":"tsg_security","action":"deny","userTags":"","doBlacklist":0,"doLog":1,"policyDesc":"","effectiveRange":{"tag_sets":[[]]},"userRegion":{"protocol":"SSL","method":"drop","keyring":1},"referenceObject":[{"objectId":${testClentID},"protocolFields":[]},{"objectId":${object_FQDN_Id},"protocolFields":["TSG_FIELD_SSL_SNI"]}],"isValid":1,"scheduleId":[],"appObjectIdArray":[]}}
    log    ${addPolicyStr}
    ${rescode}    ${policyId1}    AddPolicy    ${addPolicyStr}
    log    ${policyId1}
    ${policyIds}    set Variable    {"policyType":"tsg_security","policyIds":[${policyId1}]}
    #创建策略
    ${addPolicyStr}    set variable    {"opAction":"add","returnData":1,"policyList":{"policyName":"SecurityPolicy-Allow-SSL-00001","policyType":"tsg_security","action":"allow","userTags":"","doBlacklist":0,"doLog":1,"policyDesc":"","effectiveRange":{"tag_sets":[[]]},"userRegion":{"protocol":"SSL","keyring":1},"referenceObject":[{"objectId":${object_FQDN_Id},"protocolFields":["TSG_FIELD_SSL_SNI"]}],"isValid":1,"scheduleId":[],"appObjectIdArray":[]}}
    ${addPolicyStr}    run keyword if    '${addTestClentIPFlag}'=='1'    set variable    {"opAction":"add","returnData":1,"policyList":{"policyName":"SecurityPolicy-Allow-SSL-00001","policyType":"tsg_security","action":"allow","userTags":"","doBlacklist":0,"doLog":1,"policyDesc":"","effectiveRange":{"tag_sets":[[]]},"userRegion":{"protocol":"SSL","keyring":1},"referenceObject":[{"objectId":${testClentID},"protocolFields":[]},{"objectId":${object_FQDN_Id},"protocolFields":["TSG_FIELD_SSL_SNI"]}],"isValid":1,"scheduleId":[],"appObjectIdArray":[]}} \
    ${rescode}    ${policyId2}    AddPolicy    ${addPolicyStr}
    log    ${policyId2}
    ${policyIds1}    set Variable    {"policyType":"tsg_security","policyIds":[${policyId1}]}
    ${policyIds2}    set Variable    {"policyType":"tsg_security","policyIds":[${policyId2}]}
    ${policyIds}    Create List    ${policyIds1}    ${policyIds2}
    #${rescode}    ${policyId}    AddPolicy    {"opAction":"add","returnData":1,"policyList":{"policyName":"SecurityPolicy-Allow-Http-00001","policyType":"tsg_security","action":"allow","userTags":"","doBlacklist":0,"doLog":1,"policyDesc":"","effectiveRange":{"tag_sets":[[]]},"userRegion":{"protocol":"HTTP","keyring":1},"referenceObject":[{"objectId":${object_IP_Id},"protocolFields":[]},{"objectId":${object_FQDN_Id},"protocolFields":["TSG_FIELD_HTTP_HOST"]}],"isValid":1,"scheduleId":[],"appObjectIdArray":[]}}
    #功能端验证
    Sleep    ${policyVerificationSleepSeconds}s
    ${starttime}    Get Time
    ${commandreturn}    OperatingSystem.Run    curl -I \ -m \ 10 \ -o \ /dev/null \ -s \ -w \ \ \%{http_code} \ \ https://www.sogou.com
    should contain    ${commandreturn}    200
    Sleep    ${policyLogVerificationSleepSeconds}s
    ${endtime}    Get Time
    #日志验证
    ${s}    Convert to String    ${policyId2}
    GetLogList    security_event_log    ${starttime}    ${endtime}    ${testClentIP}    ${s}    ssl_sni    icbc

SecurityPolicy-Allow-SSL-00002
    [Tags]    Allow    SubID    Category    DENY    HTTP
    #创建对象Subid
    ${rescode}    ${object_Subid_Id}    AddObject    {"opAction":"add","returnData":1,"objectList":{"objectType":"subscriberid","isValid":1,"isInitialize":0,"isExclusion":0,"objectName":"zmmtest_subid","objectDesc":"","subObjectIds":[],"addItemList":[{"keywordArray":["$zmmtest"],"itemId":"","isHexbin":0}],"updateItemList":[],"deleteItemIds":[]}}
    log    ${object_Subid_Id}
    ${objectids}    set Variable    ${object_Subid_Id}
    #创建对象Categry
    ${rescodeip}    ${object_Category_Id}    AddObject    {"opAction":"add","returnData":1,"objectList":{"objectType":"fqdn_category","isValid":1,"isInitialize":0,"isExclusion":0,"objectName":"zmmtest_category","objectDesc":"","subObjectIds":[],"addItemList":[{"keywordArray":["*arch.jd.com"],"itemId":"","isHexbin":0}],"updateItemList":[],"deleteItemIds":[]}}
    log    ${object_Category_Id}
    ${objectids}    set Variable    ${object_Subid_Id},${object_Category_Id}
    #创建 Deny 搭配Allow
    ${addPolicyStr}    set variable    {"opAction":"add","returnData":1,"policyList":{"policyName":"SecurityPolicy-Allow-SSL-00001_deny","policyType":"tsg_security","action":"deny","userTags":"","doBlacklist":0,"doLog":1,"policyDesc":"","effectiveRange":{"tag_sets":[[]]},"userRegion":{"protocol":"SSL","method":"drop","keyring":1},"referenceObject":[{"objectId":${object_Subid_Id} ,"protocolFields":[]},{"objectId":${object_Category_Id} ,"protocolFields":["TSG_FIELD_SSL_SNI"]}],"isValid":1,"scheduleId":[],"appObjectIdArray":[]}}
    ${addPolicyStr}    run keyword if    '${addTestClentIPFlag}'=='1'    set variable    {"opAction":"add","returnData":1,"policyList":{"policyName":"SecurityPolicy-Allow-SSL-00001_deny","policyType":"tsg_security","action":"deny","userTags":"","doBlacklist":0,"doLog":1,"policyDesc":"","effectiveRange":{"tag_sets":[[]]},"userRegion":{"protocol":"SSL","method":"drop","keyring":1},"referenceObject":[{"objectId":${object_Subid_Id} ,"protocolFields":[]},{"objectId":${object_Category_Id} ,"protocolFields":["TSG_FIELD_SSL_SNI"]}],"isValid":1,"scheduleId":[],"appObjectIdArray":[]}}
    log    ${addPolicyStr}
    ${rescode}    ${policyId1}    AddPolicy    ${addPolicyStr}
    log    ${policyId1}
    ${policyIds}    set Variable    {"policyType":"tsg_security","policyIds":[${policyId1}]}
    #创建策略
    ${addPolicyStr}    set variable    {"opAction":"add","returnData":1,"policyList":{"policyName":"SecurityPolicy-Allow-SSL-00002","policyType":"tsg_security","action":"allow","userTags":"","doBlacklist":0,"doLog":1,"policyDesc":"","effectiveRange":{"tag_sets":[[]]},"userRegion":{"protocol":"SSL","keyring":1},"referenceObject":[{"objectId":${object_Subid_Id},"protocolFields":[]},{"objectId":${object_Category_Id},"protocolFields":["TSG_FIELD_SSL_SNI"]}],"isValid":1,"scheduleId":[],"appObjectIdArray":[]}}
    ${addPolicyStr}    run keyword if    '${addTestClentIPFlag}'=='1'    set variable    {"opAction":"add","returnData":1,"policyList":{"policyName":"SecurityPolicy-Allow-SSL-00002","policyType":"tsg_security","action":"allow","userTags":"","doBlacklist":0,"doLog":1,"policyDesc":"","effectiveRange":{"tag_sets":[[]]},"userRegion":{"protocol":"SSL","keyring":1},"referenceObject":[{"objectId":${object_Subid_Id},"protocolFields":[]},{"objectId":${object_Category_Id},"protocolFields":["TSG_FIELD_SSL_SNI"]}],"isValid":1,"scheduleId":[],"appObjectIdArray":[]}}
    ${rescode}    ${policyId2}    AddPolicy    ${addPolicyStr}
    log    ${policyId2}
    ${policyIds1}    set Variable    {"policyType":"tsg_security","policyIds":[${policyId1}]}
    ${policyIds2}    set Variable    {"policyType":"tsg_security","policyIds":[${policyId2}]}
    ${policyIds}    Create List    ${policyIds1}    ${policyIds2}
    #${rescode}    ${policyId}    AddPolicy    {"opAction":"add","returnData":1,"policyList":{"policyName":"SecurityPolicy-Allow-Http-00002","policyType":"tsg_security","action":"allow","userTags":"","doBlacklist":0,"doLog":1,"policyDesc":"","effectiveRange":{"tag_sets":[[]]},"userRegion":{"protocol":"HTTP","keyring":1},"referenceObject":[{"objectId":${object_Subid_Id},"protocolFields":[]},{"objectId":${object_Category_Id},"protocolFields":["TSG_FIELD_HTTP_HOST"]}],"isValid":1,"scheduleId":[],"appObjectIdArray":[]}}
    #log    ${rescode}
    #log    ${policyId}
    #功能端验证
    Sleep    ${policyVerificationSleepSeconds}s
    ${starttime}    Get Time
    ${commandreturn}    OperatingSystem.Run    curl -I \ -m \ 10 \ -o \ /dev/null \ -s \ -w \ \ \%{http_code} \ \ http://www.ccb.com
    should contain    ${commandreturn}    200
    Sleep    ${policyLogVerificationSleepSeconds}s
    ${endtime}    Get Time
    #日志验证
    ${s}    Convert to String    ${policyId2}
    GetLogList    security_event_log    ${starttime}    ${endtime}    ${testClentIP}    ${s}    ssl_sni    icbc
