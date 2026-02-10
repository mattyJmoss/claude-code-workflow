# Reference Docs Layer

This directory holds heavyweight, rarely-changing reference material for the project. It complements the memory bank — which stays concise as working memory — by providing a durable place for API specs, data schemas, and development procedures.

## Dual-Layer System

| Layer | Purpose | Update Frequency |
|-------|---------|-----------------|
| **Memory bank** (`.kilocode/rules/memory-bank/`) | Working memory — current status, decisions, task list | Every session |
| **Reference docs** (`docs/`) | Permanent reference — API specs, schemas, dev procedures | When APIs or schemas change |

**Key rule:** Memory bank files should **reference** docs/ but never duplicate large sections inline. Keep the memory bank scannable; put the detail here.

## Suggested Files

| File | Contents |
|------|----------|
| `api.md` | API endpoint reference — routes, methods, auth, request/response shapes |
| `schema.md` | Data models, storage layout, key patterns, relationships |
| `development.md` | Local dev setup, testing procedures, troubleshooting |
| `specs/` | Implementation specs and plans for larger features |

## When to Update

- **After creating or changing API endpoints** — update `api.md`
- **After changing data models or storage keys** — update `schema.md`
- **After changing dev setup or adding new testing procedures** — update `development.md`
- **Before starting a large feature** — save the approved plan to `specs/`
