Feature: HU1-HU6 - Asignacion y actualizacion de estado en delivery

Background:
  * url baseUrl
  * def schemas = callonce read('classpath:features/common/schemas.feature')
  * def auth = callonce read('classpath:features/auth/getToken.feature')

Scenario: Asignacion automatica con candidatos validos
  Given path 'delivery'
  And request { pedidoId: 9001, restauranteX: 10, restauranteY: 20, clima: 'SOLEADO' }
  When method POST
  Then status 200
  And match response == schemas.AssignmentResponse
  And match response.estado == '#regex ^(ASIGNADO|PENDIENTE)$'
  And assert responseTime < 3000

Scenario: Lluvia fuerte restringe vehiculos y puede dejar pedido pendiente
  Given path 'delivery'
  And request { pedidoId: 9002, restauranteX: 10, restauranteY: 20, clima: 'LLUVIA_FUERTE' }
  When method POST
  Then status 200
  And match response == schemas.AssignmentResponse
  And match response.estado == '#regex ^(ASIGNADO|PENDIENTE)$'

Scenario: Clima invalido retorna error de validacion
  Given path 'delivery'
  And request { pedidoId: 9003, restauranteX: 10, restauranteY: 20, clima: 'TORMENTA_EXTREMA' }
  When method POST
  Then status 400
  And match response.error == '#regex (?i).*clima.*inv[aá]l[ií]d.*'

Scenario: Actualizar estado del repartidor por evento ENTREGADO
  Given path 'delivery', 1, 'state'
  And request { evento: 'ENTREGADO' }
  When method PUT
  Then status 200
  And match response == schemas.RepartidorStateResponse
  And match response.estado == 'ACTIVO'

Scenario: Rechazar evento no valido en update de estado
  Given path 'delivery', 1, 'state'
  And request { evento: 'EN_CAMINO' }
  When method PUT
  Then status 400
  And match response.error == '#regex (?i).*evento.*inv[aá]l[ií]d.*'
