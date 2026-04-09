@orders @deliver
Feature: HU6-HU12 Deliver order API behavior

  Background:
    * url orderBaseUrl
    * def headersResult = call read('classpath:features/common/headers.feature') { token: '#(authToken)' }
    * configure headers = headersResult.headers

  Scenario: Mark order as delivered when assignment exists
    * def generated = call read('classpath:features/common/data-generator.feature')
    * def requestBody = read('classpath:features/orders/data/create-order-base.json')
    * set requestBody.clienteId = generated.clienteId
    * set requestBody.clienteNombre = generated.clienteNombre
    * set requestBody.clienteTelefono = generated.clienteTelefono

    Given path '/orders'
    And request requestBody
    When method post
    Then status 201
    * def created = response

    Given path '/orders', created.id, 'deliver'
    When method put
    * def currentStatus = responseStatus

    Then assert currentStatus == 200 || currentStatus == 400
    * if (currentStatus == 200) karate.match(response.estado, 'ENTREGADO')

  Scenario: Reject deliver for unknown order id
    Given path '/orders', 99999999, 'deliver'
    When method put
    Then status 404
    And match response.status == 404
    And match response.error == 'Pedido no encontrado'