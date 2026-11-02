*** Settings ***
Documentation    Automation for API GET and POST Requests
Library          RequestsLibrary
Library          Collections

*** Variables ***
${BASE_URL}      https://reqres.in
${USER_ID}       2

*** Test Cases ***
Get_User_Details_GET_Request
    [Documentation]    Sends a GET request to retrieve user details and verifies the response

    # 1. Create session using live base URL
    Create Session    api_session    ${BASE_URL}    verify=True

    # 2. Send GET request (No body or content-type header required)
    ${response}=      GET On Session    api_session    /api/users/${USER_ID}

    # 3. Assertions (200 OK expected for successful GET request)
    Should Be Equal As Integers    ${response.status_code}    200

    # 4. Print response details to PyCharm console
    ${json_data}=     Set Variable    ${response.json()}
    #Log To Console    \nStatus Code: ${response.status_code}
    #Log To Console    Response Body: ${json_data}
    #Log To Console    Fetched User Name: ${json_data}[data][first_name]
    #Log To Console    ${response.headers}

    #validation
    ${body}=    Set Variable     ${response.content}
    #Log to Console    ${response.content}
    Should Contain    ${body}    Janet

    #validating Headers
    ${content_type_value}=    get from dictionary    ${response.headers}    content-Type
    should contain    ${content_type_value}    application/json
    Log To Console    ${content_type_value}



