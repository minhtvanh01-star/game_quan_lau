---
name: hybrid-control-ux
description: >-
  Guides hybrid control UX for Hot Pot Story: walk-the-floor actions plus
  management panels on mobile. Use when designing HUD, pause-manage, tutorial,
  or player vs auto-staff handoff.
---

# Hybrid Control UX

## Instructions

1. Hai lớp rõ ràng — không trộn nút quản lý vào gesture đi lại.
2. **Trực tiếp:** di chuyển, chào, mang món, xử lý sự cố tại bàn/buffet.
3. **Quản lý:** mở panel (nên pause hoặc slow-mo): kho, giá buffet, phân việc, báo cáo.
4. Cao điểm: giảm overlay; dựa auto-staff + toast ngắn + pin 1–2 việc khẩn.
5. Đầu game dạy tay; sau unlock auto → giảm micro-manage bắt buộc.

## Do / Don't

| Do | Don't |
|----|-------|
| Icon lớn, 1 hành động chính/ngón cái | Dashboard số che camera quán |
| Pause khi mở finance/staff sâu | Bắt freeze tay để nhập kho lúc rush |
| Toast sự cố + nút “Đến chỗ” | Modal chồng modal |
| Tutorial ≤ vài bước/context | Wall of text lore |

## Flow template

```markdown
## UX flow
- Context: prepare | service | rush | close
- Layer: direct | manage
- Primary action:
- Secondary:
- Auto-staff covers:
- Clutter risk + mitigation:
```

## Reference

- `docs/02-bao-cao-thiet-ke-san-pham.md` §8.4
- Agent: `ux-hybrid-reviewer`
- Skill: `staff-auto-tasks`
