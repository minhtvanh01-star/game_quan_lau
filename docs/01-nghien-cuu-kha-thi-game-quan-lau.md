# Nghiên cứu khả thi — Game quản lý quán lẩu

| Mục | Giá trị |
|-----|---------|
| **Tên làm việc** | Tiệm Lẩu Gia Đình / Quán Lẩu Cuối Ngõ / Hot Pot Story |
| **Nguồn** | ChatGPT · Word *Tiệm Lẩu Gia Đình* · change request chủ SP |
| **Ngày** | 2026-11-23 |
| **Phiên bản** | 1.2 |
| **Trạng thái** | Khóa MVP: chỉ gọi món; buffet ngoài P0; Ch.1 win → Ch.2 |
| **Báo cáo tổng hợp** | `docs/03-bao-cao-thiet-ke-hoan-thien.md` |
| **Repo** | https://github.com/minhtvanh01-star/game_quan_lau |

---

## 1. Tóm tắt điều hành

| Kết luận | Chi tiết |
|----------|----------|
| **Nên làm (P0)** | Tiếp quản tiệm gia đình để lại; vay nợ sửa/nhập/mở; mua–chuẩn bị–**gọi món**–báo cáo; staff FSM; trả hết nợ + `V_clear` + quest nâng cấp |
| **Làm sau** | Buffet (sau Ch.1 hoặc lựa chọn quest danh tiếng Ch.2); FEFO; AI C2 |
| **Không sớm** | Multiplayer; chuỗi; LLM mọi frame; photoreal |
| **Rủi ro lớn** | Phình scope (buffet + kho sâu + Ch.2 full cùng lúc) |
| **Thời gian MVP** | 5–8 tháng (đội 4–7) |

**Định hướng khóa v1.2:**

| Hạng mục | Quyết định |
|----------|------------|
| Phục vụ | **Chỉ gọi món** — buffet **không** P0 |
| Story | Gia đình **để lại tiệm** → vay để sửa + nhập + mở lại |
| Clear Ch.1 | Trả hết nợ + Cash ≥ `V_clear` + xong quest nâng cấp |
| Sau Ch.1 | **Chương 2** (cạnh tranh / danh tiếng), không sandbox ngay |
| Buffet | Mở rộng sau Ch.1 **hoặc** lựa chọn trong quest danh tiếng |
| Art / engine | **Godot 4** + placeholder; playtest **Web** trước |

---

## 2. Nguồn nghiên cứu

1. Word — xương sim kho/chuẩn bị/order/staff.  
2. Docs trước — nợ, cảm xúc, AI tầng (đã **bỏ buffet khỏi P0** theo CR).  
3. Chủ SP (2026-11-23): buffet sau; story 2A; sau Ch.1 → Ch.2; `V_clear` biến số.

---

## 3. Thị trường (tóm tắt)

Khác biệt khả thi: **chuẩn bị trước giờ mở** + **câu chuyện tiếp quản tiệm / trả hết nợ** + ca gọi món sống — không thắng bằng theme lẩu hay buffet sớm.

---

## 4. Khả thi theo trụ

| Hạng mục | Điểm | Ghi chú |
|----------|------|---------|
| Vòng ngày + gọi món | **5** | P0 |
| Chuẩn bị mẻ/sơ chế | **5** | P0 |
| Nợ vay → trả hết + `V_clear` | **5** | Win rõ |
| Buffet | **4** | Sau MVP / Ch.2 |
| Ch.2 danh tiếng | **3** | Spec sau Ch.1 ổn |
| FEFO đầy đủ | **3** | P1 |
| LLM C2 | **3** | P1 |
| Chuỗi / MP | **1** | Cấm sớm |

AI: C0/C1 P0; C2 P1. Simulation giữ tiền/order/cảm xúc.

---

## 5. P0 / P1 / P2

### P0

- 1 tiệm để lại (xuống cấp), ≤8 bàn  
- Click/tap; mua; kho thô/sơ chế; mẻ + sơ chế; order pipeline  
- Staff ≥1 auto; 5 nhóm khách; cảm xúc số; C0/C1  
- Vay nợ đầu game; trả nợ; báo cáo ngày  
- Quest nâng cấp Ch.1; theo dõi `V_clear`  
- Clear Ch.1 → hook Chương 2  
- Save/load local  

### P1

- FEFO/lô; C2; memory khách; UI đầy đủ  
- Spec/playable Ch.2 cạnh tranh danh tiếng  
- **Buffet** như mở rộng hoặc lựa chọn quest danh tiếng (khi được xác nhận)

### P2

- Chuỗi; multiplayer; DLC quốc gia; photoreal; AI chat tự do; season pass phức tạp  

---

## 6. Nghiệm thu MVP

Một ngày gọi món ổn; trừ kho đúng; hết món có phản ứng; staff auto; báo cáo đúng; có nợ vay và đường trả về 0; `V_clear` track được; quest nâng cấp hoàn thành được; save không nhân đôi.  
Chi tiết MVP-01…16: `docs/03` §16.

---

## 7. Rủi ro

| Rủi ro | Biện pháp |
|--------|-----------|
| Làm buffet sớm | Scope lock — từ chối P0 |
| `V_clear` / nợ lệch | Data-driven + playtest |
| Ch.2 block ship | Hook đủ; spec Ch.2 sau |
| Art/engine chưa chốt | ≤1 tuần |

---

## 8–9. Kiến trúc & kế hoạch

Client: day loop, prep, **order only**, economy/debt, FSM, progression Ch.1→2.  
Không module buffet trong build MVP.

Prototype → core ngày+nợ → clear Ch.1 → P1 (Ch.2 / buffet tùy chọn / C2).

---

## 10. Còn mở

Art 2D vs 3D; Godot vs Unity; tên store; giá trị cụ thể `V_clear` & lịch nợ (placeholder đến playtest).

**Đã chốt:** không buffet P0; story để lại tiệm + vay; clear 3 điều kiện; sang Ch.2.

---

## 11. Kết luận

Khả thi nếu bám **gọi món + nợ + nâng cấp**. Không nhét buffet vào MVP. Đọc `docs/03` v1.1 làm nguồn khóa hướng.
