*** Settings ***
Library           Selenium2Library

*** Keywords ***
Schedules-create
    [Arguments]    ${name}    ${type1}    ${number}    ${weeks}    ${dateorweeks}    ${dates}
    ...    ${aweeks}    ${Start Date}    ${End Date}    ${Start Time}    ${End Time}
    click element    id=scheduleAdd    #点击create按钮
    sleep    1
    input text    id=schedule_name    ${name}
    sleep    1
    ${type}    set variable    ${type1}
    run keyword if    '${type}'=='Daily'    run keywords    sleep    1
    ...    AND    Schedules-Daily    ${number}
    ...    ELSE IF    '${type}'=='Weekly'    run keywords    sleep    1
    ...    AND    Schedules-Weekly    ${number}    ${weeks}
    ...    ELSE IF    '${type}'=='Monthly'    run keywords    sleep    1
    ...    AND    Schedules-Monthly    ${dateorweeks}    ${number}    ${dates}    ${aweeks}
    ...    ${weeks}
    ...    ELSE IF    '${type}'=='One-time'    run keywords    sleep    1
    ...    AND    click element    id=scheduleAddTypeSingle
    sleep    1
    input text    id=schedulead_startdate    ${Start Date}    #开始日期
    sleep    1
    click element    xpath=//*[@id="policy_Manipulation_create5"]/div[2]
    sleep    1
    input text    xpath=//*[@id="policy_Manipulation_create5"]/div[2]/form/div[5]/div/div/input    ${End Date}    #结束日期
    sleep    1
    click element    xpath=//*[@id="policy_Manipulation_create5"]/div[2]
    sleep    1
    input text    id=schedulead_startTime    ${Start Time}    #开始时间
    sleep    1
    click element    xpath=//*[@id="policy_Manipulation_create5"]/div[2]
    sleep    1
    input text    xpath=//*[@id="policy_Manipulation_create5"]/div[2]/form/div[7]/div/div/input    ${End Time}    #结束时间
    sleep    1
    click element    xpath=//*[@id="policy_Manipulation_create5"]/div[2]
    sleep    2
    click element    xpath=//*[@id="policy_Manipulation_create5"]/div[2]/form/div[8]/div/div/button[1]    #点击OK
    sleep    2

Schedules-Daily
    [Arguments]    ${number}
    click element    id=scheduleAddTypeDaily    #点击 Daily
    sleep    1
    input text    xpath=//*[@id="schedule_interval"]/div/input    ${number}
    sleep    1

Schedules-Weekly
    [Arguments]    ${number}    ${weeks}
    click element    id=scheduleAddTypeWeekly    #点击Weekly
    sleep    1
    input text    xpath=//*[@id="schedule_interval"]/div/input    ${number}
    sleep    1
    ${week}    set variable    ${weeks}
    run keyword if    '${week}'=='SUN'    run keywords    sleep    1
    ...    AND    click element    id=schedulead_cities0
    ...    ELSE IF    '${week}'=='MON'    run keywords    sleep    1
    ...    AND    click element    id=schedulead_cities1
    ...    ELSE IF    '${week}'=='TUE'    run keywords    sleep    1
    ...    AND    click element    id=schedulead_cities2
    ...    ELSE IF    '${week}'=='WED'    run keywords    sleep    1
    ...    AND    click element    id=schedulead_cities3
    ...    ELSE IF    '${week}'=='THU'    run keywords    sleep    1
    ...    AND    click element    id=schedulead_cities4
    ...    ELSE IF    '${week}'=='FRI'    run keywords    sleep    1
    ...    AND    click element    id=schedulead_cities5
    ...    ELSE IF    '${week}'=='SAT'    run keywords    sleep    1
    ...    AND    click element    id=schedulead_cities6
    sleep    1

Schedules-Monthly
    [Arguments]    ${dateorweeks}    ${number}=null    ${dates}=null    ${aweeks}=null    ${weeks}=null
    click element    id=scheduleAddTypeMonthly    #点击monthly
    sleep    1
    ${dateorweek}    set variable    ${dateorweeks}
    run keyword if    '${dateorweek}'=='Date'    run keywords    sleep    1
    ...    AND    click element    xpath=//*[@id="policy_Manipulation_create5"]/div[2]/form/div[3]/div/div[1]/label[1]
    ...    AND    Schedules-Monthly-Date    ${number}    ${dates}
    ...    ELSE IF    '${dateorweek}'=='Week'    run keywords    sleep    1
    ...    AND    click element    xpath=//*[@id="policy_Manipulation_create5"]/div[2]/form/div[3]/div/div[1]/label[2]
    ...    AND    Schedules-Monthly-Week    ${number}    ${aweeks}    ${weeks}

Schedules-Monthly-Date
    [Arguments]    ${number}    ${dates}
    input text    xpath=//*[@id="schedule_interval"]/div/input    ${number}
    sleep    1
    ${date}    set variable    ${dates}
    run keyword if    '${date}'=='All'    run keywords    sleep    1
    ...    AND    click element    id=schedule_alldaycontrol
    ...    ELSE IF    '${date}'=='1'    run keywords    sleep    1
    ...    AND    click element    id=schedule_onDay0
    ...    ELSE IF    '${date}'=='2'    run keywords    sleep    1
    ...    AND    click element    id=schedule_onDay1
    ...    ELSE IF    '${date}'=='3'    run keywords    sleep    1
    ...    AND    click element    id=schedule_onDay2
    ...    ELSE IF    '${date}'=='4'    run keywords    sleep    1
    ...    AND    click element    id=schedule_onDay3
    ...    ELSE IF    '${date}'=='5'    run keywords    sleep    1
    ...    AND    click element    id=schedule_onDay4
    ...    ELSE IF    '${date}'=='6'    run keywords    sleep    1
    ...    AND    click element    id=schedule_onDay5
    ...    ELSE IF    '${date}'=='7'    run keywords    sleep    1
    ...    AND    click element    id=schedule_onDay6
    ...    ELSE IF    '${date}'=='8'    run keywords    sleep    1
    ...    AND    click element    id=schedule_onDay7
    ...    ELSE IF    '${date}'=='9'    run keywords    sleep    1
    ...    AND    click element    id=schedule_onDay8
    ...    ELSE IF    '${date}'=='10'    run keywords    sleep    1
    ...    AND    click element    id=schedule_onDay9
    ...    ELSE IF    '${date}'=='11'    run keywords    sleep    1
    ...    AND    click element    id=schedule_onDay10
    ...    ELSE IF    '${date}'=='12'    run keywords    sleep    1
    ...    AND    click element    id=schedule_onDay11
    ...    ELSE IF    '${date}'=='13'    run keywords    sleep    1
    ...    AND    click element    id=schedule_onDay12
    ...    ELSE IF    '${date}'=='14'    run keywords    sleep    1
    ...    AND    click element    id=schedule_onDay13
    ...    ELSE IF    '${date}'=='15'    run keywords    sleep    1
    ...    AND    click element    id=schedule_onDay14
    ...    ELSE IF    '${date}'=='16'    run keywords    sleep    1
    ...    AND    click element    id=schedule_onDay15
    ...    ELSE IF    '${date}'=='17'    run keywords    sleep    1
    ...    AND    click element    id=schedule_onDay16
    ...    ELSE IF    '${date}'=='18'    run keywords    sleep    1
    ...    AND    click element    id=schedule_onDay17
    ...    ELSE IF    '${date}'=='19'    run keywords    sleep    1
    ...    AND    click element    id=schedule_onDay18
    ...    ELSE IF    '${date}'=='20'    run keywords    sleep    1
    ...    AND    click element    id=schedule_onDay19
    ...    ELSE IF    '${date}'=='21'    run keywords    sleep    1
    ...    AND    click element    id=schedule_onDay20
    ...    ELSE IF    '${date}'=='22'    run keywords    sleep    1
    ...    AND    click element    id=schedule_onDay21
    ...    ELSE IF    '${date}'=='23'    run keywords    sleep    1
    ...    AND    click element    id=schedule_onDay22
    ...    ELSE IF    '${date}'=='24'    run keywords    sleep    1
    ...    AND    click element    id=schedule_onDay23
    ...    ELSE IF    '${date}'=='25'    run keywords    sleep    1
    ...    AND    click element    id=schedule_onDay24
    ...    ELSE IF    '${date}'=='26'    run keywords    sleep    1
    ...    AND    click element    id=schedule_onDay25
    ...    ELSE IF    '${date}'=='27'    run keywords    sleep    1
    ...    AND    click element    id=schedule_onDay26
    ...    ELSE IF    '${date}'=='28'    run keywords    sleep    1
    ...    AND    click element    id=schedule_onDay27
    ...    ELSE IF    '${date}'=='29'    run keywords    sleep    1
    ...    AND    click element    id=schedule_onDay28
    ...    ELSE IF    '${date}'=='30'    run keywords    sleep    1
    ...    AND    click element    id=schedule_onDay29
    ...    ELSE IF    '${date}'=='31'    run keywords    sleep    1
    ...    AND    click element    id=schedule_onDay301sleep1
    sleep    1

Schedules-Monthly-Week
    [Arguments]    ${number}    ${aweeks}    ${weeks}
    sleep    2
    input text    xpath=/html/body/div/div/div[3]/div/div/div/div[2]/form/div[3]/div/div[2]/div/div/div/div/input    ${number}
    sleep    1
    click element    id=schedulead_select_week
    sleep    2
    ${aweek}    set variable    ${aweeks}
    run keyword if    '${aweek}'=='1'    run keywords    sleep    1
    ...    AND    click element    xpath=/html/body/div/div[1]/div[1]/ul/li[1]
    ...    ELSE IF    '${aweek}'=='2'    run keywords    sleep    1
    ...    AND    click element    xpath=/html/body/div/div[1]/div[1]/ul/li[2]
    ...    ELSE IF    '${aweek}'=='3'    run1 keywords    sleep    1
    ...    AND    click element    xpath=/html/body/div/div[1]/div[1]/ul/li[3]
    ...    ELSE IF    '${aweek}'=='4'    run keywords    sleep    1
    ...    AND    click eleme1nt    xpath=/html/body/div/div[1]/div[1]/ul/li[4]
    ...    ELSE IF    '${aweek}'=='L'    run keywords    sleep    1
    ...    AND    click element    xpath=/html/body/div/div[1]/div[1]/ul/li[5]
    sleep    1
    click element    xpath=//*[@id="policy_Manipulation_create5"]/div[2]/form/div[3]/div/div[3]/nav/div/div[2]/span/span/i
    sleep    1
    ${week}    set variable    ${weeks}
    run keyword if    '${week}'=='SUN'    run keywords    sleep    1
    ...    AND    click element    id=schedulead_cities0
    ...    ELSE IF    '${week}'=='MON'    run keywords    sleep    1
    ...    AND    click element    id=schedulead_cities1
    ...    ELSE IF    '${week}'=='TUE'    run keywords    sleep    1
    ...    AND    click element    id=schedulead_cities2
    ...    ELSE IF    '${week}'=='WED'    run keywords    sleep    1
    ...    AND    click element    id=schedulead_cities3
    ...    ELSE IF    '${week}'=='THU'    run keywords    sleep    1
    ...    AND    click element    id=schedulead_cities4
    ...    ELSE IF    '${week}'=='FRI'    run keywords    sleep    1
    ...    AND    click element    id=schedulead_cities5
    ...    ELSE IF    '${week}'=='SAT'    run keywords    sleep    1
    ...    AND    click element    id=schedulead_cities6
    ...    ELSE IF    '${week}'=='All'    run keywords    sleep    1
    ...    AND    click element    id=schedulead_weekchooseAll
    sleep    1

Schedules-delete
    sleep    1
    click element    id=scheduleDel    #点击删除按钮
    sleep    1
    click element    xpath=/html/body/div[2]/div/div[3]/button[2]

Schedules-search-id
    [Arguments]    ${id}
    sleep    1
    click element    id=one-input
    sleep    1
    click element    id=input_list_li1
    sleep    1
    input text    id=sreach_input    ${id}
    sleep    1
    click element    id=select_new_search_btn
    sleep    1
    click element    xpath=//*[@id="ly-table1-listcontent"]/div/div[3]/table

Schedules-search-name
    [Arguments]    ${name}
    sleep    1
    click element    id=one-input
    sleep    1
    click element    id=input_list_li2
    sleep    1
    input text    id=sreach_input    ${name}
    sleep    1
    click element    id=select_new_search_btn
    sleep    1
    click element    xpath=//*[@id="ly-table1-listcontent"]/div/div[3]/table

Schedules-edit
    [Arguments]    ${name}    ${type1}    ${number}    ${weeks}    ${dateorweeks}    ${dates}
    ...    ${aweeks}    ${Start Date}    ${End Date}    ${Start Time}    ${End Time}
    click element    id=scheduleEdit    #点击create按钮
    sleep    1
    input text    id=schedule_name    ${name}
    sleep    1
    ${type}    set variable    ${type1}
    run keyword if    '${type}'=='Daily'    run keywords    sleep    1
    ...    AND    Schedules-Daily    ${number}
    ...    ELSE IF    '${type}'=='Weekly'    run keywords    sleep    1
    ...    AND    Schedules-Weekly    ${number}    ${weeks}
    ...    ELSE IF    '${type}'=='Monthly'    run keywords    sleep    1
    ...    AND    Schedules-Monthly    ${dateorweeks}    ${number}    ${dates}    ${aweeks}
    ...    ${weeks}
    sleep    1
    input text    id=schedulead_startdate    ${Start Date}    #开始日期
    sleep    1
    click element    xpath=//*[@id="policy_Manipulation_create5"]/div[2]
    sleep    1
    input text    xpath=//*[@id="policy_Manipulation_create5"]/div[2]/form/div[5]/div/div/input    ${End Date}    #结束日期
    sleep    1
    click element    xpath=//*[@id="policy_Manipulation_create5"]/div[2]
    sleep    1
    input text    id=schedulead_startTime    ${Start Time}    #开始时间
    sleep    1
    click element    xpath=//*[@id="policy_Manipulation_create5"]/div[2]
    sleep    1
    input text    xpath=//*[@id="policy_Manipulation_create5"]/div[2]/form/div[7]/div/div/input    ${End Time}    #结束时间
    sleep    1
    click element    xpath=//*[@id="policy_Manipulation_create5"]/div[2]
    sleep    1
    click element    xpath=//*[@id="policy_Manipulation_create5"]/div[2]/form/div[8]/div/div/button[1]    #点击OK
    Sleep    2
