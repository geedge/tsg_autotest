*** Settings ***
Library    String
Library    json
Library    OperatingSystem
Library    RequestsLibrary
Library    Selenium2Library
Library    Collections
Library    FileLibrary
Resource    ../../02-Keyword/tsg_bfapi/Common.robot
Resource    ../../03-Variable/BifangApiVariable.txt


*** Keywords ***
insert_policyId_to_file
    [Arguments]    ${key}    ${policyId}    ${objectids}    
    ${dict}    Create Dictionary    policyId=${policyId}    objectId=${objectids}
    ${json}    json.Dumps    ${dict}    
    Alter Dict    ${path}/03-Variable/AllFlowCaseVariable.txt    ${key}    ${json}
    
insert_time_to_file
    [Arguments]    ${key}    ${starttime}    ${endtime}    
    ${value}    json.Loads    ${${key}}
    ${dict}    Create Dictionary    policyId=${value}[policyId]    objectId=${value}[objectId]     starttime=${starttime}    endtime=${endtime}
    ${json}    json.Dumps    ${dict}    
    Alter Dict    ${path}/03-Variable/AllFlowCaseVariable.txt    ${key}    ${json}
