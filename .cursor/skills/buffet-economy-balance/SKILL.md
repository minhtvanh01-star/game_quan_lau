---
name: buffet-economy-balance
description: >-
  Designs and audits buffet vs à la carte economy formulas, ticket price vs
  consumption cost, daily profit, and debt pressure. Use when changing prices,
  ingredients, buffet tiers, finance UI, or balance patches.
---

# Buffet Economy Balance

## Instructions

1. Tách rõ:
   - **À la carte:** doanh thu theo món; COGS theo recipe.
   - **Buffet:** doanh thu theo vé/người; COGS theo lượng lấy thực tế.
2. Khi đề xuất số liệu, đưa bảng giả định + edge cases (khách ăn nhiều / ít).
3. Mọi thay đổi công thức → yêu cầu/ viết unit test số.
4. Không đề xuất P2W hoặc “buffet luôn lời”.

## Output template

```markdown
## Economy change
- Formula touched: ...
- Example day (revenue/expense/profit): ...
- Failure mode if misbalanced: ...
- Tests to add/update: ...
```

## Reference

- `docs/01-nghien-cuu-kha-thi-game-quan-lau.md` §4.4, §8
- Rule: `.cursor/rules/economy-simulation.mdc`
