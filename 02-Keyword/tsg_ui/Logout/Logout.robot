*** Settings ***
Library           Selenium2Library
Resource          ../Objects/ObjectPages.robot

*** Keywords ***
Logout
    Mouse Hover    xpath=//*[@id="app"]/div/div[1]/div[2]/div/span/div/span
    sleep    0.5
    click element    xpath=//div[@class='SignOut']
    sleep    2
    Close All Browsers

UiLogoutAndDelLocalIP
    [Arguments]    ${tempParm}
    log    UiLogoutAndDelLocalIP${tempParm}
    Objects.DeletePage    ${LocahIPName}
    Logout.Logout
