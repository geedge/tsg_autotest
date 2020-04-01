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
SecurityPolicy-Deny-Mail-00001
    [Tags]    Deny    URI_Content
    #创建对象 Sub
    #${rescode}    ${object_Sub_Id}    AddObject    {"opAction":"add","returnData":1,"objectList":{"objectType":"subscriberid","isValid":1,"isInitialize":0,"isExclusion":0,"objectName":"zmmtest_subid","objectDesc":"","subObjectIds":[],"addItemList":[{"keywordArray":["$zmmtest"],"itemId":"","isHexbin":0}],"updateItemList":[],"deleteItemIds":[]}}
    #log    ${object_Sub_Id}
    #${objectids}    set Variable    ${object_Sub_Id}
    #创建对象 Account
    ${rescodeip}    ${object_Account_Id}    AddObject    {"opAction":"add","returnData":1,"objectList":{"objectType":"account","isValid":1,"isInitialize":0,"isExclusion":0,"objectName":"zmm_account","objectDesc":"","subObjectIds":[],"addItemList":[{"keywordArray":["z1343921421z@163.com"],"itemId":"","isValid":"","isHexbin":0}],"updateItemList":[],"deleteItemIds":[],"objectId":""}}
    log    ${object_Account_Id}
    ${objectids}    set Variable    ${object_Account_Id}
    #创建策略
    ${addPolicyStr}    set variable    {"opAction":"add","returnData":1,"policyList":{"policyId":"","policyName":"SecurityPolicy-Deny-Mail-00001","policyType":"tsg_security","action":"deny","userTags":"","doBlacklist":0,"doLog":1,"policyDesc":"","effectiveRange":{"tag_sets":[[]]},"userRegion":{"protocol":"MAIL","method":"rst","code":""},"referenceObject":[{"objectId":${object_Account_Id},"protocolFields":["TSG_FIELD_MAIL_ACCOUNT"]}],"isValid":1,"scheduleId":[],"appObjectIdArray":[]}}
    ${addPolicyStr}    run keyword if    '${addTestClentIPFlag}'=='1'    set variable    {"opAction":"add","returnData":1,"policyList":{"policyId":"","policyName":"SecurityPolicy-Deny-Mail-00001","policyType":"tsg_security","action":"deny","userTags":"","doBlacklist":0,"doLog":1,"policyDesc":"","effectiveRange":{"tag_sets":[[]]},"userRegion":{"protocol":"MAIL","method":"rst","code":""},"referenceObject":[{"objectId":${testClentID},"protocolFields":[]},{"objectId":${object_Account_Id},"protocolFields":["TSG_FIELD_MAIL_ACCOUNT"]}],"isValid":1,"scheduleId":[],"appObjectIdArray":[]}}
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
    ${mail}    EmailLogin    smtp.163.com    25    z1343921421z@163.com    QKCEUFAJJRZLJKQE
    should contain    ${mail}    fail
    Sleep    ${policyLogVerificationSleepSeconds}s
    ${endtime}    Get Time
    #日志验证
    ${s}    Convert to String    ${policyId2}
    GetLogList    security_event_log    ${starttime}    ${endtime}    ${testClentIP}    ${s}    mail_account    z1343921421z@163.com

SecurityPolicy-Deny-Mail-00002
    [Tags]    Deny    URI_Content
    #创建对象IP
    #${rescode}    ${object_IP_Id}    AddObject    {"opAction":"add","returnData":1,"objectList":{"objectType":"ip","isValid":1,"isInitialize":0,"isExclusion":0,"objectName":"zmmtest_IP","objectDesc":"","subObjectIds":[],"addItemList":[{"addrType":4,"protocol":0,"direction":0,"clientIp1":"192.168.50.31","clientIp2":"192.168.50.31","clientIpFormat":"range","clientPortFormat":"","clientPort1":"","clientPort2":"","serverIpFormat":"","serverIp1":"","serverIp2":"","serverPortFormat":"","serverPort1":"","serverPort2":""}],"updateItemList":[],"deleteItemIds":[]}}
    #log    ${object_IP_Id}
    #创建对象 Subject
    ${rescodeip}    ${object_Subject_Id}    AddObject    {"opAction":"add","returnData":1,"objectList":{"objectType":"keywords","isValid":1,"isInitialize":0,"isExclusion":0,"objectName":"zmm_subject","objectDesc":"","subObjectIds":[],"addItemList":[{"keywordArray":["朱明明subject"],"isHexbin":0,"itemId":"","isValid":""}],"updateItemList":[],"deleteItemIds":[],"objectId":""}}
    log    ${object_Subject_Id}
    ${objectids}    set Variable    ${object_Subject_Id}
    #创建对象 Content
    ${rescode_deny}    ${object_Content_id}    AddObject    {"opAction":"add","returnData":1,"objectList":{"objectType":"keywords","isValid":1,"isInitialize":0,"isExclusion":0,"objectName":"zmm_content","objectDesc":"","subObjectIds":[],"addItemList":[{"keywordArray":["朱明明content"],"isHexbin":0,"itemId":"","isValid":""}],"updateItemList":[],"deleteItemIds":[],"objectId":""}}
    log    ${object_Content_id}
    ${objectids}    set Variable    ${object_Subject_Id},${object_Content_id}
    #创建对象 Att_name
    ${rescode_deny}    ${object_Att_name_id}    AddObject    {"opAction":"add","returnData":1,"objectList":{"objectType":"keywords","isValid":1,"isInitialize":0,"isExclusion":0,"objectName":"zmm_ATT_Name","objectDesc":"","subObjectIds":[],"addItemList":[{"keywordArray":["朱明明测试文件"],"isHexbin":0,"itemId":"","isValid":""}],"updateItemList":[],"deleteItemIds":[],"objectId":""}}
    log    ${object_Att_name_id}
    ${objectids}    set Variable    ${object_Subject_Id},${object_Content_id},${object_Att_name_id}
    #创建对象 att_content
    ${rescode_deny}    ${object_att_content_id}    AddObject    {"opAction":"add","returnData":1,"objectList":{"objectType":"keywords","isValid":1,"isInitialize":0,"isExclusion":0,"objectName":"zmm_content","objectDesc":"","subObjectIds":[],"addItemList":[{"keywordArray":["朱明明测试文件内容"],"isHexbin":0,"itemId":"","isValid":""}],"updateItemList":[],"deleteItemIds":[],"objectId":""}}
    log    ${object_att_content_id}
    ${objectids}    set Variable    ${object_Subject_Id},${object_Content_id},${object_Att_name_id},${object_att_content_id}
    #创建对象 From
    ${rescode_deny}    ${object_From_id}    AddObject    {"opAction":"add","returnData":1,"objectList":{"objectType":"account","isValid":1,"isInitialize":0,"isExclusion":0,"objectName":"zmm_from","objectDesc":"","subObjectIds":[],"addItemList":[{"keywordArray":["z1343921421z@163.com"],"itemId":"","isHexbin":0}],"updateItemList":[],"deleteItemIds":[],"objectId":""}}
    log    ${object_From_id}
    ${objectids}    set Variable    ${object_Subject_Id},${object_Content_id},${object_Att_name_id},${object_att_content_id},${object_From_id}
    #创建对象 to
    ${rescode_deny}    ${object_to_id}    AddObject    {"opAction":"add","returnData":1,"objectList":{"objectType":"account","isValid":1,"isInitialize":0,"isExclusion":0,"objectName":"zmm_to","objectDesc":"","subObjectIds":[],"addItemList":[{"keywordArray":["z1789327568z@163.com"],"itemId":"","isValid":"","isHexbin":0}],"updateItemList":[],"deleteItemIds":[],"objectId":""}}
    log    ${object_to_id}
    ${objectids}    set Variable    ${object_Subject_Id},${object_Content_id},${object_Att_name_id},${object_att_content_id},${object_From_id},${object_to_id}
    #创建策略
    ${addPolicyStr}    set variable    {"opAction":"add","returnData":1,"policyList":{"policyId":"","policyName":"SecurityPolicy-Deny-Mail-00002","policyType":"tsg_security","action":"deny","userTags":"","doBlacklist":0,"doLog":1,"policyDesc":"","effectiveRange":{"tag_sets":[[]]},"userRegion":{"protocol":"MAIL","method":"drop","code":550},"referenceObject":[{"objectId":${object_Att_name_id},"protocolFields":["TSG_FIELD_MAIL_ATT_NAME"]},{"objectId":${object_att_content_id},"protocolFields":["TSG_FIELD_MAIL_ATT_CONTENT"]},{"objectId":${object_From_id},"protocolFields":["TSG_FIELD_MAIL_FROM"]},{"objectId":${object_to_id},"protocolFields":["TSG_FIELD_MAIL_TO"]},{"objectId":${object_Content_id},"protocolFields":["TSG_FIELD_MAIL_CONTENT"]},{"objectId":${object_Subject_Id},"protocolFields":["TSG_FIELD_MAIL_SUBJECT"]},{"objectId":4059,"protocolFields":[]}],"isValid":1,"scheduleId":[],"appObjectIdArray":[]}}
    ${addPolicyStr}    run keyword if    '${addTestClentIPFlag}'=='1'    set variable    {"opAction":"add","returnData":1,"policyList":{"policyId":"","policyName":"SecurityPolicy-Deny-Mail-00002","policyType":"tsg_security","action":"deny","userTags":"","doBlacklist":0,"doLog":1,"policyDesc":"","effectiveRange":{"tag_sets":[[]]},"userRegion":{"protocol":"MAIL","method":"drop","code":550},"referenceObject":[{"objectId":${testClentID},"protocolFields":[]},{"objectId":${object_Att_name_id},"protocolFields":["TSG_FIELD_MAIL_ATT_NAME"]},{"objectId":${object_att_content_id},"protocolFields":["TSG_FIELD_MAIL_ATT_CONTENT"]},{"objectId":${object_From_id},"protocolFields":["TSG_FIELD_MAIL_FROM"]},{"objectId":${object_to_id},"protocolFields":["TSG_FIELD_MAIL_TO"]},{"objectId":${object_Content_id},"protocolFields":["TSG_FIELD_MAIL_CONTENT"]},{"objectId":${object_Subject_Id},"protocolFields":["TSG_FIELD_MAIL_SUBJECT"]}],"isValid":1,"scheduleId":[],"appObjectIdArray":[]}}
    ${rescode}    ${policyId2}    AddPolicy    ${addPolicyStr}
    ${policyId1}    set Variable    {"policyType":"tsg_security","policyIds":[${policyId2}]}
    ${policyIds}    Create List    ${policyId1}
    #功能端验证
    Sleep    ${policyVerificationSleepSeconds}s
    ${starttime}    Get Time
    ${Smtp服务器}    Set Variable    smtp.163.com
    ${Smtp服务器端口}    Set Variable    25
    ${邮箱账号}    Set Variable    z1343921421z@163.com
    ${邮箱密码}    Set Variable    VIAVUYPIEJRDQDBN
    ${邮件主题}    Set Variable    朱明明subject
    ${发送者}    Set Variable    z1343921421z@163.com
    ${附件}    Set Variable    ["${mailpath}/朱明明测试文件.txt"]
    ${接收者}    Set Variable    ["z1789327568z@163.com"]
    ${抄送者}    Set Variable    ["z1789327568z@163.com"]
    ${密送者}    Set Variable    ["z1789327568z@163.com"]
    ${邮件正文}    Set Variable    朱明明content
    ${发送邮件返回结果}    EmailSendFull    ${Smtp服务器}    ${Smtp服务器端口}    ${邮箱账号}    ${邮箱密码}    ${邮件主题}    ${发送者}    ${接收者}    ${抄送者}    ${密送者}    ${邮件正文}    ${附件}
    Log    ${发送邮件返回结果}
    should contain    ${发送邮件返回结果}    fail
    Sleep    ${policyLogVerificationSleepSeconds}s
    ${endtime}    Get Time
    #日志验证
    ${s}    Convert to String    ${policyId2}
    GetLogList    security_event_log    ${starttime}    ${endtime}    ${testClentIP}    ${s}    mail_account    z1343921421z@163.com

SecurityPolicy-Deny-Mail-00003
    [Tags]    Deny    Subject
    #创建对象IP
    #${rescode}    ${object_IP_Id}    AddObject    {"opAction":"add","returnData":1,"objectList":{"objectType":"ip","isValid":1,"isInitialize":0,"isExclusion":0,"objectName":"zmmtest_IP","objectDesc":"","subObjectIds":[],"addItemList":[{"addrType":4,"protocol":0,"direction":0,"clientIp1":"192.168.50.31","clientIp2":"192.168.50.31","clientIpFormat":"range","clientPortFormat":"","clientPort1":"","clientPort2":"","serverIpFormat":"","serverIp1":"","serverIp2":"","serverPortFormat":"","serverPort1":"","serverPort2":""}],"updateItemList":[],"deleteItemIds":[]}}
    #log    ${object_IP_Id}
    #创建对象 Subject
    ${rescodeip}    ${object_Subject_Id}    AddObject    {"opAction":"add","returnData":1,"objectList":{"objectType":"keywords","isValid":1,"isInitialize":0,"isExclusion":0,"objectName":"zmm_subject","objectDesc":"","subObjectIds":[],"addItemList":[{"keywordArray":["朱明明subject"],"isHexbin":0,"itemId":"","isValid":""}],"updateItemList":[],"deleteItemIds":[],"objectId":""}}
    log    ${object_Subject_Id}
    ${objectids}    set Variable    ${object_Subject_Id}
    #创建策略
    #${addPolicyStr}    set variable    {"opAction":"add","returnData":1,"policyList":{"policyId":"","policyName":"SecurityPolicy-Deny-Mail-00001","policyType":"tsg_security","action":"deny","userTags":"","doBlacklist":0,"doLog":1,"policyDesc":"","effectiveRange":{"tag_sets":[[]]},"userRegion":{"protocol":"MAIL","method":"drop","code":550},"referenceObject":[{"objectId":${object_Att_name_id},"protocolFields":["TSG_FIELD_MAIL_ATT_NAME"]},{"objectId":${object_att_content_id},"protocolFields":["TSG_FIELD_MAIL_ATT_CONTENT"]},{"objectId":${object_From_id},"protocolFields":["TSG_FIELD_MAIL_FROM"]},{"objectId":${object_to_id},"protocolFields":["TSG_FIELD_MAIL_TO"]},{"objectId":${object_Content_id},"protocolFields":["TSG_FIELD_MAIL_CONTENT"]},{"objectId":${object_Subject_Id},"protocolFields":["TSG_FIELD_MAIL_SUBJECT"]},{"objectId":4059,"protocolFields":[]}],"isValid":1,"scheduleId":[],"appObjectIdArray":[]}}
    ${addPolicyStr}    run keyword if    '${addTestClentIPFlag}'=='1'    set variable    {"opAction":"add","returnData":1,"policyList":{"policyId":"","policyName":"SecurityPolicy-Deny-Mail-00003","policyType":"tsg_security","action":"deny","userTags":"","doBlacklist":0,"doLog":1,"policyDesc":"","effectiveRange":{"tag_sets":[[]]},"userRegion":{"protocol":"MAIL","method":"drop","code":550},"referenceObject":[{"objectId":${testClentID},"protocolFields":[]},{"objectId":${object_Subject_Id},"protocolFields":["TSG_FIELD_MAIL_SUBJECT"]}],"isValid":1,"scheduleId":[],"appObjectIdArray":[]}}
    ${rescode}    ${policyId2}    AddPolicy    ${addPolicyStr}
    ${policyId1}    set Variable    {"policyType":"tsg_security","policyIds":[${policyId2}]}
    ${policyIds}    Create List    ${policyId1}
    #功能端验证
    Sleep    ${policyVerificationSleepSeconds}s
    ${starttime}    Get Time
    ${Smtp服务器}    Set Variable    smtp.163.com
    ${Smtp服务器端口}    Set Variable    25
    ${邮箱账号}    Set Variable    z1343921421z@163.com
    ${邮箱密码}    Set Variable    VIAVUYPIEJRDQDBN
    ${邮件主题}    Set Variable    朱明明subject
    ${发送者}    Set Variable    z1343921421z@163.com
    ${附件}    Set Variable    ["${mailpath}/朱明明测试文件.txt"]
    ${接收者}    Set Variable    ["z1789327568z@163.com"]
    ${抄送者}    Set Variable    ["z1789327568z@163.com"]
    ${密送者}    Set Variable    ["z1789327568z@163.com"]
    ${邮件正文}    Set Variable    朱明明content
    ${发送邮件返回结果}    EmailSendFull    ${Smtp服务器}    ${Smtp服务器端口}    ${邮箱账号}    ${邮箱密码}    ${邮件主题}    ${发送者}    ${接收者}    ${抄送者}    ${密送者}    ${邮件正文}    ${附件}
    Log    ${发送邮件返回结果}
    should contain    ${发送邮件返回结果}    fail
    Sleep    ${policyLogVerificationSleepSeconds}s
    ${endtime}    Get Time
    #日志验证
    ${s}    Convert to String    ${policyId2}
    GetLogList    security_event_log    ${starttime}    ${endtime}    ${testClentIP}    ${s}    mail_account    z1343921421z@163.com

SecurityPolicy-Deny-Mail-00004
    [Tags]    Deny    Content
    #创建对象IP
    #${rescode}    ${object_IP_Id}    AddObject    {"opAction":"add","returnData":1,"objectList":{"objectType":"ip","isValid":1,"isInitialize":0,"isExclusion":0,"objectName":"zmmtest_IP","objectDesc":"","subObjectIds":[],"addItemList":[{"addrType":4,"protocol":0,"direction":0,"clientIp1":"192.168.50.31","clientIp2":"192.168.50.31","clientIpFormat":"range","clientPortFormat":"","clientPort1":"","clientPort2":"","serverIpFormat":"","serverIp1":"","serverIp2":"","serverPortFormat":"","serverPort1":"","serverPort2":""}],"updateItemList":[],"deleteItemIds":[]}}
    #log    ${object_IP_Id}
    #创建对象 Content
    ${rescode_deny}    ${object_Content_id}    AddObject    {"opAction":"add","returnData":1,"objectList":{"objectType":"keywords","isValid":1,"isInitialize":0,"isExclusion":0,"objectName":"zmm_content","objectDesc":"","subObjectIds":[],"addItemList":[{"keywordArray":["朱明明content"],"isHexbin":0,"itemId":"","isValid":""}],"updateItemList":[],"deleteItemIds":[],"objectId":""}}
    log    ${object_Content_id}
    ${objectids}    set Variable    ${object_Content_id}
    #创建策略
    #${addPolicyStr}    set variable    {"opAction":"add","returnData":1,"policyList":{"policyId":"","policyName":"SecurityPolicy-Deny-Mail-00001","policyType":"tsg_security","action":"deny","userTags":"","doBlacklist":0,"doLog":1,"policyDesc":"","effectiveRange":{"tag_sets":[[]]},"userRegion":{"protocol":"MAIL","method":"drop","code":550},"referenceObject":[{"objectId":${object_Att_name_id},"protocolFields":["TSG_FIELD_MAIL_ATT_NAME"]},{"objectId":${object_att_content_id},"protocolFields":["TSG_FIELD_MAIL_ATT_CONTENT"]},{"objectId":${object_From_id},"protocolFields":["TSG_FIELD_MAIL_FROM"]},{"objectId":${object_to_id},"protocolFields":["TSG_FIELD_MAIL_TO"]},{"objectId":${object_Content_id},"protocolFields":["TSG_FIELD_MAIL_CONTENT"]},{"objectId":${object_Subject_Id},"protocolFields":["TSG_FIELD_MAIL_SUBJECT"]},{"objectId":4059,"protocolFields":[]}],"isValid":1,"scheduleId":[],"appObjectIdArray":[]}}
    ${addPolicyStr}    run keyword if    '${addTestClentIPFlag}'=='1'    set variable    {"opAction":"add","returnData":1,"policyList":{"policyId":"","policyName":"SecurityPolicy-Deny-Mail-00004","policyType":"tsg_security","action":"deny","userTags":"","doBlacklist":0,"doLog":1,"policyDesc":"","effectiveRange":{"tag_sets":[[]]},"userRegion":{"protocol":"MAIL","method":"drop","code":550},"referenceObject":[{"objectId":${testClentID},"protocolFields":[]},{"objectId":${object_Content_id},"protocolFields":["TSG_FIELD_MAIL_CONTENT"]}],"isValid":1,"scheduleId":[],"appObjectIdArray":[]}}
    ${rescode}    ${policyId2}    AddPolicy    ${addPolicyStr}
    ${policyId1}    set Variable    {"policyType":"tsg_security","policyIds":[${policyId2}]}
    ${policyIds}    Create List    ${policyId1}
    #功能端验证
    Sleep    ${policyVerificationSleepSeconds}s
    ${starttime}    Get Time
    ${Smtp服务器}    Set Variable    smtp.163.com
    ${Smtp服务器端口}    Set Variable    25
    ${邮箱账号}    Set Variable    z1343921421z@163.com
    ${邮箱密码}    Set Variable    VIAVUYPIEJRDQDBN
    ${邮件主题}    Set Variable    朱明明subject
    ${发送者}    Set Variable    z1343921421z@163.com
    ${附件}    Set Variable    ["${mailpath}/朱明明测试文件.txt"]
    ${接收者}    Set Variable    ["z1789327568z@163.com"]
    ${抄送者}    Set Variable    ["z1789327568z@163.com"]
    ${密送者}    Set Variable    ["z1789327568z@163.com"]
    ${邮件正文}    Set Variable    朱明明content
    ${发送邮件返回结果}    EmailSendFull    ${Smtp服务器}    ${Smtp服务器端口}    ${邮箱账号}    ${邮箱密码}    ${邮件主题}    ${发送者}    ${接收者}    ${抄送者}    ${密送者}    ${邮件正文}    ${附件}
    Log    ${发送邮件返回结果}
    should contain    ${发送邮件返回结果}    fail
    Sleep    ${policyLogVerificationSleepSeconds}s
    ${endtime}    Get Time
    #日志验证
    ${s}    Convert to String    ${policyId2}
    GetLogList    security_event_log    ${starttime}    ${endtime}    ${testClentIP}    ${s}    mail_account    z1343921421z@163.com

SecurityPolicy-Deny-Mail-00005
    [Tags]    Deny    tt_name
    #创建对象IP
    #${rescode}    ${object_IP_Id}    AddObject    {"opAction":"add","returnData":1,"objectList":{"objectType":"ip","isValid":1,"isInitialize":0,"isExclusion":0,"objectName":"zmmtest_IP","objectDesc":"","subObjectIds":[],"addItemList":[{"addrType":4,"protocol":0,"direction":0,"clientIp1":"192.168.50.31","clientIp2":"192.168.50.31","clientIpFormat":"range","clientPortFormat":"","clientPort1":"","clientPort2":"","serverIpFormat":"","serverIp1":"","serverIp2":"","serverPortFormat":"","serverPort1":"","serverPort2":""}],"updateItemList":[],"deleteItemIds":[]}}
    #log    ${object_IP_Id}
    #创建对象 Att_name
    ${rescode_deny}    ${object_Att_name_id}    AddObject    {"opAction":"add","returnData":1,"objectList":{"objectType":"keywords","isValid":1,"isInitialize":0,"isExclusion":0,"objectName":"zmm_ATT_Name","objectDesc":"","subObjectIds":[],"addItemList":[{"keywordArray":["朱明明测试文件"],"isHexbin":0,"itemId":"","isValid":""}],"updateItemList":[],"deleteItemIds":[],"objectId":""}}
    log    ${object_Att_name_id}
    ${objectids}    set Variable    ${object_Att_name_id}
    #创建策略
    #${addPolicyStr}    set variable    {"opAction":"add","returnData":1,"policyList":{"policyId":"","policyName":"SecurityPolicy-Deny-Mail-00001","policyType":"tsg_security","action":"deny","userTags":"","doBlacklist":0,"doLog":1,"policyDesc":"","effectiveRange":{"tag_sets":[[]]},"userRegion":{"protocol":"MAIL","method":"drop","code":550},"referenceObject":[{"objectId":${object_Att_name_id},"protocolFields":["TSG_FIELD_MAIL_ATT_NAME"]},{"objectId":${object_att_content_id},"protocolFields":["TSG_FIELD_MAIL_ATT_CONTENT"]},{"objectId":${object_From_id},"protocolFields":["TSG_FIELD_MAIL_FROM"]},{"objectId":${object_to_id},"protocolFields":["TSG_FIELD_MAIL_TO"]},{"objectId":${object_Content_id},"protocolFields":["TSG_FIELD_MAIL_CONTENT"]},{"objectId":${object_Subject_Id},"protocolFields":["TSG_FIELD_MAIL_SUBJECT"]},{"objectId":4059,"protocolFields":[]}],"isValid":1,"scheduleId":[],"appObjectIdArray":[]}}
    ${addPolicyStr}    run keyword if    '${addTestClentIPFlag}'=='1'    set variable    {"opAction":"add","returnData":1,"policyList":{"policyId":"","policyName":"SecurityPolicy-Deny-Mail-00005","policyType":"tsg_security","action":"deny","userTags":"","doBlacklist":0,"doLog":1,"policyDesc":"","effectiveRange":{"tag_sets":[[]]},"userRegion":{"protocol":"MAIL","method":"drop","code":550},"referenceObject":[{"objectId":${testClentID},"protocolFields":[]},{"objectId":${object_Att_name_id},"protocolFields":["TSG_FIELD_MAIL_ATT_NAME"]}],"isValid":1,"scheduleId":[],"appObjectIdArray":[]}}
    ${rescode}    ${policyId2}    AddPolicy    ${addPolicyStr}
    ${policyId1}    set Variable    {"policyType":"tsg_security","policyIds":[${policyId2}]}
    ${policyIds}    Create List    ${policyId1}
    #功能端验证
    Sleep    ${policyVerificationSleepSeconds}s
    ${starttime}    Get Time
    ${Smtp服务器}    Set Variable    smtp.163.com
    ${Smtp服务器端口}    Set Variable    25
    ${邮箱账号}    Set Variable    z1343921421z@163.com
    ${邮箱密码}    Set Variable    VIAVUYPIEJRDQDBN
    ${邮件主题}    Set Variable    朱明明subject
    ${发送者}    Set Variable    z1343921421z@163.com
    ${附件}    Set Variable    ["${mailpath}/朱明明测试文件.txt"]
    ${接收者}    Set Variable    ["z1789327568z@163.com"]
    ${抄送者}    Set Variable    ["z1789327568z@163.com"]
    ${密送者}    Set Variable    ["z1789327568z@163.com"]
    ${邮件正文}    Set Variable    朱明明content
    ${发送邮件返回结果}    EmailSendFull    ${Smtp服务器}    ${Smtp服务器端口}    ${邮箱账号}    ${邮箱密码}    ${邮件主题}    ${发送者}    ${接收者}    ${抄送者}    ${密送者}    ${邮件正文}    ${附件}
    Log    ${发送邮件返回结果}
    should contain    ${发送邮件返回结果}    fail
    Sleep    ${policyLogVerificationSleepSeconds}s
    ${endtime}    Get Time
    #日志验证
    ${s}    Convert to String    ${policyId2}
    GetLogList    security_event_log    ${starttime}    ${endtime}    ${testClentIP}    ${s}    mail_account    z1343921421z@163.com

SecurityPolicy-Deny-Mail-00006
    [Tags]    Deny    Att_content
    #创建对象IP
    #${rescode}    ${object_IP_Id}    AddObject    {"opAction":"add","returnData":1,"objectList":{"objectType":"ip","isValid":1,"isInitialize":0,"isExclusion":0,"objectName":"zmmtest_IP","objectDesc":"","subObjectIds":[],"addItemList":[{"addrType":4,"protocol":0,"direction":0,"clientIp1":"192.168.50.31","clientIp2":"192.168.50.31","clientIpFormat":"range","clientPortFormat":"","clientPort1":"","clientPort2":"","serverIpFormat":"","serverIp1":"","serverIp2":"","serverPortFormat":"","serverPort1":"","serverPort2":""}],"updateItemList":[],"deleteItemIds":[]}}
    #log    ${object_IP_Id}
    #创建对象 att_content
    ${rescode_deny}    ${object_att_content_id}    AddObject    {"opAction":"add","returnData":1,"objectList":{"objectType":"keywords","isValid":1,"isInitialize":0,"isExclusion":0,"objectName":"zmm_content","objectDesc":"","subObjectIds":[],"addItemList":[{"keywordArray":["朱明明测试文件内容"],"isHexbin":0,"itemId":"","isValid":""}],"updateItemList":[],"deleteItemIds":[],"objectId":""}}
    log    ${object_att_content_id}
    ${objectids}    set Variable    ${object_att_content_id}
    #创建策略
    #${addPolicyStr}    set variable    {"opAction":"add","returnData":1,"policyList":{"policyId":"","policyName":"SecurityPolicy-Deny-Mail-00001","policyType":"tsg_security","action":"deny","userTags":"","doBlacklist":0,"doLog":1,"policyDesc":"","effectiveRange":{"tag_sets":[[]]},"userRegion":{"protocol":"MAIL","method":"drop","code":550},"referenceObject":[{"objectId":${object_Att_name_id},"protocolFields":["TSG_FIELD_MAIL_ATT_NAME"]},{"objectId":${object_att_content_id},"protocolFields":["TSG_FIELD_MAIL_ATT_CONTENT"]},{"objectId":${object_From_id},"protocolFields":["TSG_FIELD_MAIL_FROM"]},{"objectId":${object_to_id},"protocolFields":["TSG_FIELD_MAIL_TO"]},{"objectId":${object_Content_id},"protocolFields":["TSG_FIELD_MAIL_CONTENT"]},{"objectId":${object_Subject_Id},"protocolFields":["TSG_FIELD_MAIL_SUBJECT"]},{"objectId":4059,"protocolFields":[]}],"isValid":1,"scheduleId":[],"appObjectIdArray":[]}}
    ${addPolicyStr}    run keyword if    '${addTestClentIPFlag}'=='1'    set variable    {"opAction":"add","returnData":1,"policyList":{"policyId":"","policyName":"SecurityPolicy-Deny-Mail-00006","policyType":"tsg_security","action":"deny","userTags":"","doBlacklist":0,"doLog":1,"policyDesc":"","effectiveRange":{"tag_sets":[[]]},"userRegion":{"protocol":"MAIL","method":"drop","code":550},"referenceObject":[{"objectId":${testClentID},"protocolFields":[]},{"objectId":${object_att_content_id},"protocolFields":["TSG_FIELD_MAIL_ATT_CONTENT"]}],"isValid":1,"scheduleId":[],"appObjectIdArray":[]}}
    ${rescode}    ${policyId2}    AddPolicy    ${addPolicyStr}
    ${policyId1}    set Variable    {"policyType":"tsg_security","policyIds":[${policyId2}]}
    ${policyIds}    Create List    ${policyId1}
    #功能端验证
    Sleep    ${policyVerificationSleepSeconds}s
    ${starttime}    Get Time
    ${Smtp服务器}    Set Variable    smtp.163.com
    ${Smtp服务器端口}    Set Variable    25
    ${邮箱账号}    Set Variable    z1343921421z@163.com
    ${邮箱密码}    Set Variable    VIAVUYPIEJRDQDBN
    ${邮件主题}    Set Variable    朱明明subject
    ${发送者}    Set Variable    z1343921421z@163.com
    ${附件}    Set Variable    ["${mailpath}/朱明明测试文件.txt"]
    ${接收者}    Set Variable    ["z1789327568z@163.com"]
    ${抄送者}    Set Variable    ["z1789327568z@163.com"]
    ${密送者}    Set Variable    ["z1789327568z@163.com"]
    ${邮件正文}    Set Variable    朱明明content
    ${发送邮件返回结果}    EmailSendFull    ${Smtp服务器}    ${Smtp服务器端口}    ${邮箱账号}    ${邮箱密码}    ${邮件主题}    ${发送者}    ${接收者}    ${抄送者}    ${密送者}    ${邮件正文}    ${附件}
    Log    ${发送邮件返回结果}
    should contain    ${发送邮件返回结果}    fail
    Sleep    ${policyLogVerificationSleepSeconds}s
    ${endtime}    Get Time
    #日志验证
    ${s}    Convert to String    ${policyId2}
    GetLogList    security_event_log    ${starttime}    ${endtime}    ${testClentIP}    ${s}    mail_account    z1343921421z@163.com

SecurityPolicy-Deny-Mail-00007
    [Tags]    Deny    From
    #创建对象IP
    #${rescode}    ${object_IP_Id}    AddObject    {"opAction":"add","returnData":1,"objectList":{"objectType":"ip","isValid":1,"isInitialize":0,"isExclusion":0,"objectName":"zmmtest_IP","objectDesc":"","subObjectIds":[],"addItemList":[{"addrType":4,"protocol":0,"direction":0,"clientIp1":"192.168.50.31","clientIp2":"192.168.50.31","clientIpFormat":"range","clientPortFormat":"","clientPort1":"","clientPort2":"","serverIpFormat":"","serverIp1":"","serverIp2":"","serverPortFormat":"","serverPort1":"","serverPort2":""}],"updateItemList":[],"deleteItemIds":[]}}
    #log    ${object_IP_Id}
    #创建对象 From
    ${rescode_deny}    ${object_From_id}    AddObject    {"opAction":"add","returnData":1,"objectList":{"objectType":"account","isValid":1,"isInitialize":0,"isExclusion":0,"objectName":"zmm_from","objectDesc":"","subObjectIds":[],"addItemList":[{"keywordArray":["z1343921421z@163.com"],"itemId":"","isHexbin":0}],"updateItemList":[],"deleteItemIds":[],"objectId":""}}
    log    ${object_From_id}
    ${objectids}    set Variable    ${object_From_id}
    #创建策略
    #${addPolicyStr}    set variable    {"opAction":"add","returnData":1,"policyList":{"policyId":"","policyName":"SecurityPolicy-Deny-Mail-00001","policyType":"tsg_security","action":"deny","userTags":"","doBlacklist":0,"doLog":1,"policyDesc":"","effectiveRange":{"tag_sets":[[]]},"userRegion":{"protocol":"MAIL","method":"drop","code":550},"referenceObject":[{"objectId":${object_Att_name_id},"protocolFields":["TSG_FIELD_MAIL_ATT_NAME"]},{"objectId":${object_att_content_id},"protocolFields":["TSG_FIELD_MAIL_ATT_CONTENT"]},{"objectId":${object_From_id},"protocolFields":["TSG_FIELD_MAIL_FROM"]},{"objectId":${object_to_id},"protocolFields":["TSG_FIELD_MAIL_TO"]},{"objectId":${object_Content_id},"protocolFields":["TSG_FIELD_MAIL_CONTENT"]},{"objectId":${object_Subject_Id},"protocolFields":["TSG_FIELD_MAIL_SUBJECT"]},{"objectId":4059,"protocolFields":[]}],"isValid":1,"scheduleId":[],"appObjectIdArray":[]}}
    ${addPolicyStr}    run keyword if    '${addTestClentIPFlag}'=='1'    set variable    {"opAction":"add","returnData":1,"policyList":{"policyId":"","policyName":"SecurityPolicy-Deny-Mail-00007","policyType":"tsg_security","action":"deny","userTags":"","doBlacklist":0,"doLog":1,"policyDesc":"","effectiveRange":{"tag_sets":[[]]},"userRegion":{"protocol":"MAIL","method":"drop","code":550},"referenceObject":[{"objectId":${testClentID},"protocolFields":[]},{"objectId":${object_From_id},"protocolFields":["TSG_FIELD_MAIL_FROM"]}],"isValid":1,"scheduleId":[],"appObjectIdArray":[]}}
    ${rescode}    ${policyId2}    AddPolicy    ${addPolicyStr}
    ${policyId1}    set Variable    {"policyType":"tsg_security","policyIds":[${policyId2}]}
    ${policyIds}    Create List    ${policyId1}
    #功能端验证
    Sleep    ${policyVerificationSleepSeconds}s
    ${starttime}    Get Time
    ${Smtp服务器}    Set Variable    smtp.163.com
    ${Smtp服务器端口}    Set Variable    25
    ${邮箱账号}    Set Variable    z1343921421z@163.com
    ${邮箱密码}    Set Variable    VIAVUYPIEJRDQDBN
    ${邮件主题}    Set Variable    朱明明subject
    ${发送者}    Set Variable    z1343921421z@163.com
    ${附件}    Set Variable    ["${mailpath}/朱明明测试文件.txt"]
    ${接收者}    Set Variable    ["z1789327568z@163.com"]
    ${抄送者}    Set Variable    ["z1789327568z@163.com"]
    ${密送者}    Set Variable    ["z1789327568z@163.com"]
    ${邮件正文}    Set Variable    朱明明content
    ${发送邮件返回结果}    EmailSendFull    ${Smtp服务器}    ${Smtp服务器端口}    ${邮箱账号}    ${邮箱密码}    ${邮件主题}    ${发送者}    ${接收者}    ${抄送者}    ${密送者}    ${邮件正文}    ${附件}
    Log    ${发送邮件返回结果}
    should contain    ${发送邮件返回结果}    fail
    Sleep    ${policyLogVerificationSleepSeconds}s
    ${endtime}    Get Time
    #日志验证
    ${s}    Convert to String    ${policyId2}
    GetLogList    security_event_log    ${starttime}    ${endtime}    ${testClentIP}    ${s}    mail_account    z1343921421z@163.com

SecurityPolicy-Deny-Mail-00008
    [Tags]    Deny    to
    #创建对象IP
    #${rescode}    ${object_IP_Id}    AddObject    {"opAction":"add","returnData":1,"objectList":{"objectType":"ip","isValid":1,"isInitialize":0,"isExclusion":0,"objectName":"zmmtest_IP","objectDesc":"","subObjectIds":[],"addItemList":[{"addrType":4,"protocol":0,"direction":0,"clientIp1":"192.168.50.31","clientIp2":"192.168.50.31","clientIpFormat":"range","clientPortFormat":"","clientPort1":"","clientPort2":"","serverIpFormat":"","serverIp1":"","serverIp2":"","serverPortFormat":"","serverPort1":"","serverPort2":""}],"updateItemList":[],"deleteItemIds":[]}}
    #log    ${object_IP_Id}
    #创建对象 to
    ${rescode_deny}    ${object_to_id}    AddObject    {"opAction":"add","returnData":1,"objectList":{"objectType":"account","isValid":1,"isInitialize":0,"isExclusion":0,"objectName":"zmm_to","objectDesc":"","subObjectIds":[],"addItemList":[{"keywordArray":["z1789327568z@163.com"],"itemId":"","isValid":"","isHexbin":0}],"updateItemList":[],"deleteItemIds":[],"objectId":""}}
    log    ${object_to_id}
    ${objectids}    set Variable    ${object_to_id}
    #创建策略
    #${addPolicyStr}    set variable    {"opAction":"add","returnData":1,"policyList":{"policyId":"","policyName":"SecurityPolicy-Deny-Mail-00001","policyType":"tsg_security","action":"deny","userTags":"","doBlacklist":0,"doLog":1,"policyDesc":"","effectiveRange":{"tag_sets":[[]]},"userRegion":{"protocol":"MAIL","method":"drop","code":550},"referenceObject":[{"objectId":${object_Att_name_id},"protocolFields":["TSG_FIELD_MAIL_ATT_NAME"]},{"objectId":${object_att_content_id},"protocolFields":["TSG_FIELD_MAIL_ATT_CONTENT"]},{"objectId":${object_From_id},"protocolFields":["TSG_FIELD_MAIL_FROM"]},{"objectId":${object_to_id},"protocolFields":["TSG_FIELD_MAIL_TO"]},{"objectId":${object_Content_id},"protocolFields":["TSG_FIELD_MAIL_CONTENT"]},{"objectId":${object_Subject_Id},"protocolFields":["TSG_FIELD_MAIL_SUBJECT"]},{"objectId":4059,"protocolFields":[]}],"isValid":1,"scheduleId":[],"appObjectIdArray":[]}}
    ${addPolicyStr}    run keyword if    '${addTestClentIPFlag}'=='1'    set variable    {"opAction":"add","returnData":1,"policyList":{"policyId":"","policyName":"SecurityPolicy-Deny-Mail-00008","policyType":"tsg_security","action":"deny","userTags":"","doBlacklist":0,"doLog":1,"policyDesc":"","effectiveRange":{"tag_sets":[[]]},"userRegion":{"protocol":"MAIL","method":"drop","code":550},"referenceObject":[{"objectId":${testClentID},"protocolFields":[]},{"objectId":${object_to_id},"protocolFields":["TSG_FIELD_MAIL_TO"]}],"isValid":1,"scheduleId":[],"appObjectIdArray":[]}}
    ${rescode}    ${policyId2}    AddPolicy    ${addPolicyStr}
    ${policyId1}    set Variable    {"policyType":"tsg_security","policyIds":[${policyId2}]}
    ${policyIds}    Create List    ${policyId1}
    #功能端验证
    Sleep    ${policyVerificationSleepSeconds}s
    ${starttime}    Get Time
    ${Smtp服务器}    Set Variable    smtp.163.com
    ${Smtp服务器端口}    Set Variable    25
    ${邮箱账号}    Set Variable    z1343921421z@163.com
    ${邮箱密码}    Set Variable    VIAVUYPIEJRDQDBN
    ${邮件主题}    Set Variable    朱明明subject
    ${发送者}    Set Variable    z1343921421z@163.com
    ${附件}    Set Variable    ["${mailpath}/朱明明测试文件.txt"]
    ${接收者}    Set Variable    ["z1789327568z@163.com"]
    ${抄送者}    Set Variable    ["z1789327568z@163.com"]
    ${密送者}    Set Variable    ["z1789327568z@163.com"]
    ${邮件正文}    Set Variable    朱明明content
    ${发送邮件返回结果}    EmailSendFull    ${Smtp服务器}    ${Smtp服务器端口}    ${邮箱账号}    ${邮箱密码}    ${邮件主题}    ${发送者}    ${接收者}    ${抄送者}    ${密送者}    ${邮件正文}    ${附件}
    Log    ${发送邮件返回结果}
    should contain    ${发送邮件返回结果}    fail
    Sleep    ${policyLogVerificationSleepSeconds}s
    ${endtime}    Get Time
    #日志验证
    ${s}    Convert to String    ${policyId2}
    GetLogList    security_event_log    ${starttime}    ${endtime}    ${testClentIP}    ${s}    mail_account    z1343921421z@163.com
