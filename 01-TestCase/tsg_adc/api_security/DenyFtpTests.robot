*** Settings ***
Test Teardown     DeletePolicyAndObject    ${policyIds}    ${objectids}
Force Tags        tsg_adc    tsg_security
Library           OperatingSystem    
Resource          ../../../02-Keyword/tsg_adc/SystemCommand.robot
Resource          ../../../02-Keyword/tsg_bfapi/PolicyObject.robot
Resource          ../../../02-Keyword/tsg_bfapi/LogVariable.robot
Library           Custometest

*** Test Cases ***
SecurityPolicy-Deny-FTP-00001
    [Tags]    Deny    Sub_Account
    #创建对象 Sub
    ${rescode}    ${object_Sub_Id}    AddObject    {"opAction":"add","returnData":1,"objectList":{"objectType":"subscriberid","isValid":1,"isInitialize":0,"isExclusion":0,"objectName":"zmmtest_subid","objectDesc":"","subObjectIds":[],"addItemList":[{"keywordArray":["$zmmtest"],"itemId":"","isHexbin":0}],"updateItemList":[],"deleteItemIds":[]}}
    log    ${object_Sub_Id}
    ${objectids}    set Variable    ${object_Sub_Id}
    #创建对象 Account
    ${rescodeip}    ${object_Account_Id}    AddObject    {"opAction":"add","returnData":1,"objectList":{"objectType":"account","isValid":1,"isInitialize":0,"isExclusion":0,"objectName":"zmm_Account","objectDesc":"","subObjectIds":[],"addItemList":[{"keywordArray":["anony*"],"itemId":"","isHexbin":0}],"updateItemList":[],"deleteItemIds":[],"objectId":""}}
    log    ${object_Account_Id}
    ${objectids}    set Variable    ${object_Sub_Id},${object_Account_Id}
    #创建策略
    ${addPolicyStr}    set variable    {"opAction":"add","returnData":1,"policyList":{"policyId":"","policyName":"SecurityPolicy-Deny-FTP-00001","policyType":"tsg_security","action":"deny","userTags":"","doBlacklist":0,"doLog":1,"policyDesc":"","effectiveRange":{"tag_sets":[[]]},"userRegion":{"protocol":"FTP","method":"drop","keyring":1},"referenceObject":[{"objectId":${object_Sub_Id} ,"protocolFields":[]},{"objectId":${object_Account_Id} ,"protocolFields":["TSG_FIELD_FTP_ACCOUNT"]}],"isValid":1,"scheduleId":[],"appObjectIdArray":[]}}
    ${addPolicyStr}    run keyword if    '${addTestClentIPFlag}'=='1'    set variable    {"opAction":"add","returnData":1,"policyList":{"policyId":"","policyName":"SecurityPolicy-Deny-FTP-00001","policyType":"tsg_security","action":"deny","userTags":"","doBlacklist":0,"doLog":1,"policyDesc":"","effectiveRange":{"tag_sets":[[]]},"userRegion":{"protocol":"FTP","method":"drop","keyring":1},"referenceObject":[{"objectId":${object_Sub_Id} ,"protocolFields":[]},{"objectId":${object_Account_Id} ,"protocolFields":["TSG_FIELD_FTP_ACCOUNT"]}],"isValid":1,"scheduleId":[],"appObjectIdArray":[]}}
    ${rescode}    ${policyId2}    AddPolicy    ${addPolicyStr}
    ${policyId1}    set Variable    {"policyType":"tsg_security","policyIds":[${policyId2}]}
    ${policyIds}    Create List    ${policyId1}
    #${rescode}    ${policyId}    AddPolicy    {"opAction":"add","returnData":1,"policyList":{"policyId":"","policyName":"SecurityPolicy-Deny-DNS-00002","policyType":"tsg_security","action":"deny","userTags":"","doBlacklist":0,"doLog":1,"policyDesc":"","effectiveRange":{"tag_sets":[[]]},"userRegion":{"protocol":"DNS","method":"redirect","resolution":[{"qtype":"AAAA","answer":[{"atype":"AAAA","value":"e061:82db:c37e:e8c5:c8ab:eab8:5a76:04a9","ttl":{"min":300,"max":300}},{"atype":"CNAME","value":"www.ly.com","ttl":{"min":300,"max":300}}]}],"keyring":1},"referenceObject":[{"objectId":${object_Sub_Id},"protocolFields":[]},{"objectId":${object_Cat_Id},"protocolFields":["TSG_FIELD_DNS_QNAME"]}],"isValid":1,"scheduleId":[],"appObjectIdArray":[]}}
    #log    ${rescode}
    #log    ${policyId}
    #功能端验证
    Sleep    ${policyVerificationSleepSeconds}s
    ${starttime}    Get Time
    ${FTP}    FTP    登录
    should contain    ${FTP}    Deny Success
    Sleep    ${policyLogVerificationSleepSeconds}s
    ${endtime}    Get Time
    #日志验证
    ${s}    Convert to String    ${policyId2}
    GetLogList    security_event_log    ${starttime}    ${endtime}    ${testClentIP}    ${s}    ftp_account    anonymous

SecurityPolicy-Deny-FTP-00002
    [Tags]    Deny    URI_Content
    #创建对象IP
    #${rescode}    ${object_IP_Id}    AddObject    {"opAction":"add","returnData":1,"objectList":{"objectType":"ip","isValid":1,"isInitialize":0,"isExclusion":0,"objectName":"zmmtest_IP","objectDesc":"","subObjectIds":[],"addItemList":[{"addrType":4,"protocol":0,"direction":0,"clientIp1":"192.168.50.31","clientIp2":"192.168.50.31","clientIpFormat":"range","clientPortFormat":"","clientPort1":"","clientPort2":"","serverIpFormat":"","serverIp1":"","serverIp2":"","serverPortFormat":"","serverPort1":"","serverPort2":""}],"updateItemList":[],"deleteItemIds":[]}}
    #log    ${object_IP_Id}
    #创建对象 URI
    ${rescodeip}    ${object_URI_Id}    AddObject    {"opAction":"add","returnData":1,"objectList":{"objectType":"url","isValid":1,"isInitialize":0,"isExclusion":0,"objectName":"ZMM_FTP_URI","objectDesc":"","subObjectIds":[],"addItemList":[{"keywordArray":["*771.txt"],"itemId":"","isHexbin":0}],"updateItemList":[],"deleteItemIds":[],"objectId":""}}
    log    ${object_URI_Id}
    ${objectids}    set Variable    ${object_URI_Id}
    #创建对象 Content
    ${rescode_deny}    ${object_Content_id}    AddObject    {"opAction":"add","returnData":1,"objectList":{"objectType":"keywords","isValid":1,"isInitialize":0,"isExclusion":0,"objectName":"ZMM_FTP_Content","objectDesc":"","subObjectIds":[],"addItemList":[{"keywordArray":["accountsservice"],"isHexbin":0,"itemId":"","isValid":""}],"updateItemList":[],"deleteItemIds":[],"objectId":""}}
    log    ${object_Content_id}
    ${objectids}    set Variable    ${object_URI_Id},${object_Content_id}
    #创建策略
    ${addPolicyStr}    set variable    {"opAction":"add","returnData":1,"policyList":{"policyId":"","policyName":"SecurityPolicy-Deny-FTP-00002","policyType":"tsg_security","action":"deny","userTags":"","doBlacklist":0,"doLog":1,"policyDesc":"","effectiveRange":{"tag_sets":[[]]},"userRegion":{"protocol":"FTP","method":"drop"},"referenceObject":[{"objectId":${object_URI_Id} ,"protocolFields":["TSG_FIELD_FTP_URI"]},{"objectId":${object_Content_id} ,"protocolFields":["TSG_FIELD_FTP_CONTENT"]}],"isValid":1,"scheduleId":[],"appObjectIdArray":[]}}
    ${addPolicyStr}    run keyword if    '${addTestClentIPFlag}'=='1'    set variable    {"opAction":"add","returnData":1,"policyList":{"policyId":"","policyName":"SecurityPolicy-Deny-FTP-00002","policyType":"tsg_security","action":"deny","userTags":"","doBlacklist":0,"doLog":1,"policyDesc":"","effectiveRange":{"tag_sets":[[]]},"userRegion":{"protocol":"FTP","method":"drop"},"referenceObject":[{"objectId":${testClentID},"protocolFields":[]},{"objectId":${object_URI_Id} ,"protocolFields":["TSG_FIELD_FTP_URI"]},{"objectId":${object_Content_id} ,"protocolFields":["TSG_FIELD_FTP_CONTENT"]}],"isValid":1,"scheduleId":[],"appObjectIdArray":[]}}
    ${rescode}    ${policyId2}    AddPolicy    ${addPolicyStr}
    ${policyId1}    set Variable    {"policyType":"tsg_security","policyIds":[${policyId2}]}
    ${policyIds}    Create List    ${policyId1}
    #${rescode}    ${policyId}    AddPolicy    {"opAction":"add","returnData":1,"policyList":{"policyId":"","policyName":"SecurityPolicy-Deny-Http-00001","policyType":"tsg_security","action":"deny","userTags":"","doBlacklist":0,"doLog":1,"policyDesc":"","effectiveRange":{"tag_sets":[[]]},"userRegion":{"protocol":"HTTP","method":"drop","keyring":1},"referenceObject":[{"objectId":${object_IP_Id},"protocolFields":[]},{"objectId":${object_Category_Id},"protocolFields":["TSG_FIELD_HTTP_HOST"]},{"objectId":${object_URL_id},"protocolFields":["TSG_FIELD_HTTP_URL"]},{"objectId":${object_UA_id},"protocolFields":["TSG_FIELD_HTTP_REQ_HDR"]},{"objectId":${object_CT_id},"protocolFields":["TSG_FIELD_HTTP_RES_HDR"]}],"isValid":1,"scheduleId":[],"appObjectIdArray":[]}}
    #${policyIds}    set Variable    {"policyType":"tsg_security","policyIds":[${policyId}]}
    #log    ${rescode}
    #log    ${policyId}
    #功能端验证
    Sleep    ${policyVerificationSleepSeconds}s
    ${starttime}    Get Time
    ${FTP}    FTP    下载
    should contain    ${FTP}    Deny Success
    Sleep    ${policyLogVerificationSleepSeconds}s
    ${endtime}    Get Time
    #日志验证
    ${s}    Convert to String    ${policyId2}
    GetLogList    security_event_log    ${starttime}    ${endtime}    ${testClentIP}    ${s}    ftp_url    ftp://202.38.97.230/pub/iso/linux/knoppix/KNOPPIX_V7.7.1DVD-2016-10-22-EN/dpkg-l-dvd-771.txt

SecurityPolicy-Deny-FTP-00003
    [Tags]    Deny    Sub_Account
    #创建对象 Account
    ${rescodeip}    ${object_Account_Id}    AddObject    {"opAction":"add","returnData":1,"objectList":{"objectType":"account","isValid":1,"isInitialize":0,"isExclusion":0,"objectName":"zmm_Account","objectDesc":"","subObjectIds":[],"addItemList":[{"keywordArray":["anony*"],"itemId":"","isHexbin":0}],"updateItemList":[],"deleteItemIds":[],"objectId":""}}
    log    ${object_Account_Id}
    ${objectids}    set Variable    ${object_Account_Id}
    #创建策略
    ${addPolicyStr}    set variable    {"opAction":"add","returnData":1,"policyList":{"policyId":"","policyName":"SecurityPolicy-Deny-FTP-00001","policyType":"tsg_security","action":"deny","userTags":"","doBlacklist":0,"doLog":1,"policyDesc":"","effectiveRange":{"tag_sets":[[]]},"userRegion":{"protocol":"FTP","method":"drop","keyring":1},"referenceObject":[{"objectId":${object_Account_Id} ,"protocolFields":["TSG_FIELD_FTP_ACCOUNT"]}],"isValid":1,"scheduleId":[],"appObjectIdArray":[]}}
    ${addPolicyStr}    run keyword if    '${addTestClentIPFlag}'=='1'    set variable    {"opAction":"add","returnData":1,"policyList":{"policyId":"","policyName":"SecurityPolicy-Deny-FTP-00001","policyType":"tsg_security","action":"deny","userTags":"","doBlacklist":0,"doLog":1,"policyDesc":"","effectiveRange":{"tag_sets":[[]]},"userRegion":{"protocol":"FTP","method":"drop","keyring":1},"referenceObject":[{"objectId":${object_Account_Id} ,"protocolFields":["TSG_FIELD_FTP_ACCOUNT"]}],"isValid":1,"scheduleId":[],"appObjectIdArray":[]}}
    ${rescode}    ${policyId2}    AddPolicy    ${addPolicyStr}
    ${policyId1}    set Variable    {"policyType":"tsg_security","policyIds":[${policyId2}]}
    ${policyIds}    Create List    ${policyId1}
    #${rescode}    ${policyId}    AddPolicy    {"opAction":"add","returnData":1,"policyList":{"policyId":"","policyName":"SecurityPolicy-Deny-DNS-00002","policyType":"tsg_security","action":"deny","userTags":"","doBlacklist":0,"doLog":1,"policyDesc":"","effectiveRange":{"tag_sets":[[]]},"userRegion":{"protocol":"DNS","method":"redirect","resolution":[{"qtype":"AAAA","answer":[{"atype":"AAAA","value":"e061:82db:c37e:e8c5:c8ab:eab8:5a76:04a9","ttl":{"min":300,"max":300}},{"atype":"CNAME","value":"www.ly.com","ttl":{"min":300,"max":300}}]}],"keyring":1},"referenceObject":[{"objectId":${object_Sub_Id},"protocolFields":[]},{"objectId":${object_Cat_Id},"protocolFields":["TSG_FIELD_DNS_QNAME"]}],"isValid":1,"scheduleId":[],"appObjectIdArray":[]}}
    #log    ${rescode}
    #log    ${policyId}
    #功能端验证
    Sleep    ${policyVerificationSleepSeconds}s
    ${starttime}    Get Time
    ${FTP}    FTP    登录
    should contain    ${FTP}    Deny Success
    Sleep    ${policyLogVerificationSleepSeconds}s
    ${endtime}    Get Time
    #日志验证
    ${s}    Convert to String    ${policyId2}
    GetLogList    security_event_log    ${starttime}    ${endtime}    ${testClentIP}    ${s}    ftp_account    anonymous


