---
name: serving-order-pipeline
description: >-
  Specs à la carte order pipeline, kitchen capacity, and inventory stockout for
  Hot Pot Story MVP. Use when implementing or changing orders, kitchen, or stock
  depletion. Buffet only when CR unlocks post-Ch.1 / Ch.2 content.
---

# Serving Order Pipeline

## Scope gate

MVP = **chỉ gọi món**. Buffet counter/ticket **không** implement trừ CR (sau Ch.1 hoặc lựa chọn quest danh tiếng).

## Instructions

1. Order states (MVP) — ưu tiên khớp `docs/03`:

```text
NEW → CHECKING_STOCK → ACCEPTED → PREPARING → READY → DELIVERING → SERVED → COMPLETED
         ↘ Cancelled / Failed (stockout)
```

2. Hết nguyên liệu → fail có thông báo; không “nuốt” order im lặng.
3. Bếp: queue + công suất; rush tăng wait → giảm kiên nhẫn khách.
4. Một đơn một người phụ trách tại một thời điểm.
5. Mọi thay đổi state/công thức → unit/edit-mode test.
6. Khi (và chỉ khi) có CR buffet: tách vé vs COGS; không gộp với à la carte.

## Checklist

- [ ] State machine rõ; không nhảy state lạ
- [ ] Stock deduct đúng lúc (chốt 1 chỗ)
- [ ] Không có path buffet trong build MVP
- [ ] Staff/player cùng pipeline
- [ ] Báo cáo ngày ghi nhận fail/stockout

## Output template

```markdown
## Pipeline change
- Path: alacarte | kitchen | inventory (| buffet only if CR)
- States / hooks:
- Stock timing:
- Rush behavior:
- Tests:
```

## Reference

- `docs/03` §7
- Skill: `buffet-economy-balance` (chỉ khi CR)
- Agent: `serving-systems-designer`
