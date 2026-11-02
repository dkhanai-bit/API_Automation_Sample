*** Settings ***
Documentation    API CRUD Test for Assessment Part B
Library          RequestsLibrary
Library          Collections
Library          DateTime

*** Variables ***
${BASE_URL}      https://petstore.swagger.io/v2

*** Test Cases ***
Verify Pet API CRUD Operations
    # 1. Connect to the API server
    Create Session    api_session    ${BASE_URL}

    # 2. CREATE: Generate a unique dynamic ID using current timestamp
    ${current_time}=     Get Current Date    result_format=epoch
    ${pet_id}=           Evaluate    int(${current_time})

    ${headers}=          Create Dictionary    Content-Type=application/json
    ${payload}=          Create Dictionary    id=${pet_id}    name=disha    company=TCS

    ${post_response}=    POST On Session    api_session    /pet    json=${payload}    headers=${headers}
    Should Be Equal As Integers    ${post_response.status_code}    200

    # 3. READ: Get the pet by ID and verify name & ID match
    ${get_response}=     GET On Session    api_session    /pet/${pet_id}
    Should Be Equal As Integers    ${get_response.status_code}    200

    ${response_data}=    Set Variable    ${get_response.json()}
    Should Be Equal As Integers    ${response_data}[id]      ${pet_id}
    Should Be Equal As Strings     ${response_data}[name]    disha

    # 4. UPDATE: Modify the pet's name using PUT
    ${update_payload}=    Create Dictionary    id=${pet_id}    name=disha_new    status=sold
    ${put_response}=      PUT On Session    api_session    /pet    json=${update_payload}    headers=${headers}
    Should Be Equal As Integers    ${put_response.status_code}    200

    # Verify the name changed successfully
    ${check_update}=     GET On Session    api_session    /pet/${pet_id}
    Should Be Equal As Strings    ${check_update.json()}[name]    disha_new

    # 5. DELETE: Delete the pet and confirm it returns 404 on a subsequent GET
    ${delete_response}=  DELETE On Session    api_session    /pet/${pet_id}
    Should Be Equal As Integers    ${delete_response.status_code}    200

    # Try to fetch the deleted pet (expecting 404 Not Found)
    ${final_get}=        GET On Session    api_session    /pet/${pet_id}    expected_status=404
    Should Be Equal As Integers    ${final_get.status_code}    404