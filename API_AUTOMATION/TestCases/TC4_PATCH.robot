*** Settings ***
Documentation    Automation for API GET and POST Requests
Library          RequestsLibrary
Library          Collections

*** Variables ***
${BASE_URL}      https://reqres.in
${USER_ID}       2

*** Test Cases ***

Partially_Update_User_Details_PATCH_Request
    [Documentation]    Sends a PATCH request to perform a partial update on a user resource
    Create Session    api_session    ${BASE_URL}    verify=True
    ${headers}=       Create Dictionary    Content-Type=application/json

    # PATCH sends only the specific field(s) being updated
    ${body}=          Create Dictionary    job=Senior Automation Engineer

    # 1. Send PATCH request
    ${response}=      PATCH On Session    api_session    /api/users/${USER_ID}    json=${body}    headers=${headers}

    # 2. Assertions (200 OK expected for successful partial update)
    Should Be Equal As Integers    ${response.status_code}    200

    # 3. Validations
    ${json_data}=     Set Variable    ${response.json()}
    Should Be Equal   ${json_data}[job]    Senior Automation Engineer

    # Print to console
    Log To Console    \nPATCH Status: ${response.status_code}
    Log To Console    PATCH Response: ${json_data}
