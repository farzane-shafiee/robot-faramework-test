*** Settings ***
Documentation    Test Amazing and simple product
Library    SeleniumLibrary

*** Keywords ***
Start Test Case
    Open Browser  https://demo.digikalajet.com/user/address  chrome
    Maximize Browser Window
    Set Selenium Implicit Wait    10
    Set Selenium Speed    0.2

End Test Case
    Close Browser