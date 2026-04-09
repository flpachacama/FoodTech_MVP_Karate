function fn() {
  var env = karate.env || 'dev';
  var allEnvs = read('classpath:config/environments.json');
  var current = allEnvs[env];

  if (!current) {
    karate.fail('Unknown karate.env: ' + env + '. Valid values: dev, qa, prod');
  }

  var config = {
    env: env,
    orderBaseUrl: current.orderBaseUrl,
    deliveryBaseUrl: current.deliveryBaseUrl,
    // API-only scope: auth is not part of current backend MVP tests.
    authToken: '',
    commonHeaders: {
      'Content-Type': 'application/json',
      'Accept': 'application/json'
    },
    maxResponseTimeMs: current.maxResponseTimeMs || 2000
  };

  karate.configure('connectTimeout', 10000);
  karate.configure('readTimeout', 10000);
  karate.configure('ssl', true);

  return config;
}