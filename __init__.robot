*** Settings ***
Suite Setup       LoginAndAddLocalIP
Suite Teardown    LogoutAndDelLocalIP
Resource          02-Keyword/tsg_common/LoginAndLogoutTypeSwitch.robot
