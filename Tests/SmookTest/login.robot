*** Settings ***
Documentation    Test Amazing and simple product
Library    SeleniumLibrary

*** Variables ***

${login-registerButton}  //div[text()="ورود / عضویت"]/parent::button
${disabledUsernameButton}  //button[@data-testid="USER_LOGIN_PHONE_SUBMIT_BUTTON" and contains(@class, "disabled")]
${usernameInput}  //*[@data-testid="USER_LOGIN_PHONE_INPUT"]
${enabledUsernameButton}  //button[@data-testid="USER_LOGIN_PHONE_SUBMIT_BUTTON" and not(contains(@class, "disabled"))]
${usernameButton}  //button[@data-testid="USER_LOGIN_PHONE_SUBMIT_BUTTON"]
${usernameLable}  //p[contains(text(), "شماره")]
${passwordInput}  //input[@data-testid="USER_LOGIN_PHONE_VERIFICATION_INPUT"]

*** Keywords ***
Login Valid
    [Arguments]    ${username}  ${password}
    Wait Until Page Contains Element    ${login-registerButton}
    Click Button  ${login-registerButton}
    Wait Until Page Contains Element    ${disabledUsernameButton}
    Page Should Contain Element    ${disabledUsernameButton}
    Input Text  ${usernameInput}  ${username}
    Wait Until Page Contains Element    ${enabledUsernameButton}
    Page Should Contain Element    ${enabledUsernameButton}
    Click Button  ${usernameButton}
    Wait Until Page Contains Element    ${passwordInput}
    Page Should Contain Element    ${usernameLable}    ${username}
    Input Text  ${passwordInput}  ${password}
    Wait Until Page Contains Element    //p[contains(text(),'تحویل در')]
