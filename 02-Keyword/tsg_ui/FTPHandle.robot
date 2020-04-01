*** Settings ***
Library           FtpLibrary

*** Keywords ***
checkFTPRecvReport
    [Arguments]    ${fURL}    ${fport}    ${fuser}    ${fpwd}    ${fpath}    ${filename}
    [Documentation]    [fURL写法例如:192.168.1.1]
    ...    [fport写法例如：21]
    ...    [fuser写法例如：wxs]
    ...    [fpwd要写ftp服务器的密码，写法例如：111111]
    ...    [fpath要写ftp服务器的绝对路径，写法例如：/a/b/20200110/]
    ...    [filename,是指系统下发report时对report起的名字，在这里判断方法是ftp文件名称是否包含report名称，所以在TSG系统上下发report时应尽量不要用重名，以免判断失误，写法例如：长安街]
    ...    [注意：该关键字无返回值，他是等同于一个用例，若字符串不包含则表示用例执行失败，会有相关信息打印]
    [Tags]    function    FTP    reportResult
    Ftp Connect    ${fURL}    ${fuser}    ${fpwd}    ${fport}
    sleep    1
    cwd    ${fpath}
    sleep    1
    @{dirname}    Dir Names
    sleep    1
    ${Strdirname}    Evaluate    ''.join(@{dirname})
    Should Contain    ${Strdirname}    ${filename}
    ftp close

FTPDownloadFile
    [Arguments]    ${fURL}    ${fport}    ${fuser}    ${fpwd}    ${SrcPath}    ${SrcName}    ${dstPathName}
    [Documentation]    [fUrl是FTP服务器地址，例如:192.168.1.1]
    ...    [fport是ftp服务器的端口号，例如：21]
    ...    [fuser是用户名，例如：wxs]
    ...    [fpwd是密码，例如：wqqq]
    ...    [SrcPath是ftp服务器上的要下载的文件的路径，文件包名称必须写，例如：/a/b/]
    ...    [SrcName是ftp服务器上的要下载的文件名称，文件名称不要太复杂(不要包含符号)，否则无法识别，例如：teacher王.txt]
    ...    [dstPathName是下载到本地时的本地路径名（+名称），名称可不写，建议不写，下载到本地的名称就会与FTP上文件一样，写法：1. D:/rfftppy/tmp/ 2.D:/rfftppy/tmp/b.txt \]
    [Tags]    function    FTP    downloadFile
    Ftp Connect    ${fURL}    ${fuser}    ${fpwd}    ${fport}
    cwd    ${SrcPath}
    sleep    1
    download file    ${SrcName}    ${dstPathName}
    ftp close

FTPUploadFileToTest
    [Arguments]    ${fURL}    ${fport}    ${fuser}    ${fpwd}    ${SrcPathName}
    [Documentation]    [fURL写法例如:192.168.1.1]
    ...    [fport写法例如：21]
    ...    [fuser写法例如：wxs]
    ...    [fpwd要写ftp服务器的密码，写法例如：111111]
    ...    [SrcPathName,本地待上传的文件的路径名，例如：E:/qqq.txt]
    ...    [注意：该关键字默认上传到ftp服务器的/test目录下，若test目录不存在会自己创建]
    [Tags]    function    FTP    uploadFileToTest
    ${intest}    Set Variable    test
    Run Keyword If    '${fport}'!='21'    Run Keyword    Log    请注意：FTP服务器端口号不是21（默认端口号），请继续登入
    ...    AND    Log    登入中...
    Ftp Connect    ${fURL}    ${fuser}    ${fpwd}    ${fport}
    @{dirnames}    Dir Names
    ${result}    checkListContainStirng    ${intest}    @{dirnames}
    log    ${SrcPathName}
    Run Keyword If    '${result}'=='${intest}'    log    /test目录存在
    ...    ELSE    Run Keyword    log    /test目录不存在，已创建并上传文件
    ...    AND    Mkd    ${intest}
    Cwd    ${intest}
    Comment    @{aa}    Dir Names
    Upload File    ${SrcPathName}

checkListContainStirng
    [Arguments]    ${str}    @{strlist}
    FOR    ${value}    IN    @{strlist}
        Log    ${value}
        Return From Keyword If    '${value}'=='${str}'    ${value}
    END
    Return From Keyword    ${value}

FTPUploadFile
    [Arguments]    ${fURL}    ${fport}    ${fuser}    ${fpwd}    ${SrcPathName}
    [Documentation]    [fURL写法例如:192.168.1.1]
    ...    [fport写法例如：21]
    ...    [fuser写法例如：wxs]
    ...    [fpwd要写ftp服务器的密码，写法例如：111111]
    ...    [SrcPathName,本地待上传的文件的路径名，例如：E:/qqq.txt]
    ...    [注意：该关键字默认上传到ftp服务器的root目录下]
    [Tags]    function    FTP    uploadFile
    Run Keyword If    '${fport}'!='21'    Run Keyword    Log    请注意：FTP服务器端口号不是21（默认端口号），请继续登入
    ...    AND    Log    登入中...
    Ftp Connect    ${fURL}    ${fuser}    ${fpwd}    ${fport}
    Upload File    ${SrcPathName}

FTPLogin
    [Arguments]    ${fURL}    ${fport}    ${fuser}    ${fpwd}
    [Documentation]    [fURL写法例如:192.168.1.1]
    ...    [fport写法例如：21]
    ...    [fuser写法例如：wxs]
    ...    [fpwd要写ftp服务器的密码，写法例如：111111]
    [Tags]    function    FTP    login
    Ftp Connect    ${fURL}    ${fuser}    ${fpwd}    ${fport}
    Get Welcome
