Feature: Shared test data generator

  Scenario: Generate unique customer payload fragments
    * def generated = call read('classpath:utils/data-generator.js')
    * def clienteId = generated.clienteId
    * def clienteNombre = generated.clienteNombre
    * def clienteTelefono = generated.clienteTelefono
    * def pedidoId = generated.pedidoId
    * def randomText = generated.randomText
