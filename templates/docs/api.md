# API Reference

<!-- Fill this in as endpoints are created. Each section should include:
     - Route and HTTP method
     - Auth requirements (none, Bearer JWT, token in query param, etc.)
     - Request body/params shape
     - Response shape (success + error)
     - Notable behavior (side effects, rate limits, idempotency) -->

## Public Endpoints (No Auth)

<!-- Example:
### `POST /register`
Creates a new user account.

**Request:**
```json
{ "publicKey": "base64...", "signingKey": "base64..." }
```

**Response (200):**
```json
{ "ok": true, "data": { "userId": "uuid" } }
```

**Response (409):**
```json
{ "ok": false, "error": "already registered" }
```
-->

## Protected Endpoints (Bearer JWT)

<!-- Endpoints that require `Authorization: Bearer <token>` header -->

## WebSocket Endpoints

<!-- WebSocket upgrade endpoints, token/auth requirements, message protocol -->

## Internal Routes

<!-- If using microservices, Durable Objects, or internal RPC — document the
     internal routing that isn't exposed to clients -->
