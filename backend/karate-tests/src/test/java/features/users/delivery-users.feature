@users
Feature: HU1-HU3 Delivery users (repartidores) listing and state transitions

  Background:
    * url deliveryBaseUrl
    * def headersResult = call read('classpath:features/common/headers.feature') { token: '#(authToken)' }
    * configure headers = headersResult.headers
    * def schemas = call read('classpath:utils/schema-utils.js')

  Scenario: Get all repartidores using alias endpoint
    Given path '/delivery/fooders'
    When method get
    Then status 200
    And match response == '#[]'
    And match each response contains schemas.repartidorResponse
    And assert response.length > 0

  Scenario: Get all repartidores using delivers endpoint
    Given path '/delivers'
    When method get
    Then status 200
    And match response == '#[]'
    And match each response contains schemas.repartidorResponse

  Scenario: Get repartidor by id from delivers endpoint
    Given path '/delivers', 1
    When method get
    Then status 200
    And match response contains schemas.repartidorResponse
    And match response.id == 1

  Scenario: Update repartidor state with ENTREGADO event
    Given path '/delivery', 1, 'state'
    And request { evento: 'ENTREGADO' }
    When method put
    Then status 200
    And match response.estado == 'ACTIVO'

  Scenario: Reject invalid state event
    Given path '/delivery', 1, 'state'
    And request { evento: 'EVENTO_INVALIDO' }
    When method put
    Then status 400
    And match response.error contains 'inválido'
