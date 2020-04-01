*** Settings ***
Test Teardown     DeletePolicyAndObject    ${policyIds}    ${objectids}
Force Tags        tsg_adc    tsg_security
Library           OperatingSystem    
Resource          ../../../02-Keyword/tsg_adc/SystemCommand.robot
Resource          ../../../02-Keyword/tsg_bfapi/PolicyObject.robot
Resource          ../../../02-Keyword/tsg_bfapi/LogVariable.robot
Library           Custometest

*** Test Cases ***
SecurityPolicy-Deny-HTTP-00001
    [Tags]    Deny    Category_Url_UA_CT
    #创建对象IP
    #${rescode}    ${object_IP_Id}    AddObject    {"opAction":"add","returnData":1,"objectList":{"objectType":"ip","isValid":1,"isInitialize":0,"isExclusion":0,"objectName":"zmmtest_IP","objectDesc":"","subObjectIds":[],"addItemList":[{"addrType":4,"protocol":0,"direction":0,"clientIp1":"192.168.50.31","clientIp2":"192.168.50.31","clientIpFormat":"range","clientPortFormat":"","clientPort1":"","clientPort2":"","serverIpFormat":"","serverIp1":"","serverIp2":"","serverPortFormat":"","serverPort1":"","serverPort2":""}],"updateItemList":[],"deleteItemIds":[]}}
    #log    ${object_IP_Id}
    #创建对象Category
    ${rescodeip}    ${object_Category_Id}    AddObject    {"opAction":"add","returnData":1,"objectList":{"objectType":"fqdn_category","isValid":1,"isInitialize":0,"isExclusion":0,"objectName":"zmm_cat_ziroom","objectDesc":"","subObjectIds":[],"addItemList":[{"keywordArray":["*oom.com"],"itemId":"","isHexbin":0}],"updateItemList":[],"deleteItemIds":[]}}
    log    ${object_Category_Id}
    ${objectids}    set Variable    ${object_Category_Id}
    #创建对象URL
    ${rescode_deny}    ${object_URL_id}    AddObject    {"opAction":"add","returnData":1,"objectList":{"objectType":"url","isValid":1,"isInitialize":0,"isExclusion":0,"objectName":"zmmtest_url-ziroom","objectDesc":"","subObjectIds":[],"addItemList":[{"keywordArray":["www.ziroom.com/li*"],"itemId":"","isHexbin":0}],"updateItemList":[],"deleteItemIds":[]}}
    log    ${object_URL_id}
    ${objectids}    set Variable    ${object_Category_Id},${object_URL_id}
    #创建对象UA
    ${rescode_deny}    ${object_UA_id}    AddObject    {"opAction":"add","returnData":1,"objectList":{"objectType":"http_signature","isValid":1,"isInitialize":0,"isExclusion":0,"objectName":"zmm_ua_ziroom","objectDesc":"","subObjectIds":[],"addItemList":[{"keywordArray":["Mozilla/5.0*"],"isHexbin":0,"district":"User-Agent"}],"updateItemList":[],"deleteItemIds":[]}}
    log    ${object_UA_id}
    ${objectids}    set Variable    ${object_Category_Id},${object_URL_id},${object_UA_id}
    #创建对象CT
    ${rescode_deny}    ${object_CT_id}    AddObject    {"opAction":"add","returnData":1,"objectList":{"objectType":"http_signature","isValid":1,"isInitialize":0,"isExclusion":0,"objectName":"zmm_ct_ziroom","objectDesc":"","subObjectIds":[],"addItemList":[{"keywordArray":["text/html; charse*"],"isHexbin":0,"district":"Content-Type"}],"updateItemList":[],"deleteItemIds":[]}}
    log    ${object_CT_id}
    ${objectids}    set Variable    ${object_Category_Id},${object_URL_id},${object_UA_id},${object_CT_id}
    #创建策略
    ${addPolicyStr}    set variable    {"opAction":"add","returnData":1,"policyList":{"policyId":"","policyName":"SecurityPolicy-Deny-Http-00001","policyType":"tsg_security","action":"deny","userTags":"","doBlacklist":0,"doLog":1,"policyDesc":"","effectiveRange":{"tag_sets":[[]]},"userRegion":{"protocol":"HTTP","method":"drop","keyring":1},"referenceObject":[{"objectId":${object_Category_Id},"protocolFields":["TSG_FIELD_HTTP_HOST"]},{"objectId":${object_URL_id},"protocolFields":["TSG_FIELD_HTTP_URL"]},{"objectId":${object_UA_id},"protocolFields":["TSG_FIELD_HTTP_REQ_HDR"]},{"objectId":${object_CT_id},"protocolFields":["TSG_FIELD_HTTP_RES_HDR"]}],"isValid":1,"scheduleId":[],"appObjectIdArray":[]}}
    ${addPolicyStr}    run keyword if    '${addTestClentIPFlag}'=='1'    set variable    {"opAction":"add","returnData":1,"policyList":{"policyId":"","policyName":"SecurityPolicy-Deny-Http-00001","policyType":"tsg_security","action":"deny","userTags":"","doBlacklist":0,"doLog":1,"policyDesc":"","effectiveRange":{"tag_sets":[[]]},"userRegion":{"protocol":"HTTP","method":"drop","keyring":1},"referenceObject":[{"objectId":${testClentID},"protocolFields":[]},{"objectId":${object_Category_Id},"protocolFields":["TSG_FIELD_HTTP_HOST"]},{"objectId":${object_URL_id},"protocolFields":["TSG_FIELD_HTTP_URL"]},{"objectId":${object_UA_id},"protocolFields":["TSG_FIELD_HTTP_REQ_HDR"]},{"objectId":${object_CT_id},"protocolFields":["TSG_FIELD_HTTP_RES_HDR"]}],"isValid":1,"scheduleId":[],"appObjectIdArray":[]}}
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
    ${commandreturn}    OperatingSystem.Run    curl --user-agent "Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/31.0.1650.63 Safari/537.36" --referer 'http://www.baidu.com/' \ http://www.ziroom.com/life/index \ \ | iconv -f utf-8 -t gbk
    should not contain    ${commandreturn}    营业执照
    Sleep    ${policyLogVerificationSleepSeconds}s
    ${endtime}    Get Time
    #日志验证
    ${s}    Convert to String    ${policyId2}
    GetLogList    security_event_log    ${starttime}    ${endtime}    ${testClentIP}    ${s}    http_host    ziroom

SecurityPolicy-Deny-HTTP-00002
    [Tags]    Deny    Fqdn_Url_CK_SC
    #创建对象SubID
    ${rescode}    ${object_Subid_Id}    AddObject    {"opAction":"add","returnData":1,"objectList":{"objectType":"subscriberid","isValid":1,"isInitialize":0,"isExclusion":0,"objectName":"zmmtest_subid","objectDesc":"","subObjectIds":[],"addItemList":[{"keywordArray":["$zmmtest"],"itemId":"","isHexbin":0}],"updateItemList":[],"deleteItemIds":[]}}
    log    ${object_Subid_Id}
    ${objectids}    set Variable    ${object_Subid_Id}
    #创建对象FQDN
    ${rescodeip}    ${object_FQDN_Id}    AddObject    {"opAction":"add","returnData":1,"objectList":{"objectType":"fqdn","isValid":1,"isInitialize":0,"isExclusion":0,"objectName":"zmm_xiaozhu_fqdn","objectDesc":"","subObjectIds":[],"addItemList":[{"keywordArray":["*zhu.com"],"itemId":"","isHexbin":0}],"updateItemList":[],"deleteItemIds":[]}}
    log    ${object_FQDN_Id}
    ${objectids}    set Variable    ${object_Subid_Id},${object_FQDN_Id}
    #创建对象URL
    ${rescode_deny}    ${object_URL_id}    AddObject    {"opAction":"add","returnData":1,"objectList":{"objectType":"url","isValid":1,"isInitialize":0,"isExclusion":0,"objectName":"zmm_xiaozhu_url","objectDesc":"","subObjectIds":[],"addItemList":[{"keywordArray":["*ozhu.com/"],"itemId":"","isHexbin":0}],"updateItemList":[],"deleteItemIds":[]}}
    log    ${object_URL_id}
    ${objectids}    set Variable    ${object_Subid_Id},${object_FQDN_Id},${object_URL_id}
    #创建对象CK
    ${rescode_deny}    ${object_CK_id}    AddObject    {"opAction":"add","returnData":1,"objectList":{"objectType":"http_signature","isValid":1,"isInitialize":0,"isExclusion":0,"objectName":"zmm_xiaozhu_cookie","objectDesc":"","subObjectIds":[],"addItemList":[{"keywordArray":["*_math=czsuv8n9d4p; Hm_lvt_92e8bc890f374994dd570aa15afc99e1=1575187416; Hm_lpvt_92e8bc890f374994dd570aa15afc99e1=1575187416; _uab_collina=157518741578524001717192"],"isHexbin":0,"district":"Cookie"}],"updateItemList":[],"deleteItemIds":[]}}
    log    ${object_CK_id}
    ${objectids}    set Variable    ${object_Subid_Id},${object_FQDN_Id},${object_URL_id},${object_CK_id}
    #创建对象SC
    ${rescode_deny}    ${object_SC_id}    AddObject    {"opAction":"add","returnData":1,"objectList":{"objectType":"http_signature","isValid":1,"isInitialize":0,"isExclusion":0,"objectName":"zmm_sc","objectDesc":"","subObjectIds":[],"addItemList":[{"keywordArray":["*domain=.xiaozhu.com"],"isHexbin":0,"district":"Set-Cookie"}],"updateItemList":[],"deleteItemIds":[]}}
    log    ${object_SC_id}
    ${objectids}    set Variable    ${object_Subid_Id},${object_FQDN_Id},${object_URL_id},${object_CK_id},${object_SC_id}
    #创建策略
    ${addPolicyStr}    set variable    {"opAction":"add","returnData":1,"policyList":{"policyId":"","policyName":"SecurityPolicy-Deny-Http-00002","policyType":"tsg_security","action":"deny","userTags":"","doBlacklist":0,"doLog":1,"policyDesc":"","effectiveRange":{"tag_sets":[[]]},"userRegion":{"protocol":"HTTP","method":"rst","keyring":1},"referenceObject":[{"objectId":${object_Subid_Id},"protocolFields":[]},{"objectId":${object_FQDN_Id},"protocolFields":["TSG_FIELD_HTTP_HOST"]},{"objectId":${object_URL_id},"protocolFields":["TSG_FIELD_HTTP_URL"]},{"objectId":${object_CK_id},"protocolFields":["TSG_FIELD_HTTP_REQ_HDR"]},{"objectId":${object_SC_id},"protocolFields":["TSG_FIELD_HTTP_RES_HDR"]}],"isValid":1,"scheduleId":[],"appObjectIdArray":[]}}
    ${addPolicyStr}    run keyword if    '${addTestClentIPFlag}'=='1'    set variable    {"opAction":"add","returnData":1,"policyList":{"policyId":"","policyName":"SecurityPolicy-Deny-Http-00002","policyType":"tsg_security","action":"deny","userTags":"","doBlacklist":0,"doLog":1,"policyDesc":"","effectiveRange":{"tag_sets":[[]]},"userRegion":{"protocol":"HTTP","method":"rst","keyring":1},"referenceObject":[{"objectId":${object_Subid_Id},"protocolFields":[]},{"objectId":${object_FQDN_Id},"protocolFields":["TSG_FIELD_HTTP_HOST"]},{"objectId":${object_URL_id},"protocolFields":["TSG_FIELD_HTTP_URL"]},{"objectId":${object_CK_id},"protocolFields":["TSG_FIELD_HTTP_REQ_HDR"]},{"objectId":${object_SC_id},"protocolFields":["TSG_FIELD_HTTP_RES_HDR"]}],"isValid":1,"scheduleId":[],"appObjectIdArray":[]}}
    ${rescode}    ${policyId2}    AddPolicy    ${addPolicyStr}
    ${policyId1}    set Variable    {"policyType":"tsg_security","policyIds":[${policyId2}]}
    ${policyIds}    Create List    ${policyId1}
    #${rescode}    ${policyId}    AddPolicy    {"opAction":"add","returnData":1,"policyList":{"policyId":"","policyName":"SecurityPolicy-Deny-Http-00002","policyType":"tsg_security","action":"deny","userTags":"","doBlacklist":0,"doLog":1,"policyDesc":"","effectiveRange":{"tag_sets":[[]]},"userRegion":{"protocol":"HTTP","method":"rst","keyring":1},"referenceObject":[{"objectId":${object_Subid_Id},"protocolFields":[]},{"objectId":${object_FQDN_Id},"protocolFields":["TSG_FIELD_HTTP_HOST"]},{"objectId":${object_URL_id},"protocolFields":["TSG_FIELD_HTTP_URL"]},{"objectId":${object_CK_id},"protocolFields":["TSG_FIELD_HTTP_REQ_HDR"]},{"objectId":${object_SC_id},"protocolFields":["TSG_FIELD_HTTP_RES_HDR"]}],"isValid":1,"scheduleId":[],"appObjectIdArray":[]}}
    #log    ${rescode}
    #log    ${policyId}
    #功能端验证
    Sleep    ${policyVerificationSleepSeconds}s
    ${starttime}    Get Time
    ${commandreturn}    OperatingSystem.Run    curl --cookie "*_math=czsuv8n9d4p; Hm_lvt_92e8bc890f374994dd570aa15afc99e1=1575187416; Hm_lpvt_92e8bc890f374994dd570aa15afc99e1=1575187416; _uab_collina=157518741578524001717192" --referer 'http://www.baidu.com/' \ http://www.xiaozhu.com \ \ | iconv -f utf-8 -t gbk
    should contain    ${commandreturn}    403
    Sleep    ${policyLogVerificationSleepSeconds}s
    ${endtime}    Get Time
    #日志验证
    ${s}    Convert to String    ${policyId2}
    GetLogList    security_event_log    ${starttime}    ${endtime}    ${testClentIP}    ${s}    http_host    xiaozhu

