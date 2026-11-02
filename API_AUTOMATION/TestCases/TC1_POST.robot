#*** Settings ***
#Library            RequestLibrary

#*** Variables ***
#{base_url}    http://restapi.demoqa.com
#{city}        Delhi

#*** Test Cases ***
#Get_weather_info
    #create     session     myssion       ${base_url}
    #${response}    get request   myssion    /utilities/weather/city/${city}
    #log to console    ${response.status_code}
    #${response}
#*** Settings ***
#Library          RequestsLibrary

#*** Variables ***
#${base_url}      http://restapi.demoqa.com
#${city}          Delhi

#*** Test Cases ***
#Get_weather_info
    #Create Session    mysession    ${base_url}
    #${response}=      GET On Session    mysession    /utilities/weather/city/${city}
    #Log To Console    ${response.status_code}
    #Log To Console    ${response.json()}

*** Settings ***
Documentation    Automation for API POST Request
Library          RequestsLibrary
Library          Collections

*** Variables ***
${BASE_URL}      https://reqres.in

*** Test Cases ***
Create_New_User_POST_Request
    [Documentation]    Sends a POST request to create a user and verifies the response

    # 1. Create session using live base URL
    Create Session    api_session    ${BASE_URL}    verify=True

    # 2. Set up Headers and Request Body
    ${headers}=       Create Dictionary    Content-Type=application/json
    ${body}=          Create Dictionary    name=Disha    job=QA Engineer

    # 3. Send POST request
    ${response}=      POST On Session    api_session    /api/users    json=${body}    headers=${headers}

    # 4. Assertions
    Should Be Equal As Integers    ${response.status_code}    201

    # Print response to PyCharm console
    ${json_data}=     Set Variable    ${response.json()}
    Log To Console    \nStatus Code: ${response.status_code}
    Log To Console    Response Body: ${json_data}



    
