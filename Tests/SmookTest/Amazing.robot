*** Settings ***
Documentation    Test Amazing and simple product
Library    SeleniumLibrary
Resource    login.robot
Resource    ../../Resources/PageObjects/LandingPage.robot
Resource    ../../Resources/PageObjects/setupPage.robot

Test Setup    Start Test Case
Test Teardown    End Test Case

*** Variables ***
${username}  989193619468
${password}  111111

*** Test Cases ***
Login
    Login Valid  ${username}  ${password}
#API Set Address
#    Get Token
#    Get Final Token


*** Keywords ***