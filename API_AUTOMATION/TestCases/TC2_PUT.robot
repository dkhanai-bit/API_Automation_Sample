*** Settings ***
Documentation    Automation for API GET and POST Requests
Library          RequestsLibrary
Library          Collections

*** Variables ***
${BASE_URL}      https://reqres.in
${USER_ID}       2

*** Test Cases ***
Update_User_Details_PUT_Request
    [Documentation]    Sends a PUT request to completely replace/update an existing user resource
    Create Session    api_session    ${BASE_URL}    verify=True
    ${headers}=       Create Dictionary    Content-Type=application/json

    # PUT replaces full representation (sending complete updated body)
    ${body}=          Create Dictionary    name=Madhu    job=Test Engineer

    # 1. Send PUT request
    ${response}=      PUT On Session    api_session    /api/users/${USER_ID}    json=${body}    headers=${headers}

    # 2. Assertions (200 OK expected for successful update)
    Should Be Equal As Integers    ${response.status_code}    200

    # 3. Validations
    ${json_data}=     Set Variable    ${response.json()}
    Should Be Equal   ${json_data}[name]    Madhu
    Should Be Equal   ${json_data}[job]     Test Engineer
    Log To Console    ${body}

    # Header Validation
    ${content_type_value}=    Get From Dictionary    ${response.headers}    Content-Type
    Should Contain            ${content_type_value}    application/json

    # Print to console
    Log To Console    \nPUT Status: ${response.status_code}
    Log To Console    PUT Response: ${json_data}
