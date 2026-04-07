function fn() {
  var config = {
    baseUrl: karate.properties['order.baseUrl'] || 'http://localhost:8081',
    timeoutMs: 10000
  };

  karate.configure('connectTimeout', config.timeoutMs);
  karate.configure('readTimeout', config.timeoutMs);
  return config;
}
