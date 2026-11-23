---
name: day-loop-sim
description: >-
  Specs the business-day simulation loop for Hot Pot Story: prepare, open,
  serve (à la carte), rush, close, daily report, and debt pressure. Use when
  implementing day phases, close-of-day summary, or debt schedule hooks.
---

# Day Loop Sim

## Instructions

1. Core loop P0 (khóa):

```text
Prepare → Open / Seat → Serve (gọi món only) → Rush → Close
       → Daily report → Debt / upgrade quest / V_clear progress → Next day
```

2. Báo cáo ngày tối thiểu: doanh thu (à la carte), chi phí, lợi nhuận, satisfaction TB, stockout count, nợ còn lại.
3. Ch.1: áp lực trả nợ; clear cần DebtRemaining=0 + Cash≥V_clear + quest nâng cấp (không chỉ một kỳ).
4. Save/load không mất quest + nợ + tồn kho + tiến độ `V_clear`.
5. Thời gian trong ngày = mô phỏng (có pause/slow); mục tiêu ~5–8 phút đầu game (tạm).
6. Không phase/report dòng buffet trong MVP.

## Acceptance map

| Go/no-go | Loop hook |
|----------|-----------|
| Chơi được 1 ngày | Phases chạy end-to-end |
| Order + hết hàng | Fail hiện trong ngày + report |
| Staff auto | Rush vẫn chạy được |
| Cảm xúc đổi | Satisfaction TB phản ánh |
| Nợ / `V_clear` | Track sau mỗi ngày |
| Clear Ch.1 | 3 điều kiện AND → hook Ch.2 |

## Spec template

```markdown
## Day phase
- phase:
- player actions:
- sim ticks:
- report fields:
- debt / V_clear hooks:
```

## Reference

- `docs/03` §5, §11, §16
- Skills: `serving-order-pipeline`, `quest-chapter-design`
