Feature: Esquemas JSON para Order API

Scenario:
  * def ErrorResponse =
  """
  {
    timestamp: '#string',
    status: '#number',
    error: '#string',
    detail: '#string'
  }
  """

  * def ProductoPedido =
  """
  {
    id: '#number',
    nombre: '#string',
    precio: '#number'
  }
  """

  * def OrderResponse =
  """
  {
    id: '#number',
    restauranteId: '#number',
    repartidorId: '##number',
    productos: '#[]',
    clienteId: '#number',
    clienteNombre: '#string',
    clienteCoordenadasX: '#number',
    clienteCoordenadasY: '#number',
    clienteTelefono: '#string',
    tiempoEstimado: '##number',
    estado: '#string'
  }
  """

  * def CancelOrDeliverResponse =
  """
  {
    id: '#number',
    estado: '#string',
    mensaje: '#string'
  }
  """

  * def RestauranteResponse =
  """
  {
    id: '#number',
    nombre: '#string',
    coordenadaX: '#number',
    coordenadaY: '#number',
    menu: '#[]'
  }
  """
