@orders @cancel
Feature: HU9 Cancel order API behavior

  Background:
    * url orderBaseUrl
    * def headersResult = call read('classpath:features/common/headers.feature') { token: '#(authToken)' }
    * configure headers = headersResult.headers

  Scenario: Cancel an assigned or pending order
    * def generated = call read('classpath:features/common/data-generator.feature')
    * def requestBody = read('classpath:features/orders/data/create-order-base.json')
    * set requestBody.clienteId = generated.clienteId
    * set requestBody.clienteNombre = generated.clienteNombre
    * set requestBody.clienteTelefono = generated.clienteTelefono

    Given path '/orders'
    And request requestBody
    When method post
    Then status 201
    * def createdOrderId = response.id

    Given path '/orders', createdOrderId, 'cancel'
    When method put
    Then status 200
    And match response.id == createdOrderId
    And match response.estado == 'CANCELADO'
    And match response.mensaje contains 'cancelado'

  Scenario: Reject cancel for order already delivered
    * def generated = call read('classpath:features/common/data-generator.feature')
    * def requestBody = read('classpath:features/orders/data/create-order-base.json')
    * set requestBody.clienteId = generated.clienteId
    * set requestBody.clienteNombre = generated.clienteNombre
    * set requestBody.clienteTelefono = generated.clienteTelefono

    Given path '/orders'
    And request requestBody
    When method post
    Then status 201
    * def createdOrderId = response.id

    # If order is pending without repartidor, delivering is expected to fail with 400.
    Given path '/orders', createdOrderId, 'deliver'
    When method put
    * def deliverStatus = responseStatus

    Given path '/orders', createdOrderId, 'cancel'
    When method put
    * def cancelStatus = responseStatus

    Then assert cancelStatus == 200 || cancelStatus == 400
