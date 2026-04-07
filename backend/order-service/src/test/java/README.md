# Karate tests - order-service

Este modulo incluye pruebas funcionales con Karate DSL para `order-service`.

## Estructura
- `features/common`: base, schemas y smoke
- `features/auth`: stub de token reutilizable
- `features/users`: consultas de restaurantes
- `features/orders`: flujo de pedidos (crear/cancelar/entregar)
- `runners`: ejecutores JUnit5

## Ejecucion rapida (cmd.exe)
```bat
cd backend\order-service
mvn -Dtest=runners.KarateSmokeTest test
```

## Ejecucion funcional
Requiere `order-service` y `delivery-service` levantados.

```bat
cd backend\order-service
mvn -Dtest=runners.OrderApiRunner test
```

Puedes sobreescribir URL base:

```bat
mvn -Dtest=runners.OrderApiRunner -Dorder.baseUrl=http://localhost:8081 test
```
