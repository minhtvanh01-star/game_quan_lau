# Nghiên cứu khả thi — Game quản lý quán lẩu

| Mục | Giá trị |
|-----|---------|
| **Tên làm việc** | Hot Pot Story / Quán Lẩu Cuối Ngõ |
| **Nguồn ý tưởng** | [ChatGPT share](https://chatgpt.com/share/6b031dcd-e64c-83ec-9bd7-ac8575d6fa2e) — *Mở rộng game lẩu* |
| **Ngày nghiên cứu** | 2026-11-23 |
| **Trạng thái** | Draft v1.0 — tài liệu nội bộ team |
| **Repo** | https://github.com/minhtvanh01-star/game_quan_lau |

---

## 1. Tóm tắt điều hành

Ý tưởng **game mô phỏng quản lý quán lẩu** (buffet + gọi món, hybrid control, AI khách hàng sâu) **khả thi ở mức MVP hẹp**, nhưng **không khả thi nếu làm full scope ChatGPT đề xuất ngay từ đầu**.

| Kết luận | Chi tiết |
|----------|----------|
| **Nên làm** | 1 quán lẩu isometric 3D, hybrid buffet/gọi món, cốt truyện gia đình trả nợ, khách có cảm xúc + hội thoại có kiểm soát |
| **Nên trì hoãn** | Chuỗi chi nhánh, multiplayer, AI LLM cho mọi tương tác, DLC đa quốc gia |
| **Rủi ro lớn nhất** | Scope phình to + chi phí AI + tối ưu 3D mobile |
| **Thời gian MVP hợp lý** | 5–8 tháng với đội 4–7 người (hoặc dài hơn nếu đội nhỏ hơn) |

**Định hướng đã chốt từ chủ sản phẩm:**

- Góc nhìn: **3D isometric**
- Đồ họa: **3D** (ưu tiên stylized / dễ thương, không photoreal)
- Điều khiển: **hybrid** (đi trực tiếp + bảng quản lý)
- Mô hình nhà hàng: **hybrid** (buffet + à la carte)
- AI: **deep** (nhưng phải thiết kế theo tầng chi phí)

**Bối cảnh cốt truyện đã chốt:** gia đình nợ nần, vay vốn mở quán lẩu trong ngõ, tiết kiệm trả nợ — không phải “thừa kế quán cũ từ người thân”.

---

## 2. Nguồn và phạm vi nghiên cứu

### 2.1. Nội dung đã phân tích từ ChatGPT

Cuộc chat gồm 3 vòng:

1. **Mở rộng ý tưởng** — 8 hệ thống (nhà hàng, buffet/gọi món, khách, nhân viên, menu, tài chính, marketing, sự kiện), vòng lặp ngày, MVP 3 giai đoạn.
2. **GDD v1.0** theo định hướng isometric / 3D / hybrid / AI deep — gameplay, AI 3 tầng, kinh tế, tech stack Unity + Firebase + LLM, kế hoạch 4 giai đoạn ~22–34 tuần.
3. **Viết lại mở đầu** theo bối cảnh gia đình nợ nần + quán cuối ngõ + cơ chế trả nợ xuyên suốt.

### 2.2. Mục tiêu tài liệu này

- Lọc ý tưởng **khả thi / chưa khả thi / nên làm sau**.
- Chốt **phạm vi MVP** cho team nhiều người cùng làm.
- Đưa ra **rủi ro, chi phí, thứ tự ưu tiên** để tránh làm lan man.

*Tài liệu này không thay thế GDD chi tiết; nó là lớp nghiên cứu trước khi viết GDD/TDD chính thức.*

---

## 3. Phân tích thị trường & cạnh tranh (tóm tắt)

### 3.1. Phân khúc

| Phân khúc | Ví dụ tham chiếu | Điểm gần với ý tưởng |
|-----------|------------------|----------------------|
| Restaurant tycoon / sim | *Chef Life*, *Recipe for Disaster*, *TasteMaker* | Quản lý, xây dựng, phục vụ |
| Hotpot / Asian cooking casual | *My Hotpot Story* và các game lẩu mobile châu Á | Theme lẩu, dễ tiếp cận khu vực VN/ĐNÁ |
| Life / story sim | Các game “gia đình kinh doanh” | Cốt truyện cảm xúc, giữ chân dài hạn |

### 3.2. Khoảng trống có thể chiếm

Hầu hết game lẩu/cooking casual **yếu về chiều sâu quản lý** hoặc **yếu về tương tác khách có ngữ cảnh**.  
Điểm khác biệt khả thi của dự án:

1. **Buffet + gọi món trong cùng một quán** (cơ chế kinh tế khác nhau).
2. **Khách có cảm xúc + nhớ sở thích** (dù AI deep chỉ dùng có chọn lọc).
3. **Cốt truyện trả nợ gia đình** — động lực rõ, gần gũi văn hóa Việt.

### 3.3. Cảnh báo cạnh tranh

- Theme lẩu trên mobile đã quen thuộc → **không thắng bằng theme**, phải thắng bằng **cảm giác điều hành sống động**.
- Nếu chỉ clone idle/tycoon click-click → dễ bị coi là game “cày số”.

---

## 4. Đánh giá khả thi theo từng trụ cột

Thang điểm: **1–5** (5 = rất khả thi với đội nhỏ/trung bình).

### 4.1. Gameplay & sản phẩm

| Hạng mục | Điểm | Nhận xét |
|----------|------|----------|
| Vòng lặp ngày (chuẩn bị → phục vụ → tổng kết) | **5** | Cổ điển, dễ prototype |
| Hybrid buffet + gọi món | **4** | Khác biệt tốt; cần cân bằng kinh tế cẩn thận |
| Hybrid control (đi + quản lý) | **3** | Dễ rối UX trên mobile nếu không tự động hóa nhân viên sớm |
| Cốt truyện gia đình trả nợ | **5** | Mạnh về động lực; dễ viết nhiệm vụ |
| Chuỗi nhiều chi nhánh | **2** | Nên để sau MVP |
| Multiplayer | **1** | Không nên trong 12–18 tháng đầu |

**Kết luận:** Core loop + hybrid serving + story **khả thi**. Empire/multiplayer **chưa khả thi** ở giai đoạn này.

### 4.2. Kỹ thuật & đồ họa

| Hạng mục | Điểm | Nhận xét |
|----------|------|----------|
| Unity 3D isometric mobile | **4** | Chuẩn ngành; cần discipline tối ưu |
| 3D stylized (không photoreal) | **4** | Phù hợp mobile hơn realism |
| Môi trường 1 quán nhỏ (6–8 bàn) | **5** | Đúng cho MVP |
| Nhân viên AI hành vi (FSM/BT) | **4** | Làm được bằng game AI truyền thống |
| LLM cho mọi khách mọi lúc | **2** | Chi phí + latency + ngữ cảnh sai |
| LLM theo sự kiện (khiếu nại, VIP, tư vấn) | **3** | Khả thi nếu có backend + validator + fallback template |

**Kết luận kỹ thuật đề xuất:**

- Engine: **Unity** (C#)
- Asset: **Blender** + pack low-poly/stylized
- Backend save/analytics: **Firebase** hoặc tương đương
- AI: **backend riêng** (không nhúng API key vào client), kiến trúc 3 tầng như ChatGPT đề xuất là đúng hướng

### 4.3. AI “deep” — khả thi có điều kiện

ChatGPT đề xuất đúng nguyên tắc quan trọng:

> AI tạo đa dạng trải nghiệm; **game simulation** giữ quyền quyết định tiền / order / cảm xúc số học.

**Kiến trúc khuyến nghị (giữ nguyên hướng, siết thực thi):**

```text
Tầng 1 — Simulation (Unity): bàn, order, kho, tiền, chỉ số cảm xúc
Tầng 2 — Customer Brain: template / BT + (tuỳ chọn) LLM khi có event
Tầng 3 — Player: chọn hành động đã được whitelist
```

**Chính sách gọi AI:**

| Cấp | Khi nào dùng | Công nghệ |
|-----|--------------|-----------|
| C0 | Đi lại, ngồi, ăn, chờ, thanh toán | FSM / Behavior Tree |
| C1 | Lời thoại ngắn, phản ứng thường | Template + biến ngữ cảnh |
| C2 | Khiếu nại, tư vấn phức tạp, VIP, khách quen đặc biệt | LLM qua backend + JSON schema + validator |

**Không làm:** AI tự giảm giá, tự tạo món ngoài menu, tự sửa tiền — trừ khi action đó đã có trong whitelist gameplay.

### 4.4. Kinh tế game & monetization

| Hạng mục | Khả thi | Ghi chú |
|----------|---------|---------|
| Profit = Revenue − Expenses | Cao | Bắt buộc có từ prototype |
| Buffet: doanh thu vé vs chi phí tiêu thụ | Trung bình–cao | Đây là “USP số học” cần prototype sớm |
| Hệ thống nợ định kỳ | Cao | Gắn story + retention |
| F2P (cosmetics, season pass, ads reward) | Cao | Chỉ thiết kế sau khi core loop ổn |
| Pay-to-win cảm xúc/AI | Không nên | Phá USP |

### 4.5. Tổ chức & sản xuất

| Quy mô đội | Khả thi MVP? | Điều kiện |
|------------|--------------|-----------|
| 1–2 người | Khó trong 6 tháng | Phải cắt AI deep + cắt build sâu |
| 4–7 người | **Khả thi** | Bám P0 chặt, có producer khóa scope |
| 8+ người | Khả thi hơn | Dễ phình scope nếu không có GDD khóa |

Ước lượng ChatGPT (22–34 tuần, 6–8 người) **hợp lý cho bản chơi được có AI chọn lọc**, **không hợp lý** nếu muốn full DLC + chuỗi + AI mọi lúc.

---

## 5. Ma trận ý tưởng: Làm ngay / Làm sau / Không làm sớm

### 5.1. P0 — Bắt buộc trong MVP

- 1 quán cuối ngõ, 6–8 bàn
- Nhân vật chủ quán điều khiển trực tiếp
- Gia đình (mẹ bếp / bố hậu cần / em thu ngân) mở khóa dần
- Buffet cơ bản + gọi món
- Order pipeline: New → Preparing → Served → Completed
- Kho nguyên liệu đơn giản + hết hàng
- Nhân viên tự động làm task cơ bản
- Cảm xúc khách (hài lòng / kiên nhẫn) bằng số
- 5 nhóm khách (không cần 10)
- Nhiệm vụ Chương 1 + hệ thống trả nợ tối thiểu
- Báo cáo cuối ngày (doanh thu, chi phí, lợi nhuận, satisfaction)
- Save/load local (+ cloud sau)

### 5.2. P1 — Quan trọng sau core ổn

- AI hội thoại C2 (LLM có kiểm soát) cho khiếu nại/tư vấn
- Bộ nhớ khách quen (sở thích, lần đến)
- Nâng cấp nội thất ảnh hưởng chỉ số
- Marketing / danh tiếng đơn giản
- ~15 sự kiện có điều kiện
- UI quản lý đầy đủ (staff, finance, menu, inventory)

### 5.3. P2 — Để sau phát hành thử

- Nhiều chi nhánh / bản đồ thành phố
- DLC Japanese / Korean / Luxury
- Season pass, battle pass phức tạp
- Multiplayer / bảng xếp hạng realtime
- Photoreal graphics
- AI tự do chat không whitelist

---

## 6. Phạm vi MVP đề xuất (khóa để team làm chung)

### 6.1. Quy mô nội dung

| Thành phần | Số lượng MVP |
|------------|--------------|
| Nhà hàng | 1 (cuối ngõ) |
| Bàn | 6–8 |
| Nhân vật PC | 1 chủ quán |
| Vai gia đình | 2–3 (mở khóa) |
| Loại nhân viên thuê | 2–4 |
| Nhóm khách | 5 |
| Nước lẩu | 4–5 |
| Món | 15–20 |
| Sự kiện | 8–12 |
| Nhiệm vụ Chương 1 | 5–8 |
| Hình thức phục vụ | Buffet + gọi món |

### 6.2. Tiêu chí nghiệm thu MVP (go / no-go)

1. Chơi được **một ngày kinh doanh** từ mở cửa đến đóng cửa.
2. Buffet tính đúng **doanh thu vé vs chi phí tiêu thụ**.
3. Gọi món đi đúng pipeline, hết nguyên liệu thì fail có thông báo.
4. Nhân viên tự nhận việc cơ bản khi bật auto.
5. Khách đổi cảm xúc theo chờ món / phục vụ đúng / sự cố.
6. Cuối tuần có **áp lực trả nợ** (chưa cần game over cứng).
7. Chạy ổn định trên 1–2 máy Android tầm trung mục tiêu.
8. Save/load không mất tiến trình nhiệm vụ.

### 6.3. Cốt truyện Chương 1 (đã chốt hướng)

**Bối cảnh:** Gia đình nợ nần → vay vốn → thuê mặt bằng trong ngõ → mở quán lẩu tiết kiệm → trả nợ dần.

**Nhịp nhiệm vụ gợi ý:**

1. Dọn quán / sắp bàn / sửa bếp / nhập hàng / mở cửa  
2. Phục vụ khách đầu tiên + tư vấn menu  
3. Nhóm đông → quá tải bếp → học điều phối  
4. Thử buffet theo yêu cầu khách  
5. Khoản nợ định kỳ đầu tiên đến hạn  

**Tone:** khó khăn nhưng không bi lụy; gia đình đoàn kết; có tình huống hài; thành quả nhỏ đáng tự hào.

---

## 7. Rủi ro và biện pháp

| Rủi ro | Mức | Biện pháp |
|--------|-----|-----------|
| Scope creep (làm hết GDD ChatGPT) | Cao | Khóa P0; mọi feature mới qua “change request” |
| Chi phí LLM | Cao | Chỉ C2; cache; template fallback; rate limit |
| AI nói sai ngữ cảnh / hứa điều game không có | Cao | Context builder + JSON schema + action whitelist |
| 3D mobile nặng | Trung bình–cao | Low-poly, bake light, atlasing, LOD, giới hạn VFX |
| Hybrid UX rối | Trung bình | Auto-staff sớm; pause quản lý; tutorial ngắn |
| Kinh tế buffet mất cân bằng | Trung bình | Prototype số trước khi gắn art đẹp |
| Team nhiều người lệch hướng | Trung bình | 1 GDD sống + board nhiệm vụ theo hệ thống |

---

## 8. Kiến trúc kỹ thuật đề xuất (mức nghiên cứu)

```text
Mobile Client (Unity)
  ├─ Gameplay Core
  │   ├─ Restaurant Simulation (bàn, bếp, kho, staff)
  │   ├─ Economy & Debt
  │   └─ Customer Runtime (stats + BT)
  ├─ AI Gateway Client (chỉ event C2)
  └─ Save / Analytics Client

Backend
  ├─ Auth + Cloud Save
  ├─ AI Service
  │   ├─ Context Builder
  │   ├─ LLM Provider
  │   └─ Response Validator
  └─ Config / Remote flags (bật-tắt AI, giá buffet…)
```

**Nguyên tắc:** simulation là nguồn sự thật; AI chỉ đề xuất dialogue + suggested_actions hợp lệ.

---

## 9. Kế hoạch phát triển đề xuất (điều chỉnh thực tế)

| Giai đoạn | Thời lượng gợi ý | Kết quả |
|-----------|------------------|---------|
| **0. Research & lock** *(hiện tại)* | 1 tuần | Chốt MVP, tech, story beat |
| **1. Prototype** | 4–6 tuần | Quán nhỏ chạy được: khách–bàn–order–ngày |
| **2. Core Game** | 8–12 tuần | Buffet+gọi món, kho, staff auto, finance, nợ |
| **3. AI & Content** | 6–10 tuần | Cảm xúc sâu hơn, memory, LLM C2, quest Ch.1 |
| **4. Polish & Soft launch** | 4–6 tuần | UI/UX, perf, tutorial, telemetry |

Tổng: **~5–8 tháng** cho bản thử nghiệm có định hướng thương mại.  
Có thể chồng giai đoạn 2–3 nếu tách rõ owner từng hệ thống.

### Nhân sự tối thiểu đề xuất

| Vai trò | Số | Ghi chú |
|---------|----|---------|
| Unity gameplay | 1–2 | Core sim + control |
| 3D/UI art | 1–2 | Ưu tiên readable hơn đẹp lung linh |
| Designer | 1 | Economy + quest + balance |
| Backend/AI | 0.5–1 | Có thể giai đoạn sau mới full-time |
| QA | 0.5–1 | Từ giai đoạn 2 |

---

## 10. Quyết định còn mở (cần chốt trước khi code sâu)

Các câu hỏi ChatGPT để lại — **đề xuất mặc định của nghiên cứu này**:

| Câu hỏi | Đề xuất chốt |
|---------|--------------|
| Điều khiển nhân vật nào? | **Chủ quán** (player character) |
| Nhịp thời gian? | **Realtime + có pause** để quản lý |
| Thế giới? | **Story + sandbox nhẹ** (quest dẫn, vẫn được trang trí/tối ưu tự do trong quán) |
| Phong cách art? | **3D stylized ấm áp**, không photoreal |
| Nền tảng đầu? | **Android trước**, iOS sau khi ổn định |

Team cần confirm 5 dòng trên trước sprint prototype.

---

## 11. Kết luận & khuyến nghị hành động

1. **Ý tưởng khả thi** nếu bám MVP: một quán cuối ngõ + hybrid serving + nợ gia đình + khách có chiều sâu vừa phải.  
2. **Không khả thi / quá rủi ro** nếu làm ngay AI deep mọi lúc, chuỗi nhà hàng, multiplayer, và full GDD 15 phần trong một lần.  
3. **USP nên bảo vệ:** cảm giác “điều hành quán sống” + buffet/gọi món có số học thật + câu chuyện trả nợ.  
4. **Bước tiếp theo cho repo:**
   - Viết `02-gdd-mvp.md` (khóa quy tắc P0)
   - Viết `03-technical-design.md` (Unity scene, data model, AI API)
   - Tạo board task theo hệ thống: Sim / Economy / AI / Content / Art
   - Prototype số buffet **trước** khi polish art

---

## Phụ lục A — Mapping nhanh từ ChatGPT → quyết định nghiên cứu

| Đề xuất ChatGPT | Quyết định |
|-----------------|------------|
| Tên Hot Pot Story | Giữ làm tên làm việc; tên Việt có thể “Quán Lẩu Cuối Ngõ” |
| 8 hệ thống full | Chỉ P0–P1 trong MVP |
| AI deep | Deep theo **event**, không deep theo **mọi frame** |
| Unity + Blender + Firebase + LLM | Đồng ý hướng |
| 22–34 tuần | Đồng ý nếu khóa scope |
| Bối cảnh thừa kế quán | **Thay** bằng gia đình nợ nần / quán trong ngõ |
| Nhiệm vụ 10 khách / 5 buffet / 10 món / sat ≥70 / có lãi | Giữ làm quest mẫu Chương 1 |
| F2P cosmetics | Đồng ý thiết kế muộn, không chặn core |

## Phụ lục B — Liên kết nguồn

- Chat gốc: https://chatgpt.com/share/6b031dcd-e64c-83ec-9bd7-ac8575d6fa2e  
- Repo: https://github.com/minhtvanh01-star/game_quan_lau  
- Workspace local: `E:\project_job\quan_lau_online`
