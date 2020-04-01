*** Settings ***
Library           Selenium2Library

*** Keywords ***
Keyring-create
    [Arguments]    ${keyring-name}    ${file}    ${file1}    ${1or2}    ${type}    ${type1}
    [Documentation]    引用次关键字，填入必填参数
    ...    必填参数：
    ...    ${keyring-name}:新建页面name输入框里的内容
    ...    ${file}：上传文件所在本地的路径
    ...    ${file1}:上传文件所在本地的路径
    ...    ${1or2}:填入1 或者其他数值
    ...    ${type}:上传证书类型的元素
    ...    ${type1}:上传证书加密解密算法的元素
    click element    id=interceptionadd_eventkeying    #点击下拉框
    sleep    1
    click element    id=interceptionadd_keyadd    #点击+号添加证书
    sleep    2
    input text    id=keyringsadd_name    ${keyring-name}    #输入证书name
    sleep    1
    Choose File    xpath=//*[@id="proxy"]/div[10]/div/div/div[2]/form/div[2]/div/div/div/input    ${file}    #上传证书文件
    sleep    2
    Choose File    xpath=//*[@id="proxy"]/div[10]/div/div/div[2]/form/div[4]/div/div/div/input    ${file1}    #上传证书文件
    ${select}    Set Variable    ${1or2}
    Run Keyword If    '${select}'=='1'    click    id=keyringsadd_customized
    Run Keyword If    '${select}'=='1'    input    id=reissueExpiryDate    10
    click element    id=certificateType_input    #点击下拉框
    sleep    1
    click element    ${type}    #选择证书类型
    sleep    1
    click element    id=keyringsadd_publicKeyAlgo    #点击下拉框
    sleep    1
    click element    ${type1}    #选择加密解密类型
    sleep    1
    click element    id=parentobj_submit    #点击ok

Keyring-search
    [Arguments]    ${name}
    [Documentation]    条用此关键字前需要给必填参数：${name}
    ...    ${name}:创建的keyring的name
    click element    id=tab-0    #点击Keyring
    sleep    1
    click element    id=interceptionadd_eventkeying    #点击下拉框
    sleep    1
    input text    id=card_keyringName    ${name}    #搜索框输入
    Sleep    1
    Press key    id=card_keyringName    \\13    #回车键
    sleep    1
    click element    id=card_keylist0    #点击列表

Certificate Checks
    [Arguments]    ${Type}
    [Documentation]    在调用此关键字前，需要添加必填参数${Type}
    ...    ${Type}为Fail-close或者是Pass-through \ \ \ 代表Certificate Checks 里的两个按钮
    click element    id=tab-1    #点击Certificate Checks
    sleep    1
    run keyword if    "${Type}"=="Fail-close"    click element    id=card_fileoption0
    ...    ELSE IF    "${Type}"=="Pass-through"    click element    id=card_fileoption1    #选择Fail-close或者pass-through

Dynamic Bypass
    [Arguments]    ${Type}
    [Documentation]    调用此关键字前 需要给一个必填参数${Type}
    ...    ${Type}参数为EV或者CT或者MA或者OPE或者CP \ 对应Dynamic Bypass 五个按钮
    click element    id=tab-3    #点击Dynamic Bypass
    sleep    1
    click element    id=mutual_authentication_swith
    sleep    1
    click element    id=undefined_swith
    sleep    1
    click element    id=cert_pinning1_swith
    sleep    1
    run keyword if    "${Type}"=="EV"    click element    id=ev_cert_swith
    ...    ELSE IF    "${Type}"=="CT"    click element    id=cert_transparency_swith
    ...    ELSE IF    "${Type}"=="MA"    click element    id=mutual_authentication_swith
    ...    ELSE IF    "${Type}"=="OPE"    click element    id=undefined_swith
    ...    ELSE IF    "${Type}"=="CP"    click element    id=cert_pinning1_swith

Certificate Checks-close
    [Documentation]    次关键字为关闭Certificate Checks的四个按钮
    click element    id=tab-1    #点击Certificate Checks
    sleep    1
    click element    id=cn_swith
    sleep    1
    click element    id=issuer_swith
    sleep    1
    click element    id=self_signed_swith
    sleep    1
    click element    id=expiration_swith

Protocol Version
    [Arguments]    ${Type}    ${Type1}    ${Type2}
    [Documentation]    调用次关键字前需要添加必填参数：
    ...    ${Type}:填入MCV或者AH2
    ...    ${Type1}：对应最小版本号（填入：3.0或者1.0或者1.1或者1.2或者1.3）
    ...    ${Type2}：对应最大版本号（填入：3.0或者1.0或者1.1或者1.2或者1.3）
    click element    id=tab-4
    sleep    1
    run keyword if    "${Type}"=="MCV"    run keywords    click element    id=interceptionadd_sslver_swith
    ...    AND    Mirror Client Versions-close    ${Type1}    ${Type2}
    ...    ELSE IF    "${Type}"=="AH2"    click element    id=interceptionaddallhttp_swith

Mirror Client Versions-close
    [Arguments]    ${Type}    ${Type1}
    [Documentation]    调用次关键字前需要添加必填参数：
    ...    ${Type}：对应最小版本号（填入：3.0或者1.0或者1.1或者1.2或者1.3）
    ...    ${Type1}：对应最大版本号（填入：3.0或者1.0或者1.1或者1.2或者1.3）
    sleep    1
    click element    id=interceptionadd_sslmin
    sleep    1
    run keyword if    "${Type}"=="3.0"    click element    id=pro_min0
    ...    ELSE IF    "${Type}"=="1.0"    click element    id=pro_min1
    ...    ELSE IF    "${Type}"=="1.1"    click element    id=pro_min2
    ...    ELSE IF    "${Type}"=="1.2"    click element    id=pro_min3
    ...    ELSE IF    "${Type}"=="1.3"    click element    id=pro_min4
    sleep    1
    click element    id=interceptionadd_sslmax
    sleep    1
    run keyword if    "${Type1}"=="3.0"    click element    id=pro_max0
    ...    ELSE IF    "${Type1}"=="1.0"    click element    id=pro_max1
    ...    ELSE IF    "${Type1}"=="1.1"    click element    id=pro_max2
    ...    ELSE IF    "${Typeq}"=="1.2"    click element    id=pro_max3
    ...    ELSE IF    "${Typeq}"=="1.3"    click element    id=pro_max4
