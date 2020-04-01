*** Settings ***
Test Teardown     DeletePolicyAndObject    ${policyIds}    ${objectids}
Force Tags        tsg_adc    tsg_security
Library           OperatingSystem    #Test Setup    Login    #Test Teardown    Logout
Resource          ../../02-Keyword/tsg-adc/systemcommand.txt
Resource          ../../02-Keyword/tsg-bf-api/policyobject.txt
Resource          ../../02-Keyword/tsg-bf-api/logvariable.txt
Resource          ../../02-Keyword/tsg-bf-api/logschema.txt    #Resource    log-3.robot
Library           custometest
Resource          ../../02-Keyword/tsg-ui/StmpHandle2.robot

*** Test Cases ***
SecurityPolicy-Deny-SSL-00001
    [Tags]    Deny    SSL    SNI_SAN_CN_Category
    #创建对象 IP
    #${rescode}    ${object_IP_Id}    AddObject    {"opAction":"add","returnData":1,"objectList":{"objectType":"ip","isValid":1,"isInitialize":0,"isExclusion":0,"objectName":"zmmtest_IP","objectDesc":"","subObjectIds":[],"addItemList":[{"addrType":4,"protocol":0,"direction":0,"clientIp1":"192.168.50.31","clientIp2":"192.168.50.31","clientIpFormat":"range","clientPortFormat":"","clientPort1":"","clientPort2":"","serverIpFormat":"","serverIp1":"","serverIp2":"","serverPortFormat":"","serverPort1":"","serverPort2":""}],"updateItemList":[],"deleteItemIds":[]}}
    #log    ${object_IP_Id}
    #${objectids}    set Variable    ${object_Subid_Id}
    #创建对象 SNI_CAT
    ${rescodeip}    ${object_SNI_CAT_Id}    AddObject    {"opAction":"add","returnData":1,"objectList":{"objectType":"fqdn_category","isValid":1,"isInitialize":0,"isExclusion":0,"objectName":"zmm_SSL_jd_cat","objectDesc":"","subObjectIds":[],"addItemList":[{"keywordArray":["*d.com"],"itemId":"","isValid":"","isHexbin":0}],"updateItemList":[],"deleteItemIds":[]}}
    log    ${object_SNI_CAT_Id}
    ${objectids}    set Variable    ${object_SNI_CAT_Id}
    #创建对象 SAN_CAT
    ${rescode_deny}    ${object_SAN_CAT_id}    AddObject    {"opAction":"add","returnData":1,"objectList":{"objectType":"fqdn_category","isValid":1,"isInitialize":0,"isExclusion":0,"objectName":"zmm_SSL_jd_cat","objectDesc":"","subObjectIds":[],"addItemList":[{"keywordArray":["*d.com"],"itemId":"","isValid":"","isHexbin":0}],"updateItemList":[],"deleteItemIds":[]}}
    log    ${object_SAN_CAT_id}
    ${objectids}    set Variable    ${object_SNI_CAT_Id},${object_SAN_CAT_id}
    #创建对象 CN_CAT
    ${rescode_deny}    ${object_CN_CAT_id}    AddObject    {"opAction":"add","returnData":1,"objectList":{"objectType":"fqdn_category","isValid":1,"isInitialize":0,"isExclusion":0,"objectName":"zmm_SSL_jd_cat","objectDesc":"","subObjectIds":[],"addItemList":[{"keywordArray":["*d.com"],"itemId":"","isValid":"","isHexbin":0}],"updateItemList":[],"deleteItemIds":[]}}
    log    ${object_CN_CAT_id}
    ${objectids}    set Variable    ${object_SNI_CAT_Id},${object_SAN_CAT_id},${object_CN_CAT_id}
    #创建策略
    ${addPolicyStr}    set variable    {"opAction":"add","returnData":1,"policyList":{"policyId":"","policyName":"SecurityPolicy-Deny-SSL-00001","policyType":"tsg_security","action":"deny","userTags":"","doBlacklist":0,"doLog":1,"policyDesc":"","effectiveRange":{"tag_sets":[[]]},"userRegion":{"protocol":"SSL","method":"drop","keyring":1},"referenceObject":[{"objectId":${object_SNI_CAT_Id},"protocolFields":["TSG_FIELD_SSL_SNI"]},{"objectId":${object_CN_CAT_id},"protocolFields":["TSG_FIELD_SSL_CN"]},{"objectId":${object_SAN_CAT_id},"protocolFields":["TSG_FIELD_SSL_SAN"]}],"isValid":1,"scheduleId":[],"appObjectIdArray":[]}}
    ${addPolicyStr}    run keyword if    '${addTestClentIPFlag}'=='1'    set variable    {"opAction":"add","returnData":1,"policyList":{"policyId":"","policyName":"SecurityPolicy-Deny-SSL-00001","policyType":"tsg_security","action":"deny","userTags":"","doBlacklist":0,"doLog":1,"policyDesc":"","effectiveRange":{"tag_sets":[[]]},"userRegion":{"protocol":"SSL","method":"drop","keyring":1},"referenceObject":[{"objectId":${testClentID},"protocolFields":[]},{"objectId":${object_SNI_CAT_Id},"protocolFields":["TSG_FIELD_SSL_SNI"]},{"objectId":${object_CN_CAT_id},"protocolFields":["TSG_FIELD_SSL_CN"]},{"objectId":${object_SAN_CAT_id},"protocolFields":["TSG_FIELD_SSL_SAN"]}],"isValid":1,"scheduleId":[],"appObjectIdArray":[]}}
    ${rescode}    ${policyId2}    AddPolicy    ${addPolicyStr}
    ${policyId1}    set Variable    {"policyType":"tsg_security","policyIds":[${policyId2}]}
    ${policyIds}    Create List    ${policyId1}
    #${rescode}    ${policyId}    AddPolicy    {"opAction":"add","returnData":1,"policyList":{"policyId":"","policyName":"SecurityPolicy-Deny-SSL-00001","policyType":"tsg_security","action":"deny","userTags":"","doBlacklist":0,"doLog":1,"policyDesc":"","effectiveRange":{"tag_sets":[[]]},"userRegion":{"protocol":"SSL","method":"drop","keyring":1},"referenceObject":[{"objectId":${object_IP_Id},"protocolFields":[]},{"objectId":${object_SNI_CAT_Id},"protocolFields":["TSG_FIELD_SSL_SNI"]},{"objectId":${object_CN_CAT_id},"protocolFields":["TSG_FIELD_SSL_CN"]},{"objectId":${object_SAN_CAT_id},"protocolFields":["TSG_FIELD_SSL_SAN"]}],"isValid":1,"scheduleId":[],"appObjectIdArray":[]}}
    #log    ${rescode}
    #log    ${policyId}
    #功能端验证
    Sleep    ${policyVerificationSleepSeconds}s
    ${starttime}    Get Time
    ${commandreturn}    OperatingSystem.Run    curl -I \ -m \ 10 \ -o \ /dev/null \ -s \ -w \ \ \%{http_code} \ \ https://www.jd.com
    should contain    ${commandreturn}    000
    Sleep    ${policyLogVerificationSleepSeconds}s
    ${endtime}    Get Time
    #日志验证
    ${s}    Convert to String    ${policyId2}
    GetLogList    security_event_log    ${starttime}    ${endtime}    ${testClentIP}    ${s}    ssl_sni    xiaozhu

SecurityPolicy-Deny-SSL-00002
    [Tags]    Deny    Fqdn_SNI_CN_SAN
    #创建对象 Sub
    ${rescode}    ${object_Sub_Id}    AddObject    {"opAction":"add","returnData":1,"objectList":{"objectType":"subscriberid","isValid":1,"isInitialize":0,"isExclusion":0,"objectName":"zmmtest_subid","objectDesc":"","subObjectIds":[],"addItemList":[{"keywordArray":["$zmmtest"],"itemId":"","isHexbin":0}],"updateItemList":[],"deleteItemIds":[]}}
    log    ${object_Sub_Id}
    ${objectids}    set Variable    ${object_Sub_Id}
    #创建对象 SNI_FQDN
    ${rescodeip}    ${object_SNI_FQDN_Id}    AddObject    {"opAction":"add","returnData":1,"objectList":{"objectType":"fqdn","isValid":1,"isInitialize":0,"isExclusion":0,"objectName":"zmm_SSL_sogou","objectDesc":"","subObjectIds":[],"addItemList":[{"keywordArray":["*ogou.com"],"itemId":"","isHexbin":0}],"updateItemList":[],"deleteItemIds":[]}}
    log    ${object_SNI_FQDN_Id}
    ${objectids}    set Variable    ${object_Sub_Id},${object_SNI_FQDN_Id}
    #创建对象 SAN_FQDN
    ${rescode_deny}    ${object_SAN_FQDN_id}    AddObject    {"opAction":"add","returnData":1,"objectList":{"objectType":"fqdn","isValid":1,"isInitialize":0,"isExclusion":0,"objectName":"zmm_SSL_sogou","objectDesc":"","subObjectIds":[],"addItemList":[{"keywordArray":["*ogou.com"],"itemId":"","isHexbin":0}],"updateItemList":[],"deleteItemIds":[]}}
    log    ${object_SAN_FQDN_id}
    ${objectids}    set Variable    ${object_Sub_Id},${object_SNI_FQDN_Id},${object_SAN_FQDN_id}
    #创建对象 CN_FQDN
    ${rescode_deny}    ${object_CN_FQDN_id}    AddObject    {"opAction":"add","returnData":1,"objectList":{"objectType":"fqdn","isValid":1,"isInitialize":0,"isExclusion":0,"objectName":"zmm_SSL_sogou","objectDesc":"","subObjectIds":[],"addItemList":[{"keywordArray":["*ogou.com"],"itemId":"","isHexbin":0}],"updateItemList":[],"deleteItemIds":[]}}
    log    ${object_CN_FQDN_id}
    ${objectids}    set Variable    ${object_Sub_Id},${object_SNI_FQDN_Id},${object_SAN_FQDN_id},${object_CN_FQDN_id}
    #创建策略
    ${addPolicyStr}    set variable    {"opAction":"add","returnData":1,"policyList":{"policyId":"","policyName":"SecurityPolicy-Deny-SSL-00002","policyType":"tsg_security","action":"deny","userTags":"","doBlacklist":0,"doLog":1,"policyDesc":"","effectiveRange":{"tag_sets":[[]]},"userRegion":{"protocol":"SSL","method":"drop","keyring":1},"referenceObject":[{"objectId":${object_Sub_Id},"protocolFields":[]},{"objectId":${object_SNI_FQDN_Id},"protocolFields":["TSG_FIELD_SSL_SNI"]},{"objectId":${object_CN_FQDN_id},"protocolFields":["TSG_FIELD_SSL_CN"]},{"objectId":${object_SAN_FQDN_id},"protocolFields":["TSG_FIELD_SSL_SAN"]}],"isValid":1,"scheduleId":[],"appObjectIdArray":[]}}
    ${addPolicyStr}    run keyword if    '${addTestClentIPFlag}'=='1'    set variable    {"opAction":"add","returnData":1,"policyList":{"policyId":"","policyName":"SecurityPolicy-Deny-SSL-00002","policyType":"tsg_security","action":"deny","userTags":"","doBlacklist":0,"doLog":1,"policyDesc":"","effectiveRange":{"tag_sets":[[]]},"userRegion":{"protocol":"SSL","method":"drop","keyring":1},"referenceObject":[{"objectId":${object_Sub_Id},"protocolFields":[]},{"objectId":${object_SNI_FQDN_Id},"protocolFields":["TSG_FIELD_SSL_SNI"]},{"objectId":${object_CN_FQDN_id},"protocolFields":["TSG_FIELD_SSL_CN"]},{"objectId":${object_SAN_FQDN_id},"protocolFields":["TSG_FIELD_SSL_SAN"]}],"isValid":1,"scheduleId":[],"appObjectIdArray":[]}}
    ${rescode}    ${policyId2}    AddPolicy    ${addPolicyStr}
    ${policyId1}    set Variable    {"policyType":"tsg_security","policyIds":[${policyId2}]}
    ${policyIds}    Create List    ${policyId1}
    #${rescode}    ${policyId}    AddPolicy    {"opAction":"add","returnData":1,"policyList":{"policyId":"","policyName":"SecurityPolicy-Deny-SSL-00002","policyType":"tsg_security","action":"deny","userTags":"","doBlacklist":0,"doLog":1,"policyDesc":"","effectiveRange":{"tag_sets":[[]]},"userRegion":{"protocol":"SSL","method":"drop","keyring":1},"referenceObject":[{"objectId":${object_Sub_Id},"protocolFields":[]},{"objectId":${object_SNI_FQDN_Id},"protocolFields":["TSG_FIELD_SSL_SNI"]},{"objectId":${object_CN_FQDN_id},"protocolFields":["TSG_FIELD_SSL_CN"]},{"objectId":${object_SAN_FQDN_id},"protocolFields":["TSG_FIELD_SSL_SAN"]}],"isValid":1,"scheduleId":[],"appObjectIdArray":[]}}
    #log    ${rescode}
    #log    ${policyId}
    #功能端验证
    Sleep    ${policyVerificationSleepSeconds}s
    ${starttime}    Get Time
    ${commandreturn}    OperatingSystem.Run    curl -I \ -m \ 10 \ -o \ /dev/null \ -s \ -w \ \ \%{http_code} \ \ https://www.sogou.com
    should contain    ${commandreturn}    200
    Sleep    ${policyLogVerificationSleepSeconds}s
    ${endtime}    Get Time
    #日志验证
    ${s}    Convert to String    ${policyId2}
    GetLogList    security_event_log    ${starttime}    ${endtime}    ${testClentIP}    ${s}    ssl_sni    xiaozhu


