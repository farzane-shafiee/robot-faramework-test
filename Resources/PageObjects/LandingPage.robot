*** Settings ***
Documentation    Test Amazing and simple product
Library    SeleniumLibrary
Library    RequestsLibrary
Library    JSONLibrary
Library    Collections


*** Variables ***
${baseUrl}  https://demo-dknow-api.digikala.com
${USERNAME}   +989193619468
&{header}    Content-Type=application/json   User-Agent=RobotFramework
${TOKEN}
${USER_ID}
${FINAL_TOKEN}
${ADDRESS_ID}   3241691

*** Test Cases ***
Test API
    Get Token
    Get Final Token
    Set Address

*** Keywords ***
Get Token
    Create Session    token  ${baseUrl}    verify=true
    ${response}=  POST On Session  token   /user/login-register/   data={"phone": "${USERNAME}"}  headers=${header}
    Set Global Variable    ${TOKEN}    ${response.json()['data']['token']}
    Set Global Variable    ${USER_ID}    ${response.json()['data']['user_id']}
    Should Be Equal As Strings    ${response.status_code}  200
    Log To Console    token= ${TOKEN} user_id = ${USER_ID}

Get Final Token
#    [Arguments]    ${user_id}  ${token}
    &{body}     Create Dictionary    user_id=${USER_ID}  token=${TOKEN}  code=111111
    Log To Console    ${body}
#    ${json}  Evaluate  json.dumps(${body})  json
#    ${json}  Convert Json To String    ${body}
#    ${json}  Update Value To Json    ${body}
    Create Session    mysession  ${baseUrl}    verify=true
    ${response}=  POST On Session  mysession   /user/confirm-phone/  json=${body}   headers=${header}
    Set Global Variable    ${FINAL_TOKEN}   ${response.json()['data']['token']}
    Set Global Variable    ${PHONE}  ${response.json()['data']['in_track']['user_info']['phone']}
    Should Be Equal As Strings    ${response.status_code}   200
    Should Contain    ${USERNAME}  ${PHONE}

Set Address
    Create Session    mysession  ${baseUrl}    verify=true
#    &{data_header}  Create Dictionary    Accept=application/json, text/plain, */*    Accept-Language=en-GB,en-US;q=0.9,en;q=0.8,fa;q=0.7
#    ...  Authorization=${FINAL_TOKEN}   Client=desktop  ClientId=087eb5ad-33d4-4ea6-a4fd-c1d7672b0bc4   ClientOs=Windows
#    ...  Connection=keep-alive  Content-Type=application/json   Origin=https://demo.digikalajet.com
#    ...  Referer=https://demo.digikalajet.com/  Sec-Fetch-Dest=empty  Sec-Fetch-Mode=cors  Sec-Fetch-Site=cross-site
#    ...  User-Agent=Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/107.0.0.0 Safari/537.36
#    ...  X-Request-UUID=067b7d1f-2067-4a16-83dd-5cf0923d97d4  sec-ch-ua="Google Chrome";v="107", "Chromium";v="107", "Not=A?Brand";v="24"
#    ...  sec-ch-ua-mobile=?0  sec-ch-ua-platform=Windows

    &{data_header}  Create Dictionary    Authorization=${FINAL_TOKEN}
    Log To Console    ${ADDRESS_ID}
    ${response}=  POST On Session  mysession   /address/${ADDRESS_ID}/set-default/    headers=${data_header}
    ${address_id}   Set Variable    ${response.json()['data']['address']['id']}
    Should Not Be Empty    0    ${address_id}
    Should Be Equal As Strings    ${response.status_code}   200
    Log To Console    ${response.content}