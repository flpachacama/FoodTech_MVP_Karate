function randomClient() {
  var id = java.lang.System.currentTimeMillis();
  return {
    id: id,
    name: 'Cliente-Karate-' + id,
    phone: '300000' + (id % 10000)
  };
}
