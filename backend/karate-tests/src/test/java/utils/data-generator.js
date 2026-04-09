function fn() {
  var now = new Date().getTime();
  var randomSuffix = '' + now;

  return {
    clienteId: now,
    clienteNombre: 'Cliente Karate ' + randomSuffix,
    clienteTelefono: '3' + randomSuffix.slice(-9),
    pedidoId: now,
    randomText: 'karate-' + randomSuffix
  };
}
