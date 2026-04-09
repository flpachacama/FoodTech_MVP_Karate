@orders @active-order
Feature: HU8 Active order lookup by repartidor

  Background:
    * url orderBaseUrl
    * def headersResult = call read('classpath:features/common/headers.feature') { token: '#(authToken)' }
    * configure headers = headersResult.headers
    * def schemas = call read('classpath:utils/schema-utils.js')

  Scenario: Query active order for assigned repartidor
    * def generated = call read('classpath:features/common/data-generator.feature')
    * def requestBody = read('classpath:features/orders/data/create-order-base.json')
    * set requestBody.clienteId = generated.clienteId
    * set requestBody.clienteNombre = generated.clienteNombre
    * set requestBody.clienteTelefono = generated.clienteTelefono

    Given path '/orders'
    And request requestBody
    When method post
    Then status 201
    * def createdOrder = response

    * if (createdOrder.repartidorId == null) karate.abort()

    Given path '/orders/repartidor', createdOrder.repartidorId
    When method get
    Then status 200
    And match response == schemas.orderResponse
    And match response.repartidorId == createdOrder.repartidorId

  Scenario: Query active order for repartidor without active order
    Given path '/orders/repartidor', 999999
    When method get
    Then status 404
    And match response.status == 404
    And match response.error == 'Pedido no encontrado'
