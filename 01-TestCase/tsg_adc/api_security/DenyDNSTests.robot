*** Settings ***
Test Teardown     DeletePolicyAndObject    ${policyIds}    ${objectids}
Force Tags        tsg_adc    tsg_security
Library           OperatingSystem    #Test Setup    Login    #Test Teardown    Logout
Resource          ../../../02-Keyword/tsg_adc/SystemCommand.robot
Resource          ../../../02-Keyword/tsg_bfapi/PolicyObject.robot
Resource          ../../../02-Keyword/tsg_bfapi/LogVariable.robot
Library           Custometest
Resource          ../../../02-Keyword/tsg_common/StmpHandle.robot

*** Test Cases ***
SecurityPolicy-Deny-DNS-00001
    [Tags]    Deny    Fqdn_IP
    #创建对象 IP
    #${rescode}    ${object_IP_Id}    AddObject    {"opAction":"add","returnData":1,"objectList":{"objectType":"ip","isValid":1,"isInitialize":0,"isExclusion":0,"objectName":"zmmtest_IP","objectDesc":"","subObjectIds":[],"addItemList":[{"addrType":4,"protocol":0,"direction":0,"clientIp1":"192.168.50.31","clientIp2":"192.168.50.31","clientIpFormat":"range","clientPortFormat":"","clientPort1":"","clientPort2":"","serverIpFormat":"","serverIp1":"","serverIp2":"","serverPortFormat":"","serverPort1":"","serverPort2":""}],"updateItemList":[],"deleteItemIds":[]}}
    #log    ${object_IP_Id}
    #创建对象 FQDN
    ${rescodeip}    ${object_FQDN_Id}    AddObject    {"opAction":"add","returnData":1,"objectList":{"objectType":"fqdn","isValid":1,"isInitialize":0,"isExclusion":0,"objectName":"zmm_Deny_fqdn_ziroom","objectDesc":"","subObjectIds":[],"addItemList":[{"keywordArray":["$www.ziroom.com"],"itemId":"","isHexbin":0}],"updateItemList":[],"deleteItemIds":[]}}
    log    ${object_FQDN_Id}
    ${objectids}    set Variable    ${object_FQDN_Id}
    #创建策略
    ${addPolicyStr}    set variable    {"opAction":"add","returnData":1,"policyList":{"policyId":"","policyName":"SecurityPolicy-Deny-DNS-00001","policyType":"tsg_security","action":"deny","userTags":"","doBlacklist":0,"doLog":1,"policyDesc":"","effectiveRange":{"tag_sets":[[]]},"userRegion":{"protocol":"DNS","method":"drop","keyring":1},"referenceObject":[{"objectId":${object_FQDN_Id},"protocolFields":["TSG_FIELD_DNS_QNAME"]}],"isValid":1,"scheduleId":[],"appObjectIdArray":[]}}
    ${addPolicyStr}    run keyword if    '${addTestClentIPFlag}'=='1'    set variable    {"opAction":"add","returnData":1,"policyList":{"policyId":"","policyName":"SecurityPolicy-Deny-DNS-00001","policyType":"tsg_security","action":"deny","userTags":"","doBlacklist":0,"doLog":1,"policyDesc":"","effectiveRange":{"tag_sets":[[]]},"userRegion":{"protocol":"DNS","method":"drop","keyring":1},"referenceObject":[{"objectId":${testClentID},"protocolFields":[]},{"objectId":${object_FQDN_Id},"protocolFields":["TSG_FIELD_DNS_QNAME"]}],"isValid":1,"scheduleId":[],"appObjectIdArray":[]}}
    ${rescode}    ${policyId2}    AddPolicy    ${addPolicyStr}
    ${policyId1}    set Variable    {"policyType":"tsg_security","policyIds":[${policyId2}]}
    ${policyIds}    Create List    ${policyId1}
    #${rescode}    ${policyId}    AddPolicy    {"opAction":"add","returnData":1,"policyList":{"policyId":"","policyName":"SecurityPolicy-Deny-DNS-00001","policyType":"tsg_security","action":"deny","userTags":"","doBlacklist":0,"doLog":1,"policyDesc":"","effectiveRange":{"tag_sets":[[]]},"userRegion":{"protocol":"DNS","method":"drop","keyring":1},"referenceObject":[{"objectId":${object_IP_Id},"protocolFields":[]},{"objectId":${object_FQDN_Id},"protocolFields":["TSG_FIELD_DNS_QNAME"]}],"isValid":1,"scheduleId":[],"appObjectIdArray":[]}}
    #log    ${rescode}
    #log    ${policyId}
    #功能端验证
    Sleep    ${policyVerificationSleepSeconds}s
    ${starttime}    Get Time
    ${commandstr}    set variable    nslookup -d www.ziroom.com
    ${stringlista}    set variable   超时
    ${stringlist}    Create List    ${stringlista}
    ${rescode}    SystemCommands    ${commandstr}    ${stringlist}
    Sleep    ${policyLogVerificationSleepSeconds}s
    ${endtime}    Get Time
    #日志验证
    ${s}    Convert to String    ${policyId2}
    GetLogList    security_event_log    ${starttime}    ${endtime}    ${testClentIP}    ${s}    ssl_sni    xiaozhu

SecurityPolicy-Deny-DNS-00002
    [Tags]    Deny    Sub_Category
    #创建对象 Sub
    ${rescode}    ${object_Sub_Id}    AddObject    {"opAction":"add","returnData":1,"objectList":{"objectType":"subscriberid","isValid":1,"isInitialize":0,"isExclusion":0,"objectName":"zmmtest_subid","objectDesc":"","subObjectIds":[],"addItemList":[{"keywordArray":["$zmmtest"],"itemId":"","isHexbin":0}],"updateItemList":[],"deleteItemIds":[]}}
    log    ${object_Sub_Id}
    ${objectids}    set Variable    ${object_Sub_Id}
    #创建对象 Cat
    ${rescodeip}    ${object_Cat_Id}    AddObject    {"opAction":"add","returnData":1,"objectList":{"objectType":"fqdn_category","isValid":1,"isInitialize":0,"isExclusion":0,"objectName":"zmm_Cat_smsp","objectDesc":"","subObjectIds":[],"addItemList":[{"keywordArray":["$smspunch.net"],"itemId":"","isHexbin":0}],"updateItemList":[],"deleteItemIds":[]}}
    log    ${object_Cat_Id}
    ${objectids}    set Variable    ${object_Sub_Id},${object_Cat_Id}
    #创建策略
    ${addPolicyStr}    set variable    {"opAction":"add","returnData":1,"policyList":{"policyId":"","policyName":"SecurityPolicy-Deny-DNS-00002","policyType":"tsg_security","action":"deny","userTags":"","doBlacklist":0,"doLog":1,"policyDesc":"","effectiveRange":{"tag_sets":[[]]},"userRegion":{"protocol":"DNS","method":"redirect","resolution":[{"qtype":"AAAA","answer":[{"atype":"AAAA","value":"e061:82db:c37e:e8c5:c8ab:eab8:5a76:04a9","ttl":{"min":300,"max":300}},{"atype":"CNAME","value":"www.ly.com","ttl":{"min":300,"max":300}}]}],"keyring":1},"referenceObject":[{"objectId":${object_Sub_Id},"protocolFields":[]},{"objectId":${object_Cat_Id},"protocolFields":["TSG_FIELD_DNS_QNAME"]}],"isValid":1,"scheduleId":[],"appObjectIdArray":[]}}
    ${addPolicyStr}    run keyword if    '${addTestClentIPFlag}'=='1'    set variable    {"opAction":"add","returnData":1,"policyList":{"policyId":"","policyName":"SecurityPolicy-Deny-DNS-00002","policyType":"tsg_security","action":"deny","userTags":"","doBlacklist":0,"doLog":1,"policyDesc":"","effectiveRange":{"tag_sets":[[]]},"userRegion":{"protocol":"DNS","method":"redirect","resolution":[{"qtype":"AAAA","answer":[{"atype":"AAAA","value":"e061:82db:c37e:e8c5:c8ab:eab8:5a76:04a9","ttl":{"min":300,"max":300}},{"atype":"CNAME","value":"www.ly.com","ttl":{"min":300,"max":300}}]}],"keyring":1},"referenceObject":[{"objectId":${object_Sub_Id},"protocolFields":[]},{"objectId":${object_Cat_Id},"protocolFields":["TSG_FIELD_DNS_QNAME"]}],"isValid":1,"scheduleId":[],"appObjectIdArray":[]}}
    ${rescode}    ${policyId2}    AddPolicy    ${addPolicyStr}
    ${policyId1}    set Variable    {"policyType":"tsg_security","policyIds":[${policyId2}]}
    ${policyIds}    Create List    ${policyId1}
    #${rescode}    ${policyId}    AddPolicy    {"opAction":"add","returnData":1,"policyList":{"policyId":"","policyName":"SecurityPolicy-Deny-DNS-00002","policyType":"tsg_security","action":"deny","userTags":"","doBlacklist":0,"doLog":1,"policyDesc":"","effectiveRange":{"tag_sets":[[]]},"userRegion":{"protocol":"DNS","method":"redirect","resolution":[{"qtype":"AAAA","answer":[{"atype":"AAAA","value":"e061:82db:c37e:e8c5:c8ab:eab8:5a76:04a9","ttl":{"min":300,"max":300}},{"atype":"CNAME","value":"www.ly.com","ttl":{"min":300,"max":300}}]}],"keyring":1},"referenceObject":[{"objectId":${object_Sub_Id},"protocolFields":[]},{"objectId":${object_Cat_Id},"protocolFields":["TSG_FIELD_DNS_QNAME"]}],"isValid":1,"scheduleId":[],"appObjectIdArray":[]}}
    #log    ${rescode}
    #log    ${policyId}
    #功能端验证
    Sleep    ${policyVerificationSleepSeconds}s
    ${starttime}    Get Time
    ${commandstr}    set variable    nslookup -d www.smspunch.net
    @{stringlist}    set variable    www.ly.com
    ${rescode}    SystemCommands    ${commandstr}    @{stringlist}
    Sleep    ${policyLogVerificationSleepSeconds}s
    ${endtime}    Get Time
    #日志验证
    ${s}    Convert to String    ${policyId2}
    GetLogList    security_event_log    ${starttime}    ${endtime}    ${testClentIP}    ${s}    ssl_sni    xiaozhu


