---
name: ai-customer-event
description: >-
  Designs customer AI events at C0/C1/C2 tiers with whitelist actions, context
  builder, and validator contracts. Use when adding dialogue, complaints,
  VIP events, customer memory, or LLM integration.
---

# AI Customer Event

## Instructions

1. Chọn cấp: C0 (BT/FSM) / C1 (template) / C2 (LLM backend).
2. Nếu C2: liệt kê context gửi lên (order state, wait time, menu, personality).
3. `suggested_actions` ⊆ whitelist gameplay hiện có.
4. Định nghĩa fallback C1 khi LLM timeout/invalid.
5. Không đề xuất gọi LLM cho C0.

## Event spec template

```markdown
## Event
- id:
- trigger:
- tier: C0|C1|C2
- context fields:
- whitelist actions:
- emotion deltas:
- fallback:
```

## Reference

- `.cursor/rules/ai-customer-safety.mdc`
- `docs/01-nghien-cuu-kha-thi-game-quan-lau.md` §4.3
