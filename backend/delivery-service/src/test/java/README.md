# Karate tests - delivery-service

Este modulo incluye pruebas funcionales con Karate DSL para `delivery-service`.

## Estructura
- `features/common`: base, schemas y smoke
- `features/auth`: stub de token reutilizable
- `features/users`: consultas de repartidores
- `features/orders`: asignacion y cambios de estado
- `runners`: ejecutores JUnit5

## Ejecucion rapida (cmd.exe)
```bat
cd backend\delivery-service
mvn -Dtest=runners.KarateSmokeTest test
```

## Ejecucion funcional
Requiere servicio levantado y base de datos accesible.

```bat
cd backend\delivery-service
mvn -Dtest=runners.DeliveryApiRunner test
```

Puedes sobreescribir URL base:

```bat
mvn -Dtest=runners.DeliveryApiRunner -Ddelivery.baseUrl=http://localhost:8080 test
```
