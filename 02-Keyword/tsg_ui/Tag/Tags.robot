*** Settings ***
Library           Selenium2Library

*** Keywords ***
ui-tags-create
    [Arguments]    ${tag-name}    ${color-element}    ${tag-value}
    [Documentation]    引用关键字，填入必填参数：
    ...    ${tag-name}:输入tag 的name
    ...    ${color-element}:选择tag字体的颜色
    ...    ${tag-value}:输入tag内容
    click element    id=tagAdd    #点击create按钮，新建tag
    sleep    2
    input text    id=tagsAdd_name    ${tag-name}    #输入tag name
    sleep    1
    click element    id=tagsAdd_color    #点击color
    sleep    2
    click element    ${color-element}    #选择tag字体颜色
    sleep    2
    input text    id=tag_tagName0    ${tag-value}    #输入tag内容
    sleep    1
    click element    id=tagAddOk1
    sleep    1

ui-tags-create-1
    [Arguments]    ${tag-name}    ${color-element}    ${tag-value}    ${tag-value1}
    [Documentation]    引用关键字，填入必填参数：
    ...    ${tag-name}:输入tag 的name
    ...    ${color-element}:选择tag字体的颜色
    ...    ${tag-value}:输入tag内容
    ...    ${tag-value1}:输入tag内容
    click element    id=tagAdd    #点击create按钮，新建tag
    sleep    2
    input text    id=tagsAdd_name    ${tag-name}    #输入tag name
    sleep    1
    click element    id=tagsAdd_color    #点击color
    sleep    2
    click element    ${color-element}    #选择tag字体颜色
    sleep    1
    input text    id=tag_tagName0    ${tag-value}    #输入tag内容
    sleep    1
    click element    id=tagAddInput
    input text    id=tag_tagName1    ${tag-value1}    #输入tag内容
    sleep    1
    click element    id=tagAddOk1

ui-tags-edit
    [Arguments]    ${tag-name}    ${color-element}    ${tag-value}
    [Documentation]    引用关键字，填入必填参数：
    ...    ${tag-name}:输入tag 的name
    ...    ${color-element}:选择tag字体的颜色
    ...    ${tag-value}:输入tag内容
    sleep    1
    click element    id=tagEdit    #点击edit按钮
    sleep    2
    input text    id=tagsAdd_name    ${tag-name}    #输入tag name
    sleep    2
    click element    id=tagsAdd_color    #点击color
    sleep    1
    click element    ${color-element}    #选择tag字体颜色
    sleep    1
    input text    id=tag_tagName0    ${tag-value}    #输入tag内容
    sleep    1
    click element    id=tagAddOk1
    sleep    1

ui-tags-search-id
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

ui-tags-search-name
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

ui-tags-delete
    sleep    1
    click element    id=tagDel    #点击删除按钮
    sleep    1
    click element    id=tags-tagsDel-confirm

ui-tags-edit-1
    [Arguments]    ${tag-name}    ${color-element}    ${tag-value}    ${tag-value1}
    [Documentation]    引用关键字，填入必填参数：
    ...    ${tag-name}:输入tag 的name
    ...    ${color-element}:选择tag字体的颜色
    ...    ${tag-value}:输入tag内容
    ...    ${tag-value1}:输入tag内容
    sleep    1
    click element    id=tagEdit    #点击edit按钮
    sleep    2
    input text    id=tagsAdd_name    ${tag-name}    #输入tag name
    sleep    1
    click element    id=tagsAdd_color    #点击color
    sleep    1
    click element    ${color-element}    #选择tag字体颜色
    sleep    2
    input text    id=tag_tagName0    ${tag-value}    #输入tag内容
    sleep    1
    sleep    1
    click element    id=tagAddInput
    input text    id=tag_tagName1    ${tag-value1}    #输入tag内容
    click element    id=tagAddOk1
    sleep    1
