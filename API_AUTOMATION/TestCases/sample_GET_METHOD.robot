*** Settings ***
Library    RequestsLibrary
Library    Collections

*** Variables ***
${BASE_URL}    https://petstore.swagger.io/v2
${PET_ID}      998877    # A unique ID for our test pet

*** Test Cases ***
Get Pet Details Successfully
    [Documentation]    We create a pet first so it always exists, then we fetch it with GET.

    # Step 1: Open a connection to the API server
    Create Session    my_pet_session    ${BASE_URL}

    # Step 2: Prepare the details (data) for our new pet
    ${headers}=    Create Dictionary    Content-Type=application/json
    ${pet_data}=   Create Dictionary    id=${PET_ID}    name=deesha    status=available

    # Step 3: Send a POST request to create the pet (prevents 404 errors)
    ${create_response}=    POST On Session    my_pet_session    /pet    json=${pet_data}    headers=${headers}
    Should Be Equal As Integers    ${create_response.status_code}    200

    # Step 4: Send a GET request to retrieve the pet we just created
    ${get_response}=    GET On Session    my_pet_session    /pet/${PET_ID}

    # Step 5: Check that the server responded successfully (Status 200)
    Should Be Equal As Integers    ${get_response.status_code}    200

    # Step 6: Verify that the returned pet ID matches our expected ID
    ${response_json}=    Set Variable           ${get_response.json()}
    ${fetched_id}=       Get From Dictionary    ${response_json}    id
    Should Be Equal As Integers    ${fetched_id}        ${PET_ID}
    Log To Console    Successfully fetched pet with ID: ${fetched_id}