function fn() {
  var config = {
    baseUrl: karate.properties['delivery.baseUrl'] || 'http://localhost:8080',
    timeoutMs: 10000
  };

  karate.configure('connectTimeout', config.timeoutMs);
  karate.configure('readTimeout', config.timeoutMs);
  return config;
}
