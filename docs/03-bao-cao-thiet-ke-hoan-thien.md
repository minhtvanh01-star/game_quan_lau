# Báo cáo thiết kế hoàn thiện — Tiệm Lẩu Gia Đình / Quán Lẩu Cuối Ngõ

| Trường | Nội dung |
|--------|----------|
| **Tên làm việc** | Tiệm Lẩu Gia Đình · Quán Lẩu Cuối Ngõ · Hot Pot Story |
| **Loại tài liệu** | Báo cáo thiết kế hoàn thiện (tổng hợp + khóa hướng MVP) |
| **Phiên bản** | 1.2 |
| **Ngày** | 2026-11-23 |
| **Nguồn đầu vào** | Word · docs 01/02 · CR chủ SP (buffet/story + web playtest) |
| **Trạng thái** | Khóa MVP + **Godot 4 Web playtest trước**; buffet ngoài P0 |

---

## 0. Tóm tắt điều hành

### 0.1. Kết luận khả thi

| Kết luận | Chi tiết |
|----------|----------|
| **Khả thi cao** | Mua → chuẩn bị → gọi món → báo cáo; staff FSM; nợ vay khởi đầu; 1 quán nhỏ |
| **Khả thi có điều kiện** | PC + Mobile cùng lúc; FEFO đầy đủ; Chương 2 cạnh tranh danh tiếng |
| **Chưa nên làm sớm** | Buffet trong MVP; multiplayer; LLM mọi frame; chuỗi chi nhánh; photoreal |
| **Rủi ro lớn nhất** | Scope phình (kho sâu + buffet + AI hội thoại + Ch.2 cùng lúc) |
| **Thời gian MVP** | 5–8 tháng (đội 4–7); prototype vòng ngày 4–6 tuần |

**Verdict:** MVP tập trung **gọi món + chuẩn bị + vay nợ sửa tiệm gia đình**. Buffet **không thuộc P0** — mở sau khi kết thúc cốt truyện Ch.1 hoặc như **lựa chọn giải quyết** trong nhiệm vụ cạnh tranh danh tiếng (Ch.2+).

### 0.2. Định hướng khóa (v1.2 — đã xác nhận chủ SP)

| Hạng mục | Quyết định khóa MVP | Ghi chú |
|----------|---------------------|---------|
| Thể loại | Restaurant sim, chơi đơn | Không online |
| Không gian | 1 tiệm gia đình để lại (xuống cấp), 6–8 bàn | Không chuỗi |
| Core loop | Mua → chuẩn bị → phục vụ **gọi món** → báo cáo → trả nợ / nâng cấp | Theo Word |
| Phục vụ | **Chỉ gọi món (P0)** | **Buffet = sau Ch.1 / mở rộng / lựa chọn Ch.2** |
| Kho | P0 đơn giản; FEFO/lô = P1 | |
| Khách | FSM + hài lòng/kiên nhẫn; 5 nhóm | Không LLM mọi lúc |
| AI C2 | **P1** | Event + whitelist |
| Điều khiển | Click/tap + staff auto + panel pause | |
| Art / engine | **Godot 4.x** + art **placeholder khối màu** (playtest) | 1A/2B/4A |
| Nền tảng giai đoạn 0 | **Web (Godot export)** playtest nội bộ trước | Native Android/PC sau khi loop ổn |
| Phạm vi web v0 | Gần MVP: nhiều bàn, staff auto, quest nâng cấp, clear Ch.1 | 3B |
| Cốt truyện Ch.1 | Gia đình **để lại tiệm** → **vay nợ** sửa chữa + nhập hàng + mở lại → trả hết nợ | 2A đã chốt |
| Kết thúc Ch.1 | (1) Trả **hết** nợ + (2) vốn ≥ `V_clear` + (3) hoàn thành quest nâng cấp | `V_clear` = biến cân bằng (4A) |
| Sau Ch.1 | **Sang Chương 2** (cạnh tranh / danh tiếng) — **không** sandbox ngay | 3B đã chốt |
| Buffet | **Ngoài MVP** | Sau hết cốt truyện Ch.1 **hoặc** lựa chọn trong quest cạnh tranh danh tiếng |
| Ngôn ngữ bản đầu | Tiếng Việt | |

---

## 1. Mục đích tài liệu

Khóa hướng MVP sau đối chiếu Word + docs trước + change request chủ sản phẩm (bỏ buffet khỏi P0; story tiếp quản tiệm để lại; win Ch.1; sang Ch.2).

Không thay GDD/TDD scene-by-scene.

---

## 2. Đánh giá khả thi & hòa giải

### 2.1. Điểm mạnh giữ từ Word

Vòng ngày 7 bước; chuẩn bị mẻ/sơ chế; order FSM; staff FSM; click/tap; MVP acceptance; không online.

### 2.2. Thay đổi so với v1.0 báo cáo này

| Trước (v1.0) | Nay (v1.1) |
|--------------|------------|
| Buffet Basic P0 hẹp | **Buffet ngoài P0** |
| Story gộp “nợ + quán cuối ngõ mở mới” | **Gia đình để lại tiệm** → vay để sửa/nhập/mở |
| Sau Ch.1: sandbox | **Sang Chương 2** (danh tiếng / cạnh tranh) |
| Clear Ch.1 mơ hồ | Trả hết nợ + `V_clear` + quest nâng cấp |

### 2.3. Ma trận khả thi (1–5)

| Trụ | Điểm | Nhận xét |
|-----|------|----------|
| Core loop ngày + gọi món | **5** | Xương MVP |
| Chuẩn bị mẻ/sơ chế | **5** | USP vận hành |
| Nợ vay khởi đầu + trả hết | **5** | Win condition rõ |
| Buffet (mở rộng) | **4** | Làm sau; gắn Ch.2 nếu cần |
| Ch.2 cạnh tranh danh tiếng | **3** | Spec sau khi Ch.1 ổn |
| Art/engine lưỡng chế | **—** | Cần chốt |

---

## 3. Định vị sản phẩm

### 3.1. Một câu

**Tiệm Lẩu Gia Đình** — game mô phỏng quản lý: người chơi **tiếp quản tiệm lẩu gia đình để lại** (mặt bằng/thiết bị xuống cấp), **vay nợ** để sửa chữa, mua nguyên liệu và mở quán; vận hành theo ngày với **gọi món**; Chương 1 kết thúc khi **trả hết nợ**, đạt **vốn tối thiểu** và **hoàn thành nhiệm vụ nâng cấp**, rồi sang **Chương 2** (cạnh tranh danh tiếng).

### 3.2. Pillars

1. **Quyết định trước giờ mở** — mua / nấu mẻ / sơ chế bao nhiêu.  
2. **Điều hành ca sống** — bàn, bếp, order, cao điểm, hết món.  
3. **Gọi món là xương phục vụ** — buffet không nằm MVP.  
4. **Vay nợ → trả hết → lớn lên** — Ch.1 win rõ; Ch.2 danh tiếng.

---

## 4. Bối cảnh và thế giới

Gia đình **để lại** một tiệm lẩu (ngõ, cũ, thiết bị hỏng/thiếu). Người chơi tiếp quản. Để mở lại cần **khoản vay**: sửa chữa, mua nguyên liệu lần đầu, vận hành những ngày đầu. Áp lực = trả nợ đúng hạn và tích lũy đến khi **trả hết**.

| Khu vực | Vai trò |
|---------|---------|
| Mặt tiền / ngõ | Khách xuất hiện; cảm giác tiệm cũ |
| Khu bàn 6–8 | Sức chứa (mở dần bằng nâng cấp) |
| Bếp / sơ chế / nồi | Mẻ nước lẩu, order |
| Kho | Tồn thô / đã sơ chế (P0) |
| Quầy tính tiền | Kết thúc lượt khách |
| Quầy buffet | **Không có trong Ch.1 / MVP** — mở sau nếu chọn hướng buffet |

Tone: khó khăn thật, ấm, tự hào mốc nhỏ — không bi lụy.

---

## 5. Vòng lặp gameplay

```text
Mua hàng → Chuẩn bị (mẻ + sơ chế) → Mở cửa
  → Phục vụ gọi món + hết món / cao điểm
  → Đóng cửa → Báo cáo ngày
  → Trả nợ / quest nâng cấp → Ngày kế
```

Ngày đầu game ~5–8 phút mô phỏng (tạm). Panel quản lý **pause**.

---

## 6. Kho & chuẩn bị (P0)

- Thô vs đã sơ chế; thịt/rau dùng trong ngày; hàng khô không hạn.
- Nấu theo mẻ + sơ chế theo số lượng; trừ kho nguyên tử.
- Sau mở cửa: P0 khóa sơ chế lớn.
- Lot / FEFO / tủ đông = **P1**.

---

## 7. Phục vụ: chỉ gọi món (P0)

### 7.1. Khách

`SPAWN → FIND_TABLE → WAITING_ORDER → ORDERING → WAITING_FOOD → EATING → REQUEST_PAYMENT → LEAVING → COMPLETED`

5 nhóm: cặp đôi, gia đình, nhóm bạn, công việc, người lớn tuổi.

### 7.2. Order

`NEW → CHECKING_STOCK → ACCEPTED → PREPARING → READY → DELIVERING → SERVED → COMPLETED`  
(+ hết hàng / hủy)

### 7.3. Buffet — ngoài MVP

| Thời điểm | Vai trò buffet |
|-----------|----------------|
| MVP / Ch.1 | **Không implement** |
| Sau kết thúc cốt truyện Ch.1 | Có thể mở như **nội dung mở rộng** |
| Chương 2+ | Có thể là **một lựa chọn** để giải quyết nhiệm vụ cạnh tranh danh tiếng (ví dụ thu hút phân khúc khách, tăng traffic) |

Khi làm buffet sau này: tách doanh thu vé vs COGS tiêu thụ; không gộp với gọi món.

---

## 8. Nhân viên (P0)

Rule-based FSM. Vai trò: chủ quán, phục vụ auto, bếp (mở dần), thu ngân/gia đình.  
Không có task “refill buffet” trong MVP.

---

## 9. Điều khiển

Click/tap sàn & đối tượng; pathfinding; panel pause.  
Đối tượng P0: bếp/nồi, bàn sơ chế, kho, bàn khách, quầy thu ngân. **Không** quầy buffet.

---

## 10. Cảm xúc & AI

| Tầng | Phạm vi |
|------|---------|
| C0 / C1 | **P0** |
| C2 LLM | **P1** |

---

## 11. Tài chính, nợ, nâng cấp, Chương 1–2

### 11.1. Kinh tế ngày (MVP)

`Profit = Revenue_alacarte − (nguyên liệu + lương + hàng hỏng P0 + chi khác)`  
Không có dòng vé buffet trong MVP.

### 11.2. Nợ vay khởi đầu (P0)

- Đầu game: nhận khoản vay (hoặc mở nợ) dùng cho sửa chữa + nhập hàng + vốn vận hành.
- Áp lực trả định kỳ trong Ch.1.
- **Win Ch.1 yêu cầu trả hết dư nợ** (không chỉ trả đúng một kỳ).

### 11.3. Điều kiện kết thúc Chương 1 (đã chốt)

Phải **đồng thời**:

1. **DebtRemaining = 0** (trả hết nợ).  
2. **Cash ≥ `V_clear`** — số vốn tối thiểu; `V_clear` là **biến cân bằng**, chốt sau playtest (placeholder trong data).  
3. **Hoàn thành bộ nhiệm vụ nâng cấp Ch.1** (sửa bếp/bàn/kho/nhân sự tối thiểu — danh sách khóa trong GDD quest).

### 11.4. Sau Chương 1

Sang **Chương 2**: cạnh tranh địa phương / danh tiếng (3B).  
Không vào sandbox thuần ngay. Buffet có thể xuất hiện như mở rộng hoặc lựa chọn trong quest danh tiếng.

### 11.5. Nhịp quest Ch.1 (thay buffet beat)

| # | Beat | Objective gợi ý |
|---|------|-----------------|
| 1 | Tiếp quản tiệm để lại; vay vốn; sửa tối thiểu | Checklist sửa + nhận nợ |
| 2 | Nhập hàng, chuẩn bị, mở cửa lần đầu | Hoàn tất 1 ngày mở |
| 3 | Khách đầu — gọi món hoàn chỉnh | Phục vụ N khách / đúng pipeline |
| 4 | Quá tải bếp — học điều phối + staff | Xử lý rush |
| 5 | Nâng cấp bắt buộc (bếp/bàn/kho…) | Hoàn thành quest nâng cấp |
| 6 | Áp lực nợ → trả hết + tích `V_clear` | Clear Ch.1 |

---

## 12. Nội dung ẩm thực MVP

Nước lẩu 4–5; món 15–20 (proto 3–5); bàn 6–8; quest Ch.1 5–8. Chỉ phục vụ gọi món.

---

## 13. UI

HUD: tiền, nợ còn lại, tiến độ `V_clear`, cấp/nâng cấp, giờ ngày, cảnh báo.  
Thanh quản lý: mua, kho, chuẩn bị, thực đơn, nhân viên, nâng cấp, tài chính.  
Không tab buffet trong MVP.

---

## 14. Dữ liệu & save

Thêm/giữ: `DebtData` (gốc, lãi nếu có, remaining, kỳ hạn), `ClearChapter1Config` (`V_clear`, danh sách upgrade quest ids).  
`BuffetTierData` — chỉ khi làm mở rộng / Ch.2; không bắt buộc schema MVP.

Local-first save; autosave cuối ngày.

---

## 15. Kiến trúc

```text
Client (Godot hoặc Unity — mở)
  ├─ Day loop / Inventory-Prep / Order (à la carte)
  ├─ Economy & Debt (vay → trả hết)
  ├─ Customer FSM + Staff FSM
  ├─ Progression (Ch.1 clear → Ch.2)
  └─ Save
Backend (P1 nếu C2)
```

Không module buffet trong build MVP.

---

## 16. Phạm vi MVP & nghiệm thu

### 16.1. Phải có

- 1 map tiệm xuống cấp; click/tap; mua + kho P0; mẻ + sơ chế; order đến thanh toán; ≥1 staff auto; báo cáo ngày; hệ nợ vay; quest nâng cấp; save/load.
- **Không** buffet, không quầy buffet, không vé buffet.

### 16.2. Tiêu chí

| Mã | Tiêu chí |
|----|----------|
| MVP-01…10 | Giữ từ Word (di chuyển, UI, mua, mẻ, order, staff, báo cáo, save, thiết bị) — **bỏ mọi tiêu chí buffet** |
| MVP-11 | Hết món → phản ứng khách có thông báo |
| MVP-12 | Có khoản vay đầu game và lịch trả trong Ch.1 |
| MVP-13 | Có thể đưa DebtRemaining → 0 trong tiến trình Ch.1 |
| MVP-14 | Theo dõi Cash so với `V_clear` (placeholder) |
| MVP-15 | Bộ quest nâng cấp Ch.1 hoàn thành được |
| MVP-16 | Khi đủ 3 điều kiện clear → chuyển sang Ch.2 (hook/placeholder được chấp nhận ở proto muộn) |

### 16.3. Ngoài MVP

Buffet (trừ khi change request Ch.2); chuỗi; multiplayer; photoreal; AI chat tự do; FEFO đầy đủ trước core ổn.

---

## 17. Kế hoạch & rủi ro

| Giai đoạn | Kết quả |
|-----------|---------|
| 0. Lock | MVP + art/engine |
| 1. Prototype | Mua–nấu–gọi món–thu–nợ hiển thị |
| 2. Core | Ngày đủ pha, nâng cấp, trả nợ |
| 3. Ch.1 clear | 3 điều kiện win + hook Ch.2 |
| 4. P1 | FEFO / C2 / nội dung Ch.2; xét buffet như lựa chọn danh tiếng |
| 5. Soft launch | Cân bằng `V_clear`, tutorial, perf |

| Rủi ro | Giảm thiểu |
|--------|------------|
| Lỡ làm buffet sớm | Scope lock; từ chối P0 |
| `V_clear` / nợ quá khó hoặc dễ | Data-driven; playtest |
| Ch.2 chưa spec mà block clear | Hook Ch.2 đủ; spec Ch.2 song song sau |

---

## 18. Quyết định còn mở / đã chốt kỹ thuật

| # | Hạng mục | Trạng thái |
|---|----------|------------|
| 1 | Engine playtest | **Đã chốt: Godot 4.x** |
| 2 | Nền tảng giai đoạn 0 | **Đã chốt: Web export** (playtest nội bộ) |
| 3 | Art playtest | **Đã chốt: placeholder khối màu** |
| 4 | Phạm vi web v0 | **Gần MVP (3B)** |
| 5 | Tên store | Còn mở |
| 6 | Giá trị `V_clear` & lịch nợ | Placeholder data — chốt sau playtest |
| 7 | Native Android/PC | Sau khi web loop ổn |

**Đã chốt (không hỏi lại):** chỉ gọi món P0; buffet sau Ch.1 / lựa chọn Ch.2; story 2A; sau Ch.1 → Ch.2; `V_clear` biến số; Godot 4 Web playtest trước.

Prototype code: thư mục `godot/`.

---

## 19. Kết luận

MVP = **tiếp quản tiệm để lại + vay nợ + gọi món + chuẩn bị + trả hết nợ + vốn + nâng cấp → Ch.2**.  
Buffet không nằm xương sống bản đầu. **Chạy thử bằng Godot 4 Web trước**, art placeholder, phạm vi gần MVP.

---

## Phụ lục A — Mapping

| Đề xuất | Quyết định v1.1 |
|---------|-----------------|
| Word: mua–chuẩn bị–phục vụ | Giữ — chỉ gọi món |
| Word: tiếp quản tiệm | Giữ — **gia đình để lại** + vay sửa/mở |
| Docs trước: buffet P0 | **Hủy khỏi P0** — mở rộng / Ch.2 |
| Docs trước: sandbox sau Ch.1 | **Đổi** → Chương 2 |
| Clear Ch.1 | Trả hết nợ + `V_clear` + quest nâng cấp |

## Phụ lục B — Liên kết

- `docs/01-nghien-cuu-kha-thi-game-quan-lau.md`
- `docs/02-bao-cao-thiet-ke-san-pham.md`
- `Bao_cao_thiet_ke_game_Tiem_Lau_Gia_Dinh.docx`
- https://github.com/minhtvanh01-star/game_quan_lau

— HẾT BÁO CÁO HOÀN THIỆN v1.1 —
