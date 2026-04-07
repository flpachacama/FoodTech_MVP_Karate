Feature: HU1-HU2 - Consulta de repartidores

Background:
  * url baseUrl
  * def schemas = callonce read('classpath:features/common/schemas.feature')

# TC-001 a TC-003 (cobertura de estados consultables)
Scenario: Listar repartidores
  Given path 'delivers'
  When method GET
  Then status 200
  And match response == '#[]'
  And match each response == schemas.RepartidorListItem
  And assert responseTime < 3000

# TC-004 (base para calculo de cercania: datos disponibles)
Scenario: Obtener repartidor por id existente
  Given path 'delivers', 1
  When method GET
  Then status 200
  And match response == schemas.RepartidorListItem
  And match response.id == 1

Scenario: Obtener repartidor inexistente retorna 404
  Given path 'delivers', 99999
  When method GET
  Then status 404
