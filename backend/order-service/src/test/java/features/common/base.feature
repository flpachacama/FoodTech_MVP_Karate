Feature: Configuracion comun para Order API

Scenario:
  * url baseUrl
  * def dataGen = read('classpath:utils/data-generator.js')
  * def randomClient = dataGen.randomClient
  * def defaultProduct = { id: 1, nombre: 'Hamburguesa Clasica', precio: 18000 }
