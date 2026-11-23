---
name: quest-chapter-design
description: >-
  Designs measurable Chapter 1 quests tied to debt payoff, V_clear capital,
  upgrade missions, and family beats for Hot Pot Story. Use when writing
  missions, story milestones, debt deadlines, or family dialogue hooks.
---

# Quest Chapter Design

## Instructions

1. Đọc `docs/03` §11 và `docs/02` §15 (nhịp Chương 1).
2. Mỗi quest = 1 mục tiêu đo được + 1 beat cảm xúc gia đình (ngắn).
3. Gắn nợ xuyên Ch.1; clear cần **trả hết** + `V_clear` + bộ nâng cấp.
4. Tone: ấm, không bi lụy, không cutscene dài.
5. Không viết quest buffet / mở chi nhánh / map thành phố trong Ch.1 (P0).
6. Sau clear → hook **Chương 2** (danh tiếng), không sandbox.

## Chapter 1 beats (khóa)

| # | Beat | Objective gợi ý |
|---|------|-----------------|
| 1 | Tiếp quản tiệm để lại; vay vốn; sửa tối thiểu | Checklist sửa + nhận nợ |
| 2 | Nhập hàng, chuẩn bị, mở cửa lần đầu | Hoàn tất 1 ngày mở |
| 3 | Khách đầu — gọi món | Phục vụ N khách; pipeline đúng |
| 4 | Quá tải bếp + staff auto | Xử lý rush |
| 5 | Nâng cấp bắt buộc | Hoàn thành bộ quest nâng cấp Ch.1 |
| 6 | Trả hết nợ + đạt `V_clear` | Clear Ch.1 → Ch.2 |

## Clear Ch.1 (AND)

- `DebtRemaining = 0`
- `Cash >= V_clear` (biến cân bằng)
- Tất cả upgrade-quest ids Ch.1 = done

## Spec template

```markdown
## Quest spec
- id:
- beat: 1–6
- title_vi:
- objective:
- tracking keys:
- soft fail:
- reward:
- debt: none | remind | due | payoff_progress
- upgrades_required: []
- family line (1–3 câu):
```

## Reference

- `docs/03-bao-cao-thiet-ke-hoan-thien.md`
- Agent: `quest-narrative-designer`
