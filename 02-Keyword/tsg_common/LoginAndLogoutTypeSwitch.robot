*** Settings ***
Resource          ../../03-Variable/BifangApiVariable.txt
Library           REST    http://${host}:${port}
Library           Collections
Resource          ../tsg_bfapi/LoginLogout.robot
Resource          ../tsg_ui/Logout/Logout.robot
Resource          ../tsg_ui/Login/Login.robot

*** Keywords ***
LoginAndAddLocalIP
    Run Keyword If    '${loginType}' == 'api'    ApiLoginAndAddLocalIP    aa
    ...    ELSE IF    '${loginType}' == 'cli'    CliLogin
    ...    ELSE    UiLoginAndAaddLocalIP    bb

LogoutAndDelLocalIP
    Run Keyword If    '${loginType}' == 'api'    ApiLogoutAndDelLocalIP    aa
    ...    ELSE IF    '${loginType}' == 'cli'    CliLogout
    ...    ELSE    UiLogoutAndDelLocalIP    bb