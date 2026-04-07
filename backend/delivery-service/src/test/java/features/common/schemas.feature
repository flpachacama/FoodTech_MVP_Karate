Feature: Esquemas JSON para Delivery API

Scenario:
  * def AssignmentResponse =
  """
  {
    pedidoId: '#number',
    estado: '#string',
    repartidorId: '##number',
    nombreRepartidor: '##string',
    tiempoEstimado: '##number'
  }
  """

  * def RepartidorListItem =
  """
  {
    id: '#number',
    nombre: '#string',
    estado: '#string',
    vehiculo: '#string',
    ubicacionX: '#number',
    ubicacionY: '#number'
  }
  """

  * def RepartidorStateResponse =
  """
  {
    id: '#number',
    nombre: '#string',
    estado: '#string',
    vehiculo: '#string',
    x: '#number',
    y: '#number'
  }
  """
