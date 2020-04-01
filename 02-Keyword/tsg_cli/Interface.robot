*** Settings ***
Library         json
Library         String 
Library         DateTime   
Library         SSHLibrary
Library         Collections  
Library         RequestsLibrary
Library         Selenium2Library  
Resource        ../../03-Variable/bifangapivariable.txt

*** Variables ***
${Tsg_Policy}           tsg_policy
${Tsg_Policy_Object}    tsg_policy_object
${Tsg_Record}           tsg_record
${Tsg_Show}             tsg_show
${Tsg_Passwd}           tsg_passwd
${Tsg_Help_file_Path}   cli_files/tsg_help.txt

*** Keywords ***
Get_Policy_Object1
    [Arguments]    ${type}
    ${dict}    Tsg_Policy_Query    ${type}    ${None}    ${None}    ${None}    ${True}
    Should Be True    ${dict}[data][total] > 1
    [Return]    ${dict}[data][list][1]
    
Get_Policy_Object2
    [Arguments]    ${type}
    ${dict}    Tsg_Policy_Query    ${type}    ${None}    ${None}    ${None}    ${True}
    [Return]    ${dict}[data][list][0]
    
Get_Policy_Object3    
    [Arguments]    ${type}
    ${obj}    Get_Policy_Object1    ${type}
    ${commandType1}    Run Keyword If    ${obj}[isValid]==0    Set Variable    enable        
                      ...    ELSE    Set Variable    disable
    ${commandType2}    Run Keyword If    ${obj}[isValid]==1    Set Variable    enable        
                      ...    ELSE    Set Variable    disable
    Set To Dictionary    ${obj}    commandType1=${commandType1}    commandType2=${commandType2}  
    [Return]    ${obj}

Get_Policy_Object4
    [Arguments]    ${type}
    ${dict}    Tsg_Policy_Object_Query    ${type}    ${None}    ${True}
    [Return]    ${dict}[data][list][0]

Get_File_Name
    [Arguments]    ${ObjectType}    ${FileType}
    ${date}    Get Current Date
    ${date_stamp}    Convert Date    ${date}    epoch
    ${time}    Evaluate    int(round(${date_stamp} * 1000))
    ${filename}    Set Variable    ${ObjectType}_export_${time}.${FileType}
    [Return]    ${filename}

Get_Import_Info
    [Arguments]    ${type}
    ${date}    Get Current Date
    ${date_stamp}    Convert Date    ${date}    epoch
    ${time}    Evaluate    int(round(${date_stamp} * 1000))
    ${name}    Set Variable    ${type}_import_${time}
    [Return]    ${name}    

Tsg_Policy_Query
    # ${type}：必传    @{param}：非必传，最大参数数量为四位。依次顺序为'policyId'、'policyName'、'policyDesc'和'allFlag',中间存在为空参数可用'${None}'占位
    [Arguments]    ${type}    @{params}
    ${str}    Evaluate    '${Tsg_Policy} --query --policyType %s ' % ('${type}')
    ${str}    Run Keyword If    '${params}[0]' != '${None}'    Evaluate    '${str}--policyId %s ' % ('${params}[0]')
              ...    ELSE    Set Variable    ${str}             
    ${str}    Run Keyword If    '${params}[1]' != '${None}'    Evaluate    '${str}--policyName "%s" ' % ('${params}[1]')
              ...    ELSE    Set Variable    ${str}         
    ${str}    Run Keyword If    '${params}[2]' != '${None}'    Evaluate    '${str}--policyDesc "%s" ' % ('${params}[2]')
              ...    ELSE    Set Variable    ${str}         
    ${str}    Run Keyword If    ${params}[3] == ${True}        Evaluate    '${str}--all '
              ...    ELSE    Set Variable    ${str}
    Log    ${str}
    ${r}      Run1    ${str}
    [Return]    ${r}    

Tsg_Policy_EnDisable
    # ${id}：必传    ${type}：必传    ${commandType}：必传'enable'|'disable'
    [Arguments]    ${id}    ${type}    ${commandType}
    ${str}    Evaluate    '${Tsg_Policy} --%s --policyId %s --policyType %s' % ('${commandType}', '${id}', '${type}')
    Run2    ${str}    

Tsg_Policy_Object_Query
    # @{param}：非必传，最大参数数量为三位。依次顺序为'objectName'、'objectType'和'allFlag',中间存在为空参数可用'${None}'占位
    [Arguments]    @{params}
    ${str}    Set Variable     ${Tsg_Policy_Object} --query
    ${str}    Run Keyword If    '${params}[0]' != '${None}'    Evaluate    '${str} --objectType "%s" ' % ('${params}[0]')
              ...    ELSE    Set Variable    ${str}    
    ${str}    Run Keyword If    '${params}[1]' != '${None}'    Evaluate    '${str} --objectName "%s" ' % ('${params}[1]')
              ...    ELSE    Set Variable    ${str}    
    ${str}    Run Keyword If    ${params}[2] == ${True}        Evaluate    '${str} --all '
              ...    ELSE    Set Variable    ${str}
    ${r}    Run1    ${str}
    [Return]    ${r}    

Tsg_Policy_Object_Import
    # ${type}：必传    ${file}：必传    @{params}：非必传，含义'objectName'
    [Arguments]    ${type}    ${file}    @{params}
    ${newFile}    Replace String    ${file}    export    import
    ${command}    Set Variable    head -n 2 files/${file} > files/${newFile}    
    Run4    ${command}
    ${str}    Evaluate    '${Tsg_Policy_Object} --import --objectType %s --file files/%s ' % ('${type}','${newFile}')    
    ${str}    Run Keyword If    '${params}[0]' != '${None}'    Evaluate    '${str}--objectName %s ' % ('${params}[0]')
              ...    ELSE    Set Variable    ${str}    
    Run3    ${str}    

Tsg_Policy_Object_Export
    # ${type}：必传    ${file}：必传    @{params}：非必传，含义'exportFormat'(txt|csv)
    [Arguments]    ${type}    ${file}    @{params}
    ${str}    Evaluate    '${Tsg_Policy_Object} --export --objectType %s --file files/%s ' % ('${type}','${file}')    
    ${str}    Run Keyword If    '${params}[0]' != '${None}'    Evaluate    '${str}--exportFormat %s ' % ('${params}[0]')
              ...    ELSE    Set Variable    ${str}     
    Run3    ${str}    

Tsg_Record_UserList
    ${str}    Set Variable    ${Tsg_Record} --userlist
    Run6    ${str}    ${cliUsername}
        
Tsg_Record_Query
    ${str}    Evaluate    '${Tsg_Record} --username %s ' % ('${cliUsername}')
    ${param}    Set Variable    ${Tsg_Record} --userlist
    Run6    ${str}    ${param}    

Clear_Test_Data
    ${str}    Set Variable    rm -rf /home/${cliUsername}/files/*
    Run4    ${str}

Tsg_Help_Keyword
    ${r}    Run5    tsg_help
    ${data}    Evaluate    open(r"${path}/${Tsg_Help_file_Path}",'rb').read()
    Should Be Equal As Strings    ${r}    ${data} 
     
Tsg_Diagnose_Keyword
    Write Until Expected Output    tsg_diagnose\n    Success    ${timeout}    ${timeout}

Tsg_Show_Chassis-ip
    ${str}    Set Variable    ${Tsg_Show} --chassis-ip
    ${r}    Run5    ${str}
    Should Contain    ${r}    Name
    Should Contain    ${r}    IP
    
Tsg_Show_Chassis-port
    ${str}    Set Variable    ${Tsg_Show} --chassis-port
    ${r}    Run5    ${str}
    Should Contain    ${r}    PortId
    Should Contain    ${r}    Type
    Should Contain    ${r}    Function
    Should Contain    ${r}    Description
    
Tsg_Show_Interface
    ${str}    Set Variable    ${Tsg_Show} --interface
    ${r}    Run5    ${str}
    Should Contain    ${r}    time
    Should Contain    ${r}    PhyRXBits
    Should Contain    ${r}    PhyRXFrame
    Should Contain    ${r}    PhyTXBits
    Should Contain    ${r}    PhyTXFrame
    Should Contain    ${r}    flow_type
    Should Contain    ${r}    sled
    
Tsg_Show_APP
    ${str}    Set Variable    ${Tsg_Show} --app
    ${r}    Run5    ${str}
    Should Contain    ${r}    time
    Should Contain    ${r}    RxBits
    Should Contain    ${r}    RxPkts
    Should Contain    ${r}    TxBits
    Should Contain    ${r}    TxPkts
    Should Contain    ${r}    device
    Should Contain    ${r}    flow_type
    Should Contain    ${r}    sled
    
Tsg_Show_Protocol
    ${str}    Set Variable    ${Tsg_Show} --protocol
    ${r}    Run5    ${str}
    Should Contain    ${r}    time
    Should Contain    ${r}    Eth_Bit
    Should Contain    ${r}    Ipv4_Bit
    Should Contain    ${r}    Ipv6_Bit
    Should Contain    ${r}    Tcp_Bit
    Should Contain    ${r}    Udp_Bit
    Should Contain    ${r}    device
    Should Contain    ${r}    flow_type
    Should Contain    ${r}    sled
    
Tsg_Show_Stream
    ${str}    Set Variable    ${Tsg_Show} --stream
    ${r}    Run5    ${str}
    Should Contain    ${r}    time
    Should Contain    ${r}    Tcp_Link_New
    Should Contain    ${r}    Tcp_Concurrent
    Should Contain    ${r}    Tcp_Link_Double
    Should Contain    ${r}    device
    Should Contain    ${r}    flow_type
    Should Contain    ${r}    sled
    
Tsg_Show_Intercept
    ${str}    Set Variable    ${Tsg_Show} --intercept
    ${r}    Run5    ${str}
    Should Contain    ${r}    time
    Should Contain    ${r}    intcp_rdy_bits
    Should Contain    ${r}    intcp_rdy_stm
    Should Contain    ${r}    intcped_bits
    Should Contain    ${r}    intcped_stm
    Should Contain    ${r}    sled

Tsg_Passwd_Keyword
    ${str1}    Evaluate    '${Tsg_Passwd} --password %s' % ('${cliPassword}x')
    Run7    ${str1}
    ${str2}    Evaluate    '${Tsg_Passwd} --password %s --username %s' % ('${cliPassword}y','${cliUsername}')
    Run7    ${str2}    
    ${str3}    Evaluate    '${Tsg_Passwd} --password %s' % ('${cliPassword}')
    Run7    ${str3}    

Run1
    [Arguments]    ${command}
    Write    ${command}
    ${r}    Read    delay=10s
    ${dict}    Run Keyword If    '${cliUsername}'!='tsgadmin'    Run1_A    ${r}        
               ...    ELSE    Run1_B    ${r}    
    [Return]    ${dict}

Run1_A
    [Arguments]    ${r}
    Should Contain    ${r}    Permission denied
    ${dict}    To Json    {"data":{"list":[{"policyDesc":"","policyId":0,"policyName":"","policyType":"","objectType":"","objectName":"","isValid":0},{"policyDesc":"","policyId":0,"policyName":"","policyType":"","isValid":0}],"total":2},"msg":"Success"}
    [Return]    ${dict}    

Run1_B
    [Arguments]    ${r}    
    Should Contain    ${r}    Success
    ${str}    Replace String    ${r}    ${\n}    -
    ${str}    Replace String    ${str}    '    \\'
    ${index}    Evaluate    '${str}'.rindex('}') + 1
    ${len}    Convert To Integer    ${index}    
    ${json}    Evaluate    '${str}'[0:${len}]
    ${dict}    json.Loads    ${json}
    Should Be True    ${dict}[data][total] > 0
    [Return]    ${dict}

Run2
    [Arguments]    ${command}
    Write    ${command}
    ${r}    Read    delay=10s
    Run Keyword If    '${cliUsername}'!='tsgadmin'    Should Contain    ${r}    Permission denied        
    ...    ELSE    Should Contain    ${r}    Success   

Run3
    [Arguments]    ${command}
    ${flag}    Run Keyword If    '${cliUsername}'!='tsgadmin'    Set Variable    Permission denied            
               ...    ELSE    Set Variable    Success
    Write Until Expected Output    ${command}\n    ${flag}    ${timeout}    ${timeout}
        
Run4
    [Arguments]    ${command}
    Write    ${command}    
    ${r}    Read    delay=10s
    Run Keyword If    '${cliUsername}'!='tsgadmin'    Should Contain Any    ${r}    Permission denied    -bash:            
    ...    ELSE    Should Not Contain    ${r}    head:

Run5
    [Arguments]    ${command}
    Write    ${command}
    ${r}    Read    delay=10s   
    Should Not Be Empty    ${r}
    [Return]    ${r}

Run6
    [Arguments]    ${command}    ${param}
    Write    ${command}
    ${r}    Read    delay=10s   
    Should Not Be Empty    ${r}
    Run Keyword If    '${cliUsername}'!='tsgadmin'    Should Contain    ${r}    Permission denied            
    ...    ELSE    Should Contain    ${r}    ${param}

Run7
    [Arguments]    ${command}
    Write    ${command}
    ${r}    Read    delay=10s
    Should Contain    ${r}    Success
