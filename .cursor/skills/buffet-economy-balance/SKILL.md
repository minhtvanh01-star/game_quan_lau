---
name: buffet-economy-balance
description: >-
  Designs and audits buffet vs à la carte economy formulas for post-MVP /
  Chapter 2+ content. Use when CR unlocks buffet (after Ch.1 or reputation
  quests), or when changing prices, ingredients, buffet tiers, finance UI.
---

# Buffet Economy Balance

## Scope gate

Buffet **không thuộc MVP/P0**. Chỉ thiết kế/implement khi có change request:
sau hết cốt truyện Ch.1, hoặc như lựa chọn trong quest cạnh tranh danh tiếng (Ch.2+).

## Instructions

1. Đọc `docs/03` §7.3 và `.cursor/rules/economy-simulation.mdc`.
2. Tách rõ:
   - **À la carte:** doanh thu theo món; COGS theo recipe.
   - **Buffet:** doanh thu theo vé/người; COGS theo lượng lấy thực tế.
3. Khi đề xuất số liệu, đưa bảng giả định + edge cases (khách ăn nhiều / ít).
4. Mọi thay đổi công thức → yêu cầu/ viết unit test số.
5. Không đề xuất P2W hoặc “buffet luôn lời”.
6. Nếu user xin buffet trong MVP → scope verdict: P1/P2, không implement trừ CR.
