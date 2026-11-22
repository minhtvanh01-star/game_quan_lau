# Báo cáo thiết kế sản phẩm — Game quản lý quán lẩu

| Trường | Nội dung |
|--------|----------|
| **Tên làm việc** | Hot Pot Story / Quán Lẩu Cuối Ngõ |
| **Loại tài liệu** | Báo cáo thiết kế sản phẩm (Product Design Report) — bản đọc trước để phản biện |
| **Căn cứ** | `docs/01-nghien-cuu-kha-thi-game-quan-lau.md` |
| **Phiên bản** | 0.1 — Draft để chủ sản phẩm duyệt |
| **Ngày** | 2026-11-23 |
| **Trạng thái** | Chờ phản hồi chỉnh sửa; chưa khóa làm GDD thi công |

---

## 1. Mục đích và phạm vi báo cáo

Báo cáo trình bày phương án thiết kế sản phẩm game mô phỏng quản lý quán lẩu ở mức đủ chi tiết để đọc, hình dung và quyết định giữ / đổi hướng trước khi chuyển sang tài liệu thi công (GDD khóa, TDD, sprint).

Nội dung bao gồm: định vị sản phẩm, bối cảnh thế giới, ý tưởng trực quan, ngôn ngữ, môi trường kỹ thuật, hệ thống tính năng, vòng chơi, nhân vật, kinh tế, AI khách hàng, và biên giới phiên bản đầu.

Báo cáo **không** đóng vai hướng dẫn triển khai từng bước cho lập trình viên. Các khuyến nghị kỹ thuật chỉ xuất hiện ở mức định hướng sản phẩm–kỹ thuật.

---

## 2. Tóm tắt sản phẩm

### 2.1. Một câu định nghĩa

**Quán Lẩu Cuối Ngõ** là game mô phỏng–quản lý (restaurant simulation / tycoon nhẹ) trên mobile, góc nhìn 3D isometric, trong đó người chơi điều hành một quán lẩu nhỏ của gia đình đang mang nợ: kết hợp phục vụ buffet và gọi món, xử lý khách hàng có cảm xúc, cân đối dòng tiền và từng bước trả nợ để mở rộng đời sống kinh doanh của quán.

### 2.2. Trải nghiệm cốt lõi (pillars)

| Trụ | Mô tả ngắn |
|-----|------------|
| **Điều hành sống** | Quán vận hành theo ngày; khách đến–ngồi–gọi–ăn–đánh giá; nhân viên và bếp tạo áp lực thật |
| **Hai mô hình phục vụ** | Buffet (vé / tiêu thụ nguyên liệu) và gọi món (order theo pipeline) cùng tồn tại trong một mặt bằng |
| **Tương tác khách** | Khách có tính cách, kiên nhẫn, sở thích; tình huống khiếu nại / tư vấn tạo điểm nhấn |
| **Câu chuyện trả nợ** | Động lực dài hạn không phải “làm giàu ngay”, mà “nuôi quán – trả nợ – đổi đời dần” |

### 2.3. Định hướng đã tiếp nhận từ nghiên cứu khả thi

- Góc nhìn: **3D isometric**
- Đồ họa: **3D stylized** (ấm, dễ đọc, không photoreal)
- Điều khiển: **hybrid** (nhân vật chính đi lại + lớp quản lý)
- Mô hình nhà hàng: **hybrid** (buffet + à la carte)
- AI: **deep theo sự kiện** (không deep theo mọi hành vi nhỏ)
- Nền tảng ưu tiên: **Android trước**, iOS sau ổn định
- Chế độ: **single-player**

---

## 3. Định vị thị trường và đối tượng

### 3.1. Phân khúc

Sản phẩm nằm giao giữa:

1. **Restaurant management / tycoon** — xây dựng, nhân sự, tài chính, nâng cấp.
2. **Service simulation** — phục vụ bàn, xử lý order, sự cố ca làm việc.
3. **Narrative life-business** — gia đình, nợ, tiến trình cảm xúc theo chương.

### 3.2. Đối tượng người chơi mục tiêu (giả định thiết kế)

| Nhóm | Đặc điểm liên quan sản phẩm |
|------|------------------------------|
| Người chơi casual–midcore 16–35 | Phiên chơi 15–40 phút/ngày; UI mobile rõ |
| Người thích sim quản lý | Quan tâm tối ưu ca, lời lỗ, nâng cấp |
| Người thích câu chuyện gần đời | Bối cảnh gia đình Việt, quán trong ngõ |
| Người chơi ẩm thực / cozy-warm | Thẩm mỹ ấm, món ăn “nhìn ngon”, không kinh dị–sinh tồn |

### 3.3. Khác biệt dự kiến so với game lẩu casual phổ biến

Nhiều sản phẩm theme lẩu trên mobile nghiêng về click tiến trình hoặc nấu theo đơn giản. Phương án này đặt trọng tâm vào **cảm giác điều hành một quán đang sống**, với buffet có logic kinh tế riêng và khách không đồng nhất hành vi.

---

## 4. Bối cảnh và thế giới

### 4.1. Tiền đề câu chuyện

Gia đình người chơi lâm vào cảnh nợ nần sau biến cố làm ăn. Tiền tiết kiệm cạn; các khoản vay đến hạn. Sau bàn bạc, gia đình vay thêm một khoản nhỏ để thuê mặt bằng cũ **nằm sâu trong con ngõ**, tận dụng thiết bị sơ sài sẵn có, mở một quán lẩu tiết kiệm.

Không có mặt tiền đẹp, không có thương hiệu, không có chiến dịch quảng cáo lớn ở giai đoạn đầu. Mục tiêu ban đầu là **duy trì quán, kiếm tiền trả nợ, giữ gia đình đứng vững**.

### 4.2. Không gian vật lý của quán (phiên bản đầu)

| Khu vực | Vai trò trong trải nghiệm |
|---------|---------------------------|
| Lòng ngõ / mặt tiền nhỏ | Khách xuất hiện, biển hiệu đơn sơ, cảm giác “tìm thấy quán” |
| Khu bàn ăn | 6–8 bàn; chỗ ngồi quyết định sức chứa |
| Quầy / khu buffet khi mở | Bày món, bổ sung, kiểm soát hao hụt |
| Bếp nhỏ | Sơ chế, nấu nước lẩu, ra món gọi |
| Kho góc quán | Tồn kho, hết hàng, chất lượng nguyên liệu ở mức đơn giản |
| Quầy tính tiền | Kết thúc lượt khách, doanh thu ngày |

Phòng VIP, sân thượng, mặt tiền lớn và chi nhánh **không thuộc** hình ảnh phiên bản đầu.

### 4.3. Không khí và tông cảm xúc

- Khó khăn kinh tế: có thật, hiện diện qua nợ và thiếu thốn thiết bị.
- Không bi lụy dài: hội thoại gia đình ấm, có hài nhẹ, có tự hào khi qua từng mốc nhỏ.
- Thành phố nền: Việt Nam đương đại gần gũi (ngõ, xe máy xa xa, đèn vàng buổi tối) — mang tính gợi chứ không mô phỏng bản đồ thành phố thật.

### 4.4. Tiến trình thế giới theo giai đoạn nội dung

| Giai đoạn nội dung | Hình ảnh quán | Trọng tâm cảm xúc |
|--------------------|---------------|-------------------|
| 1. Quán cuối ngõ | Cũ, thiếu, gia đình tự làm | Sống sót, học vận hành |
| 2. Quán có khách quen | Gọn hơn, thêm nhân sự | Ổn định, trả nợ nhiều hơn |
| 3. Thương hiệu nhỏ | Đẹp hơn, có khách khó tính / VIP nhẹ | Danh tiếng, cạnh tranh địa phương |
| 4–5. Mở rộng (sau MVP) | Mặt bằng lớn / chuỗi | Đế chế — **ngoài phạm vi báo cáo khóa đầu** |

---

## 5. Ý tưởng trực quan (visual concept)

### 5.1. Ngôn ngữ hình ảnh tổng thể

Phương án hình ảnh đề xuất: **3D isometric stylized ấm**.

Đặc điểm hình dung:

- Camera cố định kiểu nhìn chéo từ trên xuống, đọc được toàn bộ mặt bằng quán trong một khung nhìn chính.
- Hình khối rõ, silhouette nhân vật và bàn ghế dễ nhận trên màn hình điện thoại nhỏ.
- Bảng màu ấm: gỗ nâu, đèn vàng, hơi nước lẩu, điểm nhấn đỏ ớt / xanh rau — tránh palette neon tối hoặc cyberpunk.
- Chất liệu “sạch sẽ dễ thương” hơn là mô phỏng thực tế dầu mỡ nặng; vẫn giữ chi tiết ẩm thực đủ hấp dẫn (nồi lẩu sủi tăm, khay thịt xếp lớp).

### 5.2. Tham chiếu cảm giác (không phải clone)

| Khía cạnh | Cảm giác hướng tới |
|-----------|-------------------|
| Mặt bằng quán | Quản lý nhà hàng isometric đọc layout rõ |
| Nhân vật | Tỷ lệ chibi–stylized nhẹ hoặc low-poly dễ thương; biểu cảm đọc được từ xa |
| Món ăn | Icon/prop “food readability” cao — màu và hình nhận món nhanh |
| UI | Tối giản, icon lớn, ít chồng lớp trong giờ cao điểm |

### 5.3. Nhịp thị giác theo thời gian trong ngày

- Sáng / chuẩn bị: ánh sáng trung tính, quán vắng, việc sắp xếp nổi bật.
- Trưa–tối cao điểm: mật độ nhân vật tăng, hơi nước, thông báo sự cố dày hơn.
- Đóng cửa: báo cáo, ánh sáng dịu, hội thoại gia đình ngắn.

### 5.4. Những gì hình ảnh **không** hướng tới ở bản đầu

- Photoreal, ray tracing nặng.
- Thành phố mở lớn đi bộ tự do ngoài quán.
- Cutscene điện ảnh dài thay cho gameplay.

---

## 6. Ngôn ngữ và bản địa hóa

### 6.1. Ngôn ngữ sản phẩm

| Lớp | Phương án đề xuất |
|-----|-------------------|
| **Ngôn ngữ thiết kế & nội bộ team** | Tiếng Việt (tài liệu, quest, hội thoại gốc) |
| **Ngôn ngữ phát hành bản đầu (soft launch nội địa)** | **Tiếng Việt** là mặc định |
| **Ngôn ngữ kỹ thuật trong code** | Tiếng Anh cho identifier, API, schema (chuẩn team kỹ thuật) |
| **Tên thương mại** | Song song: tên Việt cảm xúc (*Quán Lẩu Cuối Ngõ*) + tên quốc tế làm việc (*Hot Pot Story*) — quyết định cuối khi chuẩn bị store listing |

### 6.2. Giọng văn trong game (copy tone)

- Hội thoại gia đình: gần gũi, ngắn, không sáo.
- Khách hàng: đa dạng theo nhóm (lịch sự / hấp tấp / khó tính), vẫn trong khung nội dung an toàn.
- UI hệ thống: rõ nghĩa nghiệp vụ (doanh thu, tồn kho, nợ đến hạn).

### 6.3. Định hướng bản địa hóa sau này

Kiến trúc chuỗi chữ (string table) tách khỏi logic ngay từ đầu để sau này thêm **English** và có thể thêm ngôn ngữ khu vực. Bản English không phải điều kiện ra MVP nội địa.

### 6.4. Đơn vị và quy ước hiển thị

- Tiền trong fiction: **VND quy ước trong game** (có thể rút gọn hiển thị: `12.5tr`) để khớp bối cảnh Việt.
- Thời gian trong ngày: khung giờ mô phỏng (không cần đồng hồ realtime 1:1 với đời thực).

---

## 7. Môi trường kỹ thuật (định hướng sản phẩm–kỹ thuật)

Phần này mô tả **môi trường dự kiến** để sản phẩm khớp ràng buộc mobile và AI; chưa phải đặc tả kiến trúc chi tiết.

| Thành phần | Phương án |
|------------|-----------|
| Game engine | **Unity** (C#), build mobile |
| Không gian 3D | Scene isometric, asset stylized / low-poly |
| Công cụ art | Blender + pipeline texture atlas |
| Lưu tiến trình | Local trước; cloud save (Firebase hoặc tương đương) ở giai đoạn sau |
| AI hội thoại sâu | Service backend riêng; client chỉ gửi ngữ cảnh sự kiện và nhận JSON đã kiểm |
| Phân tích / cấu hình | Remote config cho giá trị cân bằng và cờ bật–tắt AI |
| Thiết bị mục tiêu ban đầu | Android tầm trung phổ biến tại Việt Nam |

Nguyên tắc kỹ thuật gắn sản phẩm: **lớp mô phỏng quán** giữ quyền quyết định tiền bạc, order và chỉ số cảm xúc; lớp AI chỉ làm phong phú hội thoại và gợi ý hành động nằm trong danh mục hệ thống cho phép.

---

## 8. Gameplay tổng quan

### 8.1. Vai trò người chơi

Người chơi hóa thân **chủ quán / thành viên gia đình đứng tên điều hành**: đi lại trong mặt bằng, tương tác khách và thiết bị, đồng thời mở lớp quản lý để phân việc, xem tài chính, chỉnh menu và nhập hàng.

### 8.2. Nhịp thời gian

Phương án đề xuất: **mô phỏng thời gian thực trong ngày chơi**, kèm khả năng **tạm dừng / chậm** để thao tác quản lý. Ngày chơi kết thúc bằng báo cáo và đoạn hội thoại gia đình ngắn.

### 8.3. Vòng lặp một ngày (core loop)

```text
Chuẩn bị (nguyên liệu, nhân sự, vệ sinh, menu)
    → Mở cửa / đón khách / xếp bàn
    → Phục vụ (buffet và/hoặc gọi món) + xử lý sự cố
    → Cao điểm (áp lực bếp, nhân viên, cảm xúc khách)
    → Đóng cửa / đối soát
    → Báo cáo ngày + tiến độ nợ / nhiệm vụ
    → Nâng cấp nhỏ hoặc chuẩn bị ngày kế
```

### 8.4. Hai lớp điều khiển

| Lớp | Nội dung tiêu biểu |
|-----|--------------------|
| Trực tiếp | Di chuyển, chào khách, mang món, xử lý sự cố tại chỗ, tương tác bàn/buffet |
| Quản lý | Phân ca, đặt hàng kho, giá buffet, xem lời lỗ, nâng cấp thiết bị |

Ở đầu game, tỷ trọng thao tác trực tiếp cao. Khi nhân sự và tự động hóa tăng, tỷ trọng chuyển dần sang quyết định quản lý — tạo cảm giác “lớn lên cùng quán”.

---

## 9. Hệ thống tính năng (mô tả sản phẩm)

### 9.1. Đón khách và xếp bàn

Khách xuất hiện ở cửa/ngõ; hệ thống xét số người và bàn trống; lễ tân hoặc người chơi xếp chỗ. Bàn mang thuộc tính sức chứa, độ sạch, vị trí (gần lối đi / góc yên). Tình huống điển hình: hết bàn, khách muốn đổi chỗ, khách đặt trước (ở mức đơn giản sau này).

### 9.2. Gọi món (à la carte)

Luồng trạng thái đề xuất:

`New → Confirmed → Preparing → Ready → Served → Completed`  
(kèm nhánh hủy / hết nguyên liệu)

Người chơi hoặc nhân viên nhận order; bếp tiêu thụ kho; món ra bàn ảnh hưởng thời gian chờ và điểm hài lòng.

### 9.3. Buffet

Khách trả theo suất/vé trong khung thời gian quy định; tự lấy tại quầy; nhân viên bổ sung; hệ thống ghi nhận tiêu thụ nguyên liệu và thức ăn thừa ở mức trừu tượng hóa gameplay.

Các bậc buffet (mở dần theo tiến trình): Basic → Standard → Premium (Luxury để sau). Giá vé và thành phần quầy tạo đánh đổi lời/lỗ rõ.

### 9.4. Bếp và kho

Bếp có công suất và thời gian chế biến; nâng cấp thiết bị làm tăng thông lượng. Kho theo dõi số lượng, giá nhập, và ở mức MVP có thể có giảm chất lượng / hết hạn đơn giản để tạo áp lực nhập hàng — không cần mô phỏng an toàn thực phẩm pháp lý phức tạp.

### 9.5. Nhân sự

Vai trò: lễ tân, phục vụ, bếp, bổ sung buffet, thu ngân, tạp vụ (mở dần). Mỗi nhân viên có tốc độ, thái độ, bền bỉ, lương, mệt. Nhân viên tự nhận việc khi bật điều phối tự động; người chơi can thiệp khi quá tải.

Gia đình đóng vai trò nhân sự khởi đầu với sắc thái cốt truyện (xem mục 10).

### 9.6. Cảm xúc và hồ sơ khách

Chỉ số đề xuất: hài lòng, kiên nhẫn, nhu cầu ăn, tin tưởng, thiện cảm. Tác động từ chờ đợi, đúng món, thái độ xử lý sự cố, không gian bàn. Lịch sử ghé quán tích lũy thành khách quen (ở lớp P1 đầy đủ hơn).

Nhóm khách phiên bản đầu (5 nhóm): cặp đôi, gia đình, nhóm bạn, khách công việc, người lớn tuổi — bổ sung blogger / VIP ở nội dung sau.

### 9.7. Tài chính, nợ và danh tiếng

Cuối ngày: doanh thu, chi phí, lợi nhuận, mức hài lòng trung bình.  
Tuần: áp lực trả nợ định kỳ; trả đúng hạn ảnh hưởng uy tín tài chính trong fiction.  
Danh tiếng (mở dần): ảnh hưởng lưu lượng khách và phân khúc.

### 9.8. Nhiệm vụ và sự kiện

Nhiệm vụ chương gắn mốc kinh doanh cụ thể (phục vụ N khách, bán buffet, đạt satisfaction, có lãi ngày…). Sự kiện có điều kiện (cao điểm đột biến, hết hàng, khách khó tính, blogger…) xuất hiện theo trạng thái quán chứ không thuần ngẫu nhiên vô nghĩa.

### 9.9. Xây dựng và nâng cấp (phạm vi hẹp bản đầu)

Đặt/thay bàn ghế, đèn, một phần trang trí; nâng cấp bếp và quầy. Chỉ số tiện nghi ảnh hưởng thoải mái khách ở mức đơn giản. Mở rộng diện tích lớn và nhiều theme quốc gia thuộc giai đoạn sau.

---

## 10. Nhân vật và quan hệ

### 10.1. Nhân vật điều khiển

**Chủ quán (người chơi)** — quyết định kinh doanh, giao tiếp khách, xử lý sự cố, là khuôn mặt thương hiệu nhỏ của gia đình.

### 10.2. Gia đình (mở khóa dần)

| Nhân vật | Vai trò gameplay | Sắc thái chuyện |
|----------|------------------|-----------------|
| Mẹ | Bếp / nước lẩu / công thức | Gốc rễ ẩm thực, lo toan |
| Bố | Hậu cần / nhập hàng / sửa chữa | Thực tế chi phí, nợ |
| Em (ví dụ em gái) | Thu ngân / order / hỗ trợ khách | Năng động, cầu nối thế hệ |

### 10.3. Quan hệ với khách

Khách không chỉ là “unit doanh thu”. Một số khách có câu thoại nhận diện; khách quen tạo phần thưởng tiến trình và cảm giác được nhớ — phù hợp trụ tương tác sâu nhưng vẫn kiểm soát được chi phí AI.

---

## 11. Ẩm thực và nội dung món (khung)

### 11.1. Nước lẩu (mở dần ~4–5 loại bản đầu)

Ví dụ khung: lẩu nấm, cà chua, kim chi, Thái, Tứ Xuyên (cay). Phân loại theo độ cay và đối tượng (trẻ nhỏ / người lớn tuổi).

### 11.2. Nhóm món

Thịt, hải sản, rau–nấm, viên thả, tinh bột (mì/bún), đồ uống. Khoảng **15–20 món** cho bản đầu là đủ để buffet và gọi món có lựa chọn mà không phình dữ liệu.

### 11.3. Đọc thiết kế ẩm thực

Món là **công cụ gameplay** (thời gian chế biến, giá vốn, sở thích nhóm khách) trước khi là catalog ẩm thực đầy đủ miền.

---

## 12. AI khách hàng trong thiết kế sản phẩm

### 12.1. Vai trò AI đối với trải nghiệm

AI phục vụ đa dạng hội thoại và tình huống, làm khách “có vẻ nhớ và có phản ứng đúng ngữ cảnh”. AI không thay thế luật kinh tế và luật order.

### 12.2. Phân tầng trải nghiệm

| Tầng trải nghiệm | Hiện diện với người chơi | Cơ chế nền |
|------------------|--------------------------|------------|
| Sinh hoạt thường | Khách đi, ngồi, ăn, chờ, trả tiền | Hành vi mô phỏng cổ điển |
| Phản ứng ngắn | Câu thoại nhanh, biểu cảm | Mẫu thoại + biến ngữ cảnh |
| Tình huống sâu | Khiếu nại, tư vấn phức tạp, VIP | AI ngôn ngữ qua backend, hành động gợi ý bị giới hạn danh mục |

### 12.3. Ranh giới nội dung

Mọi lời hứa trong hội thoại (giảm giá, đổi món, ưu tiên) chỉ hợp lệ khi hệ thống gameplay có hành động tương ứng. Đây là ràng buộc thiết kế sản phẩm, không chỉ là chi tiết kỹ thuật.

---

## 13. Giao diện và điều khiển (hình dung sản phẩm)

### 13.1. Màn hình vận hành chính

- Trên trái: tiền, cấp/danh tiếng, nợ (rút gọn).
- Trên phải: nhiệm vụ, thông báo sự cố.
- Giữa: mặt bằng 3D isometric.
- Dưới: điều khiển nhân vật + hành động nhanh; thanh quản lý (nhân sự, kho, menu, tài chính, nâng cấp).

### 13.2. Các không gian UI chức năng

Nhà hàng · Khách · Nhân sự · Thực đơn · Kho · Tài chính · Xây/nâng cấp · (Bản đồ/mở rộng — sau MVP).

### 13.3. Nguyên tắc UX gắn hybrid control

Giờ cao điểm ưu tiên thông tin sự cố và hành động một chạm. Màn hình quản lý sâu không che toàn bộ quán quá lâu mà không có pause.

---

## 14. Mô hình nội dung phiên bản và biên giới

### 14.1. Phạm vi bản đọc thiết kế này hướng tới (MVP sản phẩm)

| Hạng mục | Quy mô định hướng |
|----------|-------------------|
| Số quán | 1 |
| Bàn | 6–8 |
| Nhóm khách | 5 |
| Nước lẩu | 4–5 |
| Món | 15–20 |
| Sự kiện | 8–12 |
| Nhiệm vụ Chương 1 | 5–8 |
| Hình thức phục vụ | Buffet + gọi món |
| AI sâu | Theo sự kiện chọn lọc |

### 14.2. Ngoài biên giới bản đầu (ghi nhận để không lẫn vào duyệt lần này)

Chuỗi chi nhánh, multiplayer, DLC theme quốc gia đầy đủ, photoreal, AI chat tự do không danh mục hành động, season pass phức tạp, pay-to-win cảm xúc.

### 14.3. Hướng mở sau khi bản đầu đứng vững

Theme ẩm thực / không gian mới; khách VIP và memory sâu; marketing và cạnh tranh địa phương; mở rộng mặt bằng; về lâu dài mới xét chuỗi.

---

## 15. Minh họa nhịp Chương 1 (để hình dung, chưa khóa số liệu cuối)

1. Dọn quán, kê bàn, sửa bếp, nhập hàng, mở cửa lần đầu.  
2. Khách đầu tiên — chào hỏi, giới thiệu nước lẩu, hoàn tất một lượt phục vụ.  
3. Nhóm đông — quá tải bếp, học điều phối.  
4. Yêu cầu buffet — mở mô hình kết hợp, đối mặt hao nguyên liệu.  
5. Khoản nợ định kỳ đầu — đối soát lời lỗ thật.

Phần thưởng minh họa đã xuất hiện trong nghiên cứu: tiền vận hành, thêm nhân sự phục vụ, công thức nước lẩu nấm, mở lớp trả nợ — **số liệu cụ thể còn là biến số cân bằng**, không phải cam kết cứng trong báo cáo này.

---

## 16. Tiêu chí thành công sản phẩm (góc nhìn thiết kế)

Bản đầu được xem là đạt ý đồ thiết kế khi người chơi:

1. Cảm nhận quán như một hệ thống đang chạy, không chỉ là chuỗi nút nâng cấp.
2. Phân biệt được áp lực kinh tế của buffet và gọi món.
3. Gắn bó với động lực trả nợ gia đình qua các mốc nhỏ.
4. Gặp đủ tình huống khách để thấy “mỗi ngày khác nhau”, dù AI sâu chưa phủ mọi tương tác.
5. Hoàn thành được vòng một ngày ổn định trên thiết bị mục tiêu.

---

## 17. Các điểm cần chủ sản phẩm xác nhận hoặc chỉnh

Các mục dưới đây ảnh hưởng trực tiếp đến tài liệu khóa tiếp theo. Phản hồi “giữ / đổi” cho từng dòng là đủ để cập nhật báo cáo.

| # | Hạng mục | Phương án đang ghi trong báo cáo | Ghi chú phản hồi |
|---|----------|----------------------------------|------------------|
| 1 | Tên hiển thị chính | Quán Lẩu Cuối Ngõ (VN) / Hot Pot Story (làm việc) | |
| 2 | Ngôn ngữ bản đầu | Tiếng Việt | |
| 3 | Nền tảng đầu | Android trước | |
| 4 | Art direction | 3D isometric stylized ấm | |
| 5 | Nhân vật điều khiển | Chủ quán đi trực tiếp | |
| 6 | Nhịp thời gian | Realtime + pause quản lý | |
| 7 | Tiền trong fiction | VND quy ước | |
| 8 | Bối cảnh | Gia đình nợ — quán trong ngõ | |
| 9 | AI sâu | Chỉ tình huống C2 có kiểm soát | |
| 10 | Phạm vi bản đầu | 1 quán, không chuỗi/multiplayer | |
| 11 | Tone chuyện | Khó khăn nhưng ấm, không bi lụy | |
| 12 | Đơn vị team docs | Tiếng Việt | |

---

## 18. Kết luận báo cáo

Phương án thiết kế hiện tại hình thành một sản phẩm **rõ trụ trải nghiệm**: điều hành quán lẩu hybrid trong bối cảnh gia đình trả nợ, với hình ảnh isometric ấm và tương tác khách có chiều sâu có kiểm soát. Biên giới bản đầu được giữ hẹp có chủ đích để sản phẩm đọc được, chơi được và phản biện được trước khi đội ngũ khóa GDD thi công.

Báo cáo này là **bản đọc trước**. Mọi thay đổi về bối cảnh, ngôn ngữ, hình ảnh, nền tảng hay độ sâu AI sau vòng phản hồi sẽ được cập nhật thành phiên bản 0.2 trước khi tách thành bộ tài liệu thi công chi tiết.

---

## Phụ lục A — Thuật ngữ dùng trong báo cáo

| Thuật ngữ | Nghĩa trong tài liệu |
|-----------|----------------------|
| MVP / bản đầu | Phiên bản sản phẩm hẹp đủ chứng minh trụ trải nghiệm |
| Hybrid serving | Đồng thời buffet và gọi món |
| Hybrid control | Vừa điều khiển nhân vật vừa quản lý bằng UI |
| P0 / P1 / P2 | Lớp ưu tiên phạm vi theo nghiên cứu khả thi |
| C0 / C1 / C2 | Tầng hành vi–hội thoại khách từ mô phỏng đến AI ngôn ngữ |

## Phụ lục B — Tài liệu liên quan

- Nghiên cứu khả thi: `docs/01-nghien-cuu-kha-thi-game-quan-lau.md`
- Repo: https://github.com/minhtvanh01-star/game_quan_lau
- Nguồn ý tưởng ban đầu (tham chiếu): https://chatgpt.com/share/6b031dcd-e64c-83ec-9bd7-ac8575d6fa2e
