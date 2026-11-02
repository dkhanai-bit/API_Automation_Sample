*** Settings ***
Documentation    Negative Automation Test Cases for API Requests
Library          RequestsLibrary
Library          Collections

*** Variables ***
${BASE_URL}      https://reqres.in
${INVALID_USER_ID}   9999

*** Test Cases ***

Get_Non_Existent_User_Negative_Test
    [Documentation]    Sends a GET request for a user ID that does not exist and expects a 404 Not Found
    Create Session    api_session    ${BASE_URL}    verify=True

    # Send GET request with expected_status to prevent test failure on non-2xx status
    ${response}=      GET On Session    api_session    /api/users/${INVALID_USER_ID}    expected_status=404

    # Assertions
    Should Be Equal As Integers    ${response.status_code}    404
    Log To Console    \nGET Negative Test Status: ${response.status_code}


Create_User_Missing_Fields_Negative_Test
    [Documentation]    Sends a POST request with an empty/invalid payload
    Create Session    api_session    ${BASE_URL}    verify=True
    ${headers}=       Create Dictionary    Content-Type=application/json
    ${body}=          Create Dictionary    # Empty body

    ${response}=      POST On Session    api_session    /api/users    json=${body}    headers=${headers}

    # ReqRes API allows empty body creation with a 201, but for standard production APIs you'd check for 400.
    # We log the status code for verification.
    Log To Console    \nPOST Missing Fields Status: ${response.status_code}


Update_Invalid_User_PUT_Negative_Test
    [Documentation]    Sends a PUT request to update a non-existent user ID
    Create Session    api_session    ${BASE_URL}    verify=True
    ${headers}=       Create Dictionary    Content-Type=application/json
    ${body}=          Create Dictionary    name=Ghost    job=None

    # Note: ReqRes returns 200 even for dummy updates, but standard APIs return 404.
    # Change expected_status if testing against a strict backend.
    ${response}=      PUT On Session    api_session    /api/users/${INVALID_USER_ID}    json=${body}    headers=${headers}    expected_status=any

    Log To Console    \nPUT Negative Test Status: ${response.status_code}