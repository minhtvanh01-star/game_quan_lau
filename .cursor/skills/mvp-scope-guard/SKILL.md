---
name: mvp-scope-guard
description: >-
  Guards Hot Pot Story MVP scope against P1/P2 feature creep. Use when planning
  features, reviewing PRs, expanding GDD, or when the user asks for buffet,
  chi nhánh, multiplayer, DLC, photoreal, or full AI chat.
---

# MVP Scope Guard

## Instructions

1. Đọc `docs/03-bao-cao-thiet-ke-hoan-thien.md` và `docs/01` mục P0/P1/P2.
2. Phân loại yêu cầu: **P0 / P1 / P2 / ngoài tài liệu**.
3. Output theo mẫu:

```markdown
## Scope verdict
- Classification: P0 | P1 | P2 | Out-of-doc
- Allow implement now: yes/no
- Slim P0 alternative: ...
- Risks if forced: ...
```

4. Chỉ implement khi P0, hoặc P1 đã được user xác nhận sau core ổn, hoặc P2 có change request tường minh.
5. Không viết code P2 / buffet “cho sẵn” trong MVP.

## Quick P0 checklist

- [ ] 1 tiệm để lại, ≤8 bàn
- [ ] Chỉ gọi món (không buffet)
- [ ] Vay nợ + clear Ch.1 (hết nợ + `V_clear` + quest nâng cấp) → Ch.2 hook
- [ ] Cảm xúc số; AI C2 chỉ P1 theo event
