# AGENTS.md — Hot Pot Story / Quán Lẩu Cuối Ngõ

Hướng dẫn cho mọi AI agent và dev khi làm việc trong repo này.

## Nguồn sự thật

1. `docs/01-nghien-cuu-kha-thi-game-quan-lau.md` — phạm vi MVP, rủi ro, ưu tiên P0/P1/P2
2. `.cursor/rules/` — quy tắc bắt buộc khi code
3. `CONTRIBUTING.md` — quy trình push / PR / test / format

## Định hướng sản phẩm (không đổi trừ khi có change request)

- 3D isometric, stylized (không photoreal)
- Hybrid control: đi trực tiếp + bảng quản lý
- Hybrid serving: buffet + gọi món
- 1 quán cuối ngõ trong MVP; **không** làm chuỗi/multiplayer sớm
- Cốt truyện: gia đình nợ nần, trả nợ dần
- AI khách: deep theo **sự kiện** (C2), không LLM mọi frame

## Vai trò agent trong repo

| Agent | Khi nào dùng |
|-------|----------------|
| `mvp-reviewer` | Sau mỗi feature / trước PR — kiểm scope P0 |
| `economy-auditor` | Khi đụng buffet, giá, nợ, profit |
| `ai-safety-reviewer` | Khi đụng LLM, dialogue, action whitelist |
| `unity-code-reviewer` | Khi đụng C# / Unity gameplay |

## Skills dự án

| Skill | Mục đích |
|-------|----------|
| `mvp-scope-guard` | Chặn / cắt feature ngoài P0 |
| `buffet-economy-balance` | Thiết kế & kiểm công thức kinh tế |
| `ai-customer-event` | Thiết kế event AI C0/C1/C2 đúng tầng |
| `pre-push-checklist` | Checklist bắt buộc trước push |

## Nguyên tắc kỹ thuật ngắn

- Simulation (tiền, order, cảm xúc số) là nguồn sự thật; AI chỉ đề xuất dialogue + `suggested_actions` đã whitelist.
- Không nhúng API key / secret vào client Unity.
- Mọi thay đổi economy phải có test số (unit/edit-mode) trước khi polish art.
- Trước push: format → test liên quan → không secret → không phá MVP lock.

## Cấm trong MVP (P2)

- Multiplayer / realtime leaderboard
- Nhiều chi nhánh
- Photoreal graphics
- AI chat tự do không whitelist
- Pay-to-win cảm xúc / AI
