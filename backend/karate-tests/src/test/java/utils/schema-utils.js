function fn() {
  return {
    orderResponse: {
      id: '#number',
      restauranteId: '#number',
      repartidorId: '##number',
      productos: '#[]',
      clienteId: '##number',
      clienteNombre: '#string',
      clienteCoordenadasX: '#number',
      clienteCoordenadasY: '#number',
      clienteTelefono: '##string',
      tiempoEstimado: '##number',
      estado: '#string'
    },
    assignResponse: {
      pedidoId: '#number',
      estado: '#string',
      repartidorId: '##number',
      nombreRepartidor: '##string',
      tiempoEstimado: '##number'
    },
    restauranteResponse: {
      id: '#number',
      nombre: '#string',
      coordenadaX: '#number',
      coordenadaY: '#number',
      menu: '#[]'
    },
    repartidorResponse: {
      id: '#number',
      nombre: '#string',
      estado: '#string',
      vehiculo: '#string'
    }
  };
}
