Feature: Configuracion comun para Order API

Scenario:
  * def randomClient =
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
  * def defaultProduct = { id: 1, nombre: 'Hamburguesa Clasica', precio: 18000 }
