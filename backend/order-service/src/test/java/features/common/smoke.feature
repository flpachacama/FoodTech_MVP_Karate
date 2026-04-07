Feature: Smoke de configuracion Karate

Scenario: Cargar configuracion base sin errores
  * call read('classpath:features/common/base.feature')
  * match baseUrl == '#string'
  * match timeoutMs == '#number'
