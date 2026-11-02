*** Settings ***
*** Keywords ***

Add two Numbers
    [Arguments]    ${a}    ${b}
    ${result}=    Evaluate    ${a}+${b}
    RETURN     ${result}

Verify Result
    [Arguments]    ${expected}    ${actual}
    Should Be Equal As Integers    ${expected}    ${actual}
 
*** Test Cases ***
verify Addition
    ${result}    Add Two Numbers    10    20
    Verify Result    30    ${result}
    Log to Console    Result: ${result}


