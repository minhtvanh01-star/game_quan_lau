# game_quan_lau

Game mô phỏng quản lý quán lẩu (chuẩn bị trước giờ mở + **gọi món**) — chơi đơn.  
Cốt truyện: gia đình để lại tiệm → vay nợ sửa/mở → trả hết nợ → Chương 2.

## Chạy thử (ưu tiên hiện tại)

**Godot 4 Web / Editor playtest** — thư mục [`godot/`](godot/README.md)

1. Cài Godot 4.2+  
2. Import `godot/project.godot` → F5  
3. Xuất Web khi cần playtest trình duyệt (xem `godot/README.md`)

Art giai đoạn này: **placeholder khối màu**. Engine playtest: **Godot 4** (không Unity).

## Tài liệu

| File | Mô tả |
|------|-------|
| [docs/03-bao-cao-thiet-ke-hoan-thien.md](docs/03-bao-cao-thiet-ke-hoan-thien.md) | Báo cáo hoàn thiện — khóa hướng MVP |
| [docs/01-nghien-cuu-kha-thi-game-quan-lau.md](docs/01-nghien-cuu-kha-thi-game-quan-lau.md) | Nghiên cứu khả thi |
| [docs/02-bao-cao-thiet-ke-san-pham.md](docs/02-bao-cao-thiet-ke-san-pham.md) | Thiết kế sản phẩm |
| [godot/README.md](godot/README.md) | Hướng dẫn chạy / export Web |

## Định hướng đã khóa

- Playtest: **Godot 4 → Web** trước; native sau  
- Core: mua → chuẩn bị → **gọi món** → báo cáo → nợ/nâng cấp  
- **Không buffet trong MVP**  
- Story: tiệm để lại + vay; clear Ch.1 = hết nợ + `V_clear` + nâng cấp → **Ch.2**  
- Phạm vi web v0: gần MVP (nhiều bàn, staff auto, quest, clear)  
