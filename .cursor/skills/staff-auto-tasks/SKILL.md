---
name: staff-auto-tasks
description: >-
  Designs basic auto-staff task assignment (FSM/BT) for Hot Pot Story MVP —
  greeter, server, kitchen, cashier, buffet refill. Use when adding staff roles,
  auto dispatch, or family unlock helpers.
---

# Staff Auto Tasks

## Instructions

1. MVP: staff **auto nhận việc cơ bản** khi bật điều phối; player can thiệp lúc quá tải.
2. Dùng FSM/BT truyền thống — **không** LLM cho staff.
3. Vai trò mở dần: lễ tân, phục vụ, bếp, bổ sung buffet, thu ngân (gia đình = starter).
4. Mỗi task: precondition → claim → execute → complete/abort; tránh 2 người claim 1 việc.
5. Thuộc tính tối thiểu: tốc độ, thái độ, mệt, lương — đủ ảnh hưởng thời gian/cảm xúc.

## Task priority (gợi ý)

1. Sự cố / khách sắp bỏ đi  
2. Món Ready cần mang  
3. Order mới / bếp trống slot  
4. Buffet cần refill  
5. Dọn bàn / chào khách  

## Spec template

```markdown
## Staff task
- role:
- task id:
- trigger:
- claim lock:
- duration / speed formula:
- abort conditions:
- emotion side-effect on customer:
```

## Out of scope (P1/P2)

- Lịch ca phức tạp, skill tree sâu, multiplayer shift

## Reference

- `docs/01-nghien-cuu-kha-thi-game-quan-lau.md` §5.1, §4.2
- Agent: `ux-hybrid-reviewer` (handoff auto ↔ player)
