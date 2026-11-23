extends Control
## Web playtest UI — placeholder shapes, gần MVP loop.

@onready var hud_phase: Label = %HudPhase
@onready var hud_day: Label = %HudDay
@onready var hud_cash: Label = %HudCash
@onready var hud_debt: Label = %HudDebt
@onready var hud_vclear: Label = %HudVClear
@onready var hud_time: Label = %HudTime
@onready var hud_inv: Label = %HudInv
@onready var log_box: RichTextLabel = %LogBox
@onready var floor_draw: Control = %Floor
@onready var quest_box: RichTextLabel = %QuestBox
@onready var report_panel: PanelContainer = %ReportPanel
@onready var report_label: RichTextLabel = %ReportLabel
@onready var clear_banner: Label = %ClearBanner

var _spawn_acc: float = 0.0


func _ready() -> void:
	randomize()
	EventBus.phase_changed.connect(_on_phase)
	EventBus.cash_changed.connect(func(v): hud_cash.text = "Tiền: %d" % v)
	EventBus.debt_changed.connect(func(v): hud_debt.text = "Nợ: %d" % v)
	EventBus.inventory_changed.connect(_refresh_inv)
	EventBus.log_message.connect(_on_log)
	EventBus.day_report_ready.connect(_on_report)
	EventBus.quest_updated.connect(_refresh_quests)
	EventBus.chapter1_cleared.connect(_on_cleared)
	report_panel.visible = false
	clear_banner.visible = false
	_refresh_all()
	_on_log("Playtest Web — chỉ gọi món. Art placeholder. Mục tiêu: trả hết nợ + vốn ≥ %d + 4 nâng cấp." % GameState.V_CLEAR)


func _process(delta: float) -> void:
	GameState.tick(delta)
	if GameState.phase == GameState.Phase.OPEN or GameState.phase == GameState.Phase.RUSH:
		hud_time.text = "Thời gian: %.0fs" % GameState.time_left
		_spawn_acc += delta
		var interval := 5.0 if GameState.phase == GameState.Phase.OPEN else 3.0
		if _spawn_acc >= interval:
			_spawn_acc = 0.0
			GameState.spawn_customer()
		floor_draw.queue_redraw()
	elif GameState.phase == GameState.Phase.CLOSING:
		floor_draw.queue_redraw()
		hud_time.text = "Đang đóng cửa…"


func _refresh_all() -> void:
	hud_day.text = "Ngày %d" % GameState.day
	hud_cash.text = "Tiền: %d" % GameState.cash
	hud_debt.text = "Nợ: %d" % GameState.debt
	hud_vclear.text = "V_clear: %d" % GameState.V_CLEAR
	hud_phase.text = "Pha: %s" % GameState._phase_name(GameState.phase)
	_refresh_inv()
	_refresh_quests()
	floor_draw.queue_redraw()


func _refresh_inv() -> void:
	var i := GameState.inv
	hud_inv.text = "Kho | thịt thô %d / thái %d | rau thô %d / sơ chế %d | nước lẩu %d" % [
		i["meat_raw"], i["meat_prepped"], i["veg_raw"], i["veg_prepped"], i["soup"]
	]


func _refresh_quests() -> void:
	var u := GameState.upgrades_done
	var lines := [
		"[b]Nhiệm vụ nâng cấp Ch.1[/b]",
		_q("fix_stove", "Sửa bếp (−300)", u["fix_stove"]),
		_q("add_table_4", "Thêm bàn 4 (−350)", u["add_table_4"]),
		_q("hire_staff", "Thuê 1 phục vụ auto (−400)", u["hire_staff"]),
		_q("add_table_5", "Thêm bàn 5 (−350)", u["add_table_5"]),
		"",
		"Clear: nợ=0 · tiền≥%d · đủ 4 nâng cấp" % GameState.V_CLEAR,
		"Staff: %d | Bàn mở: %d | Bếp Lv: %d" % [GameState.staff_count, GameState.unlocked_tables, GameState.stove_level],
	]
	quest_box.text = "\n".join(lines)


func _q(id: String, label: String, done: bool) -> String:
	return ("[color=green]✓[/color] " if done else "[color=orange]○[/color] ") + "%s  [url=%s]mua[/url]" % [label, id]


func _on_phase(p: String) -> void:
	hud_phase.text = "Pha: %s" % p
	hud_day.text = "Ngày %d" % GameState.day
	report_panel.visible = (GameState.phase == GameState.Phase.REPORT)
	floor_draw.queue_redraw()


func _on_log(text: String) -> void:
	log_box.append_text(text + "\n")


func _on_report(report: Dictionary) -> void:
	report_panel.visible = true
	report_label.text = "\n".join([
		"[b]Báo cáo ngày %d[/b]" % report["day"],
		"Doanh thu: %d" % report["revenue"],
		"COGS: %d" % report["cogs"],
		"Lợi nhuận ngày: %d" % report["profit"],
		"Phục vụ: %d | Bỏ về: %d" % [report["served"], report["walkouts"]],
		"Hài lòng TB: %.0f" % report["satisfaction"],
		"Tiền: %d | Nợ: %d | V_clear: %d" % [report["cash"], report["debt"], report["v_clear"]],
	])


func _on_cleared() -> void:
	clear_banner.visible = true


func _on_open_pressed() -> void:
	GameState.open_day()
	_spawn_acc = 2.0


func _on_buy_meat() -> void:
	GameState.buy("meat_raw", 5)


func _on_buy_veg() -> void:
	GameState.buy("veg_raw", 5)


func _on_cook_soup() -> void:
	GameState.cook_soup_batches(1)


func _on_prep_meat() -> void:
	GameState.prep_item("meat_raw", "meat_prepped", 3)


func _on_prep_veg() -> void:
	GameState.prep_item("veg_raw", "veg_prepped", 3)


func _on_deliver() -> void:
	if not GameState.deliver_next_ready():
		EventBus.log_message.emit("Không có món READY để mang.")


func _on_close_now() -> void:
	GameState.begin_closing()


func _on_pay_debt_200() -> void:
	GameState.pay_debt(200)


func _on_pay_debt_all() -> void:
	GameState.pay_debt(GameState.debt)


func _on_next_day() -> void:
	GameState.next_day()
	report_panel.visible = false
	_refresh_all()


func _on_quest_meta_clicked(meta: Variant) -> void:
	GameState.try_upgrade(str(meta))
	_refresh_quests()


func _on_floor_draw() -> void:
	var c := floor_draw.get_theme_default_font() if false else null
	var size := floor_draw.size
	## Floor background
	floor_draw.draw_rect(Rect2(Vector2.ZERO, size), Color(0.18, 0.16, 0.14))
	## Kitchen zone
	floor_draw.draw_rect(Rect2(20, 20, 200, 120), Color(0.35, 0.25, 0.2))
	floor_draw.draw_string(ThemeDB.fallback_font, Vector2(30, 45), "BẾP / SƠ CHẾ", HORIZONTAL_ALIGNMENT_LEFT, -1, 14, Color(1, 0.9, 0.7))
	floor_draw.draw_string(ThemeDB.fallback_font, Vector2(30, 70), "Queue: %d" % GameState.kitchen_queue.size(), HORIZONTAL_ALIGNMENT_LEFT, -1, 12, Color(0.9, 0.85, 0.7))
	floor_draw.draw_string(ThemeDB.fallback_font, Vector2(30, 90), "Ready: %d" % GameState.ready_queue.size(), HORIZONTAL_ALIGNMENT_LEFT, -1, 12, Color(0.7, 1, 0.7))
	## Tables
	var cols := 3
	for t in GameState.tables:
		var idx: int = t["id"]
		var col := idx % cols
		var row := idx / cols
		var pos := Vector2(280 + col * 140, 40 + row * 120)
		var colr := Color(0.25, 0.25, 0.28)
		if not t["unlocked"]:
			colr = Color(0.12, 0.12, 0.12)
		elif t["busy"]:
			colr = Color(0.55, 0.35, 0.2)
		else:
			colr = Color(0.3, 0.45, 0.35)
		floor_draw.draw_rect(Rect2(pos, Vector2(110, 90)), colr)
		var label := "Bàn %d" % (idx + 1)
		if not t["unlocked"]:
			label += " (khóa)"
		floor_draw.draw_string(ThemeDB.fallback_font, pos + Vector2(8, 20), label, HORIZONTAL_ALIGNMENT_LEFT, -1, 12, Color.WHITE)
		if t["busy"]:
			var cust := GameState._find_customer(t["customer_id"])
			if not cust.is_empty():
				floor_draw.draw_string(ThemeDB.fallback_font, pos + Vector2(8, 42), cust["state"], HORIZONTAL_ALIGNMENT_LEFT, -1, 11, Color(1, 0.95, 0.8))
				floor_draw.draw_string(ThemeDB.fallback_font, pos + Vector2(8, 60), "kiên nhẫn %.0f" % cust["patience"], HORIZONTAL_ALIGNMENT_LEFT, -1, 11, Color(0.9, 0.8, 0.7))
	## Staff marker
	if GameState.staff_count > 0:
		floor_draw.draw_circle(Vector2(140, 180), 14, Color(0.4, 0.6, 0.95))
		floor_draw.draw_string(ThemeDB.fallback_font, Vector2(100, 210), "Staff auto", HORIZONTAL_ALIGNMENT_LEFT, -1, 12, Color(0.7, 0.85, 1))
	var _unused = c
