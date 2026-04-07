Feature: HU7-HU9 - Gestion de pedidos

Background:
  * url baseUrl
  * def schemas = callonce read('classpath:features/common/schemas.feature')
  * def auth = callonce read('classpath:features/auth/getToken.feature')
  * def defaultProduct = { id: 1, nombre: 'Hamburguesa Clasica', precio: 18000 }
  * def createClient =
  """
  function() {
    var id = java.lang.System.currentTimeMillis();
    return {
      id: id,
      name: 'Cliente-Karate-' + id,
      phone: '300000' + (id % 10000)
    };
  }
  """
  * def client = createClient()
  * def createOrderPayload =
  """
  function (overrides) {
    var payload = {
      restauranteId: 1,
      restauranteX: 10,
      restauranteY: 20,
      clima: 'SOLEADO',
      productos: [defaultProduct],
      clienteId: client.id,
      clienteNombre: client.name,
      clienteCoordenadasX: 13,
      clienteCoordenadasY: 22,
      clienteTelefono: client.phone
    };
    if (overrides) {
      for (var key in overrides) {
        payload[key] = overrides[key];
      }
    }
    return payload;
  }
  """

# TC-024
Scenario: Crear pedido correctamente
  Given path 'orders'
  And request createOrderPayload({})
  When method POST
  Then status 201
  And match response == schemas.OrderResponse
  And match each response.productos == schemas.ProductoPedido
  And match response.estado == '#regex ^(ASIGNADO|PENDIENTE)$'
  And assert responseTime < 4000

# TC-026
Scenario: Error al confirmar pedido sin telefono
  Given path 'orders'
  And request createOrderPayload({ clienteTelefono: '' })
  When method POST
  Then status 400
  And match response == schemas.ErrorResponse
  And match response.detail == '#regex (?i).*tel[eé]f[oó]n.*'

# TC-028
Scenario: Cancelar pedido activo
  Given path 'orders'
  And request createOrderPayload({})
  When method POST
  Then status 201
  * def orderId = response.id

  Given path 'orders', orderId, 'cancel'
  When method PUT
  Then status 200
  And match response == schemas.CancelOrDeliverResponse
  And match response.estado == 'CANCELADO'

# TC-030
Scenario: Cancelar pedido ya entregado debe fallar
  Given path 'orders'
  And request createOrderPayload({})
  When method POST
  Then status 201
  And match response.estado == 'ASIGNADO'
  * def orderId = response.id

  Given path 'orders', orderId, 'deliver'
  When method PUT
  Then status 200

  Given path 'orders', orderId, 'cancel'
  When method PUT
  Then status 400
  And match response == schemas.ErrorResponse

# TC-027 (adaptado a contrato backend: restaurante invalido)
Scenario: Error cuando se confirma con restaurante inexistente
  Given path 'orders'
  And request createOrderPayload({ restauranteId: 99999 })
  When method POST
  Then status 404
  And match response == schemas.ErrorResponse
