Feature: Common request headers builder

  Scenario: Build common headers for backend API tests
    * def headers = { 'Content-Type': 'application/json', 'Accept': 'application/json' }
    * def result = { headers: headers }