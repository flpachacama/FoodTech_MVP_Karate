Feature: HU10 - Consulta de restaurantes y menu

Background:
  * url baseUrl
  * def schemas = callonce read('classpath:features/common/schemas.feature')
  * def auth = callonce read('classpath:features/auth/getToken.feature')

Scenario: Listar restaurantes registrados
  Given path 'restaurants'
  When method GET
  Then status 200
  And match response == '#[]'
  And match each response == schemas.RestauranteResponse
  And assert responseTime < 3000

Scenario: Consultar restaurante inexistente retorna 404
  Given path 'restaurants', 99999
  When method GET
  Then status 404
  And match response == schemas.ErrorResponse

Scenario: Obtener menu de restaurante por id
  Given path 'restaurants', 1
  When method GET
  Then status 200
  And match response == schemas.RestauranteResponse
  And match response.id == 1
  And match response.menu[0] contains { id: '#number', nombre: '#string', precio: '#number' }
