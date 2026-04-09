@orders @create
Feature: HU7-HU8 Create order API contract and business rules

  Background:
    * url orderBaseUrl
    * def headersResult = call read('classpath:features/common/headers.feature') { token: '#(authToken)' }
    * configure headers = headersResult.headers
    * def schemas = call read('classpath:utils/schema-utils.js')

  Scenario Outline: Create order successfully with climate variations
    * def generated = call read('classpath:features/common/data-generator.feature')
    * def requestBody = read('classpath:features/orders/data/create-order-base.json')
    * set requestBody.clienteId = generated.clienteId
    * set requestBody.clienteNombre = generated.clienteNombre
    * set requestBody.clienteTelefono = generated.clienteTelefono
    * set requestBody.clima = '<clima>'

    Given path '/orders'
    And request requestBody
    When method post
    Then status 201
    And match response == schemas.orderResponse
    And match response.estado == '#regex (ASIGNADO|PENDIENTE)'
    And assert responseTime < maxResponseTimeMs

    Examples:
      | clima          |
      | SOLEADO        |
      | LLUVIA_SUAVE   |
      | LLUVIA_FUERTE  |

  Scenario: Reject create order when restaurant does not exist
    * def requestBody = read('classpath:features/orders/data/create-order-base.json')
    * set requestBody.restauranteId = 99999

    Given path '/orders'
    And request requestBody
    When method post
    Then status 404
    And match response.status == 404
    And match response.error == 'Restaurante no encontrado'
    And match response.detail contains '99999'

  Scenario: Reject create order when products are empty
    * def requestBody = read('classpath:features/orders/data/create-order-empty-products.json')

    Given path '/orders'
    And request requestBody
    When method post
    Then status 400
    And match response.status == 400
    And match response.error == 'Datos inválidos'
    And match response.detail contains 'al menos un producto'
