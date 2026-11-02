*** Settings ***
Documentation    Automation for Basic Authentication Requests
Library          RequestsLibrary
Library          Collections

*** Variables ***
${BASE_URL}      https://postman-echo.com
${USERNAME}      postman
${PASSWORD}      password

*** Test Cases ***
BasicAuthTest
    ${auth}=    create list    ${USERNAME}    ${PASSWORD}
    create session     myssion    ${BASE_URL}    auth=${auth}
    ${response}=    get request    myssion    /basic-auth
    Log To Console    ${response.content}
    Should be equal as strings    ${response.status_code}    200


