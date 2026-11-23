# Tiệm Lẩu Gia Đình — Godot 4 Web Playtest

Prototype **gần MVP** theo `docs/03` v1.2:

- Chỉ **gọi món** (không buffet)
- Nhiều bàn, staff auto (sau nâng cấp), chuẩn bị mẻ/sơ chế
- Nợ vay đầu game, `V_clear`, 4 quest nâng cấp → clear Ch.1 → banner Ch.2
- Art: **placeholder khối màu**

## Yêu cầu

- [Godot 4.2+](https://godotengine.org/download) (khuyến nghị 4.2 hoặc 4.3)
- Để xuất Web: cài **Export Template** cùng phiên bản (Editor → Manage Export Templates)

## Chạy nhanh (desktop editor)

1. Mở Godot → **Import** → chọn `godot/project.godot`
2. Nhấn **F5** (Run)

### Cách chơi ngắn

1. **Chuẩn bị:** Mua thịt/rau → Nấu mẻ nước lẩu → Thái thịt / sơ chế rau  
2. **Mở cửa** — khách ngồi bàn, order tự tạo  
3. Bếp nấu → khi có **Ready**, bấm **Mang món** (hoặc thuê staff auto)  
4. Hết giờ / đóng cửa → **Báo cáo** → trả nợ → nâng cấp (click chữ *mua* trong quest) → ngày tiếp  
5. Clear Ch.1 khi: **nợ = 0** + **tiền ≥ V_clear** + **đủ 4 nâng cấp**

## Xuất bản Web (HTML5)

1. `Project → Export…` → Add **Web**  
2. Điền thư mục đích, ví dụ `godot/builds/web`  
3. Export Project  
4. Serve bằng HTTP local (không mở `index.html` bằng `file://` nếu WASM lỗi):

```powershell
cd E:\project_job\game_quan_lau\godot\builds\web
python -m http.server 8080
```

Mở `http://localhost:8080`

### Gợi ý export Web

- Rendering: **gl_compatibility** (đã set trong `project.godot`)
- Bật thread / extensions tùy trình duyệt; nếu lỗi WASM, tắt threads trong export options

## Cấu trúc

```text
godot/
  project.godot
  autoload/     # GameState, EventBus
  scenes/main.tscn
  scripts/main.gd
  icon.svg
```

Logic sim nằm ở `autoload/game_state.gd` (nguồn sự thật tiền / order / nợ).

## Phạm vi cố ý chưa có

- Buffet, FEFO/lô hàng, LLM C2, pixel art đẹp, Chương 2 gameplay đầy đủ
