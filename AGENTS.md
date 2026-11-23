# AGENTS.md — Hot Pot Story / Quán Lẩu Cuối Ngõ

Hướng dẫn cho mọi AI agent và dev khi làm việc trong repo này.

## Nguồn sự thật

1. `docs/03-bao-cao-thiet-ke-hoan-thien.md` — báo cáo hoàn thiện khóa hướng MVP (ưu tiên đọc)
2. `docs/01-nghien-cuu-kha-thi-game-quan-lau.md` — phạm vi MVP, rủi ro, ưu tiên P0/P1/P2
3. `docs/02-bao-cao-thiet-ke-san-pham.md` — thiết kế sản phẩm (pillars, hệ thống, nhân vật)
4. `.cursor/rules/` — quy tắc bắt buộc khi code
5. `CONTRIBUTING.md` — quy trình push / PR / test / format

## Định hướng sản phẩm (không đổi trừ khi có change request)

- Playtest hiện tại: **Godot 4** + **Web export**; art **placeholder**; code trong `godot/`
- Hybrid control: click/tap + panel (web UI nút); pause ở pha chuẩn bị/báo cáo
- Core loop: mua → chuẩn bị (mẻ/sơ chế) → **gọi món** → báo cáo → nợ/nâng cấp
- Phục vụ MVP: **chỉ gọi món** — **buffet ngoài P0**
- 1 tiệm gia đình để lại; **không** chuỗi/multiplayer sớm
- Cốt truyện: để lại tiệm → vay → clear Ch.1 (hết nợ + `V_clear` + nâng cấp) → **Ch.2**
- AI khách: C0/C1 P0; C2 = P1
- Kho FEFO = P1; P0 thô/sơ chế + hết món

## Vai trò agent trong repo

| Agent | Khi nào dùng |
|-------|----------------|
| `mvp-reviewer` | Sau mỗi feature / trước PR — kiểm scope P0 |
| `economy-auditor` | Khi đụng buffet, giá, nợ, profit |
| `ai-safety-reviewer` | Khi đụng LLM, dialogue, action whitelist |
| `unity-code-reviewer` | Khi đụng C# / Unity gameplay |
| `quest-narrative-designer` | Quest Chương 1, nợ, hội thoại gia đình |
| `serving-systems-designer` | Order pipeline, buffet, bếp, kho |
| `customer-sim-designer` | 5 nhóm khách, cảm xúc số, xếp bàn |
| `mobile-perf-reviewer` | Hiệu năng Unity isometric trên Android tầm trung |
| `ux-hybrid-reviewer` | Hybrid control, HUD, pause-manage, auto-staff handoff |

### Gợi ý gọi agent theo việc

| Việc | Agent ưu tiên |
|------|----------------|
| Feature mới / PR | `mvp-reviewer` → (domain) → `unity-code-reviewer` |
| Đổi giá / COGS / nợ | `economy-auditor` |
| Event khách / LLM | `ai-safety-reviewer` + `customer-sim-designer` |
| Rush / order / kho | `serving-systems-designer` |
| Quest / story beat | `quest-narrative-designer` |
| Giật frame / VFX / light | `mobile-perf-reviewer` |
| HUD / tutorial / panel | `ux-hybrid-reviewer` |

## Skills dự án

| Skill | Mục đích |
|-------|----------|
| `mvp-scope-guard` | Chặn / cắt feature ngoài P0 |
| `buffet-economy-balance` | Thiết kế & kiểm công thức kinh tế |
| `ai-customer-event` | Thiết kế event AI C0/C1/C2 đúng tầng |
| `pre-push-checklist` | Checklist bắt buộc trước push |
| `quest-chapter-design` | Spec nhiệm vụ Chương 1 gắn nợ & gia đình |
| `serving-order-pipeline` | Order state machine + buffet + bếp + stockout |
| `staff-auto-tasks` | Staff/family auto task FSM–BT cơ bản |
| `customer-emotion-design` | 5 nhóm khách + satisfaction/patience số |
| `day-loop-sim` | Vòng ngày: mở→phục vụ→báo cáo→nợ tuần |
| `hybrid-control-ux` | UX đi sàn + panel quản lý trên mobile |
| `unity-mobile-perf` | Checklist perf isometric mobile |

### Skill ↔ hệ thống P0

| Hệ thống P0 | Skill |
|-------------|--------|
| Scope lock | `mvp-scope-guard` |
| Tài chính / nợ (MVP) | `day-loop-sim`; buffet chỉ khi CR → `buffet-economy-balance` |
| Gọi món / bếp / kho | `serving-order-pipeline` |
| Staff auto | `staff-auto-tasks`, `hybrid-control-ux` |
| Khách & cảm xúc | `customer-emotion-design`, `ai-customer-event` |
| Quest Ch.1 | `quest-chapter-design` |
| Push / PR | `pre-push-checklist` |
| Build mobile ổn | `unity-mobile-perf` |

## Nguyên tắc làm việc với yêu cầu

- Rule bắt buộc: `.cursor/rules/clarify-before-act.mdc` (`alwaysApply`).
- Chưa hiểu / ≥2 cách hiểu / lệch docs khóa / nhiều người khác ý → **hỏi làm rõ + tóm tắt thống nhất** trước khi làm lớn.
- Việc nhỏ rõ trong P0: làm luôn; ghi giả định ngắn nếu chỉ thiếu chi tiết kỹ thuật an toàn.

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
