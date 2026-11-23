---
name: customer-emotion-design
description: >-
  Designs 5 customer groups and numeric satisfaction/patience formulas for Hot
  Pot Story. Use when tuning customer archetypes, wait penalties, seating, or
  leave/complain thresholds.
---

# Customer Emotion Design

## Instructions

1. Simulation sở hữu cảm xúc số; dialogue/AI chỉ phản ánh — không tự sửa chỉ số ngoài whitelist delta.
2. MVP groups (đúng 5):

| Group | Patience bias | Spend bias | Note |
|-------|---------------|------------|------|
| Cặp đôi | Trung bình | Trung bình | Hay gọi món + chia sẻ |
| Gia đình | Thấp hơn khi đông trẻ | Cao suất | Cần bàn lớn |
| Nhóm bạn | Thấp khi chờ lâu | Buffet-leaning | Ồn, rush |
| Công việc | Trung bình–cao | À la carte | Ít bàn, nhanh |
| Người lớn tuổi | Cao kiên nhẫn | Thấp–TB | Ghét bàn ồn/bẩn |

3. Chỉ số tối thiểu P0: **satisfaction**, **patience**. (Tin tưởng / thiện cảm = P1.)
4. Mọi công thức delta → có test số (chờ X giây → patience −Y).

## Delta sources (P0)

- Chờ món / xếp bàn lâu
- Đúng món / sai món
- Hết hàng
- Bàn bẩn / dọn chậm
- Xử lý sự cố tốt/xấu (action whitelist)

## Thresholds

Định nghĩa rõ: complain event, leave table, tip/no-tip (nếu có), ảnh hưởng báo cáo ngày.

## Output template

```markdown
## Emotion change
- Groups touched:
- Formula:
- Example timeline:
- Leave / complain at:
- Tests:
```

## Reference

- Rule: `.cursor/rules/ai-customer-safety.mdc`
- Skill: `ai-customer-event` (khi gắn C1/C2)
- Agent: `customer-sim-designer`
