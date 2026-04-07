Feature: HU1-HU6 - Asignacion y actualizacion de estado en delivery

Background:
  * call read('classpath:features/common/base.feature')
  * def schemas = callonce read('classpath:features/common/schemas.feature')
  * def auth = callonce read('classpath:features/auth/getToken.feature')

# TC-013 y HU5
Scenario: Asignacion automatica con candidatos validos
  Given path 'delivery'
  And request { pedidoId: 9001, restauranteX: 10, restauranteY: 20, clima: 'SOLEADO' }
  When method POST
  Then status 200
  And match response == schemas.AssignmentResponse
  And match response.estado == '#regex ^(ASIGNADO|PENDIENTE)$'
  And assert responseTime < 3000

# TC-016 y HU3
Scenario: Lluvia fuerte restringe vehiculos y puede dejar pedido pendiente
  Given path 'delivery'
  And request { pedidoId: 9002, restauranteX: 10, restauranteY: 20, clima: 'LLUVIA_FUERTE' }
  When method POST
  Then status 200
  And match response == schemas.AssignmentResponse
  And match response.estado == '#regex ^(ASIGNADO|PENDIENTE)$'

# TC-009
Scenario: Clima invalido retorna error de validacion
  Given path 'delivery'
  And request { pedidoId: 9003, restauranteX: 10, restauranteY: 20, clima: 'TORMENTA_EXTREMA' }
  When method POST
  Then status 400
  And match response.error == '#regex (?i).*clima.*inval.*'

# TC-018
Scenario: Actualizar estado del repartidor por evento ENTREGADO
  Given path 'delivery', 1, 'state'
  And request { evento: 'ENTREGADO' }
  When method PUT
  Then status 200
  And match response == schemas.RepartidorStateResponse
  And match response.estado == 'ACTIVO'

# Edge case: evento no soportado
Scenario: Rechazar evento no valido en update de estado
  Given path 'delivery', 1, 'state'
  And request { evento: 'EN_CAMINO' }
  When method PUT
  Then status 400
  And match response.error == '#regex (?i).*evento.*inval.*'
