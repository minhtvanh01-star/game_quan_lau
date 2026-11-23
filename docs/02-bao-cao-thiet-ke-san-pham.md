# Báo cáo thiết kế sản phẩm — Tiệm Lẩu Gia Đình / Quán Lẩu Cuối Ngõ

| Trường | Nội dung |
|--------|----------|
| **Tên làm việc** | Tiệm Lẩu Gia Đình · Quán Lẩu Cuối Ngõ · Hot Pot Story |
| **Căn cứ** | `docs/01` · `docs/03` v1.1 · CR chủ SP |
| **Phiên bản** | 0.3 |
| **Ngày** | 2026-11-23 |
| **Trạng thái** | Khóa story Ch.1 + chỉ gọi món; buffet ngoài MVP |

---

## 1. Mục đích

Thiết kế sản phẩm để duyệt trước GDD. Bản 0.3 khóa: **không buffet trong MVP**; story **gia đình để lại tiệm + vay nợ**; clear Ch.1 → **Chương 2**.

---

## 2. Tóm tắt sản phẩm

### 2.1. Định nghĩa

Người chơi **tiếp quản tiệm lẩu gia đình để lại** (xuống cấp), **vay nợ** để sửa chữa, mua nguyên liệu và mở quán; vận hành ngày với **gọi món**, nhân viên tự động và cảm xúc khách số. Chương 1 kết thúc khi **trả hết nợ**, đạt vốn **`V_clear`**, và **hoàn thành nhiệm vụ nâng cấp** — sau đó sang **Chương 2** (cạnh tranh danh tiếng).

### 2.2. Pillars

| Trụ | Mô tả |
|-----|--------|
| Quyết định trước giờ mở | Mua / mẻ / sơ chế |
| Điều hành ca sống | Order, bếp, cao điểm, hết món |
| Gọi món | Hình thức phục vụ duy nhất trong MVP |
| Vay → trả hết → Ch.2 | Động lực dài hạn rõ win |

### 2.3. Khóa / mở

**Khóa:** chơi đơn; 1 tiệm; chỉ gọi món; C0/C1 P0; C2 P1; story 2A; clear 3 điều kiện; sau Ch.1 → Ch.2; buffet không P0; **Godot 4 Web playtest** + art placeholder.  
**Mở:** giá trị `V_clear`; pixel art thay placeholder; native Android/PC sau web.

---

## 3. Đối tượng

Casual–midcore 16–35; sim quản lý; story gia đình Việt; cozy ẩm thực.

---

## 4. Bối cảnh

Gia đình **để lại** tiệm lẩu cũ. Người chơi vay để **sửa – nhập – mở lại**. Không brand lớn lúc đầu.

Khu vực: mặt tiền ngõ, 6–8 bàn, bếp/sơ chế, kho, quầy thu ngân.  
**Không** quầy buffet trong Ch.1/MVP.

---

## 5. Visual

A: 2D isometric pixel · B: 3D isometric stylized — chọn trước proto sâu. Chung: đọc mặt bằng rõ, palette ấm, không photoreal.

---

## 6. Ngôn ngữ

Tiếng Việt bản đầu; code English; tiền VND quy ước; string table sẵn localize.

---

## 7. Kỹ thuật (định hướng SP)

Engine mở (Godot/Unity). Sim: day loop, prep, **order à la carte**, debt, progression Ch.1→2.  
Không module buffet MVP. AI C2 = backend P1.

---

## 8. Gameplay

Click/tap + panel pause.  
Loop: Mua → Chuẩn bị → Mở → Gọi món → Đóng → Báo cáo → Nợ/nâng cấp.

---

## 9. Hệ thống

**Kho/prep P0:** thô/sơ chế; mẻ; sơ chế số lượng; hết món. FEFO = P1.  
**Order P0:** pipeline đầy đủ.  
**Buffet:** không MVP — sau hết Ch.1 hoặc lựa chọn quest danh tiếng Ch.2+.  
**Nhân sự / cảm xúc / 5 nhóm:** giữ.  
**Nợ:** vay đầu game; trả định kỳ; clear cần DebtRemaining = 0.  
**Nâng cấp + `V_clear`:** điều kiện win Ch.1.  
**Ch.2:** cạnh tranh / danh tiếng (spec sau).

---

## 10. Nhân vật

Chủ quán (PC); mẹ bếp; bố hậu cần/nợ; em thu ngân — mở dần.

---

## 11. Ẩm thực

4–5 nước lẩu; 15–20 món (proto ít hơn). Chỉ bán gọi món trong MVP.

---

## 12. AI

C0/C1 P0; C2 P1. Staff = rule-based. Không generative cho vận hành.

---

## 13. UI

HUD: tiền, **nợ còn**, tiến độ **`V_clear`**, nhiệm vụ nâng cấp, giờ ngày.  
Không tab buffet MVP.

---

## 14. Biên giới

| Có | Không (MVP) |
|----|-------------|
| Gọi món, nợ, nâng cấp, clear → Ch.2 hook | Buffet, chuỗi, MP, photoreal, AI chat tự do |

---

## 15. Nhịp Chương 1

1. Tiếp quản + vay + sửa tối thiểu.  
2. Nhập hàng, mở cửa lần đầu.  
3. Khách đầu — gọi món.  
4. Quá tải bếp + staff.  
5. Quest nâng cấp bắt buộc.  
6. Trả hết nợ + đạt `V_clear` → **Chương 2**.

---

## 16. Thành công thiết kế

1. Cảm giác quán sống (không chỉ nút nâng cấp).  
2. Quyết định prep có hậu quả trong ca.  
3. Áp lực nợ → khoảnh khắc trả hết có ý nghĩa.  
4. Clear Ch.1 đo được bằng 3 điều kiện.  
5. Một ngày ổn trên thiết bị mục tiêu.

---

## 17. Xác nhận chủ SP

| # | Hạng mục | Đã ghi | Trạng thái |
|---|----------|--------|------------|
| 1 | Phục vụ MVP | Chỉ gọi món | **Đã chốt** |
| 2 | Buffet | Sau Ch.1 / lựa chọn Ch.2 danh tiếng | **Đã chốt** |
| 3 | Story | Gia đình để lại tiệm + vay sửa/mở | **Đã chốt (2A)** |
| 4 | Sau Ch.1 | Chương 2 cạnh tranh danh tiếng | **Đã chốt (3B)** |
| 5 | `V_clear` | Biến cân bằng | **Đã chốt (4A)** |
| 6 | Art / engine | Còn chọn | Mở |
| 7 | Ngôn ngữ | Tiếng Việt | Khóa |

---

## 18. Kết luận

Bản 0.3: xương trải nghiệm là **tiếp quản – vay – gọi món – trả hết nợ – nâng cấp – Ch.2**. Buffet không còn trụ MVP. Chi tiết khóa: `docs/03` v1.1.
