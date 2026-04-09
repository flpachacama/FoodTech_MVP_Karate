@products
Feature: HU10 Restaurants API contract and behavior

  Background:
    * url orderBaseUrl
    * def headersResult = call read('classpath:features/common/headers.feature') { token: '#(authToken)' }
    * configure headers = headersResult.headers
    * def schemas = call read('classpath:utils/schema-utils.js')

  Scenario: Get all restaurants
    Given path '/restaurants'
    When method get
    Then status 200
    And match response == '#[]'
    And match each response == schemas.restauranteResponse
    And assert response.length > 0
    And assert responseTime < maxResponseTimeMs

  Scenario: Get restaurant by id
    Given path '/restaurants', 1
    When method get
    Then status 200
    And match response == schemas.restauranteResponse
    And match response.id == 1
    And match response.menu == '#[]'

  Scenario: Restaurant not found by id
    Given path '/restaurants', 999999
    When method get
    Then status 404
