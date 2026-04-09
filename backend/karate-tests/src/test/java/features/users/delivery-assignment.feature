@users @assignment
Feature: HU4-HU5 Delivery assignment API contract and business rules

  Background:
    * url deliveryBaseUrl
    * def headersResult = call read('classpath:features/common/headers.feature') { token: '#(authToken)' }
    * configure headers = headersResult.headers
    * def schemas = call read('classpath:utils/schema-utils.js')

  Scenario Outline: Assign repartidor by clima
    * def generated = call read('classpath:features/common/data-generator.feature')
    * def payload = read('classpath:features/users/data/assign-delivery-base.json')
    * set payload.pedidoId = generated.pedidoId
    * set payload.clima = '<clima>'

    Given path '/delivery'
    And request payload
    When method post
    Then status 200
    And match response == schemas.assignResponse
    And match response.estado == '#regex (ASIGNADO|PENDIENTE)'
    And assert responseTime < maxResponseTimeMs

    Examples:
      | clima          |
      | SOLEADO        |
      | LLUVIA_SUAVE   |
      | LLUVIA_FUERTE  |

  Scenario: Reject assignment with invalid clima
    * def payload = read('classpath:features/users/data/assign-delivery-base.json')
    * set payload.clima = 'TORMENTA_EXTREMA'

    Given path '/delivery'
    And request payload
    When method post
    Then status 400
    And match response.error contains 'Clima inválido'

  Scenario: Reject assignment with invalid coordinate data type
    Given path '/delivery'
    And request { pedidoId: 10, restauranteX: 'x', restauranteY: 4.6, clima: 'SOLEADO' }
    When method post
    Then status 400
    And match response.error contains 'Se esperaba un número'
