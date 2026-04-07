Feature: Smoke de configuracion Karate delivery

Scenario: Cargar baseUrl
  * call read('classpath:features/common/base.feature')
  * match baseUrl == '#string'
