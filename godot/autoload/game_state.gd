extends Node
## Simulation source of truth for web playtest (gọi món only, no buffet).

enum Phase { PREP, OPEN, RUSH, CLOSING, REPORT }

const V_CLEAR := 2500 ## placeholder — chốt sau playtest
const START_LOAN := 1500
const START_CASH_AFTER_LOAN := 1600
const DAY_OPEN_SECONDS := 75.0
const RUSH_START_RATIO := 0.45
const MAX_TABLES := 6
const START_TABLES := 3

var phase: Phase = Phase.PREP
var day: int = 1
var cash: int = START_CASH_AFTER_LOAN
var debt: int = START_LOAN
var time_left: float = DAY_OPEN_SECONDS
var paused: bool = false

## Inventory P0: raw vs prepped; broth batches as "soup" units.
var inv := {
	"meat_raw": 0,
	"meat_prepped": 0,
	"veg_raw": 0,
	"veg_prepped": 0,
	"soup": 0,
}

var prices_buy := {
	"meat_raw": 40,
	"veg_raw": 20,
}

var dish_menu := [
	{"id": "lau_thit", "name": "Lẩu thịt", "price": 120, "need": {"soup": 1, "meat_prepped": 2}, "cook": 4.0},
	{"id": "lau_rau", "name": "Lẩu rau", "price": 90, "need": {"soup": 1, "veg_prepped": 2}, "cook": 3.0},
	{"id": "lau_thap_cam", "name": "Lẩu thập cẩm", "price": 160, "need": {"soup": 1, "meat_prepped": 1, "veg_prepped": 1}, "cook": 5.0},
]

var unlocked_tables: int = START_TABLES
var staff_count: int = 0 ## 0 = player only; 1+ = auto server
var stove_level: int = 0 ## reduces cook time

var day_revenue: int = 0
var day_cogs: int = 0
var day_served: int = 0
var day_walkouts: int = 0
var day_satisfaction_sum: float = 0.0
var day_satisfaction_n: int = 0

## Quests / upgrades for Ch.1 clear
var upgrades_done := {
	"fix_stove": false,
	"add_table_4": false,
	"hire_staff": false,
	"add_table_5": false,
}

var _next_order_id: int = 1
var _next_customer_id: int = 1
var _staff_timer: float = 0.0

## Runtime entities (dictionaries for web prototype simplicity)
var tables: Array = [] ## {id, busy, customer_id}
var customers: Array = [] ## customer dicts
var orders: Array = [] ## order dicts
var kitchen_queue: Array = [] ## order ids cooking
var ready_queue: Array = [] ## order ids ready to deliver


func _ready() -> void:
	_reset_tables()
	EventBus.log_message.emit("Tiếp quản tiệm gia đình để lại. Đã vay %d — sửa tạm & vốn mở quán: %d." % [START_LOAN, cash])


func _reset_tables() -> void:
	tables.clear()
	for i in range(MAX_TABLES):
		tables.append({"id": i, "unlocked": i < unlocked_tables, "busy": false, "customer_id": -1})


func set_phase(p: Phase) -> void:
	phase = p
	paused = (p == Phase.PREP or p == Phase.REPORT)
	if p == Phase.OPEN:
		time_left = DAY_OPEN_SECONDS
	EventBus.phase_changed.emit(_phase_name(p))


func _phase_name(p: Phase) -> String:
	match p:
		Phase.PREP: return "Chuẩn bị"
		Phase.OPEN: return "Mở cửa"
		Phase.RUSH: return "Cao điểm"
		Phase.CLOSING: return "Đóng cửa"
		Phase.REPORT: return "Báo cáo"
	return "?"


func add_cash(delta: int) -> void:
	cash += delta
	EventBus.cash_changed.emit(cash)


func set_debt(v: int) -> void:
	debt = max(0, v)
	EventBus.debt_changed.emit(debt)


func buy(item: String, qty: int) -> bool:
	if not prices_buy.has(item):
		return false
	var cost: int = prices_buy[item] * qty
	if cash < cost:
		EventBus.log_message.emit("Không đủ tiền mua %s x%d." % [item, qty])
		return false
	add_cash(-cost)
	inv[item] = int(inv.get(item, 0)) + qty
	EventBus.inventory_changed.emit()
	EventBus.log_message.emit("Mua %s x%d (−%d)." % [item, qty, cost])
	return true


func cook_soup_batches(batches: int) -> bool:
	## 1 batch = 1 meat_raw + 1 veg_raw → 3 soup (placeholder recipe)
	var need_m := batches
	var need_v := batches
	if inv["meat_raw"] < need_m or inv["veg_raw"] < need_v:
		EventBus.log_message.emit("Thiếu nguyên liệu nấu nước lẩu.")
		return false
	inv["meat_raw"] -= need_m
	inv["veg_raw"] -= need_v
	inv["soup"] += batches * 3
	EventBus.inventory_changed.emit()
	EventBus.log_message.emit("Nấu %d mẻ nước lẩu → +%d suất." % [batches, batches * 3])
	return true


func prep_item(raw_key: String, prepped_key: String, qty: int) -> bool:
	if inv[raw_key] < qty:
		EventBus.log_message.emit("Thiếu %s để sơ chế." % raw_key)
		return false
	inv[raw_key] -= qty
	inv[prepped_key] += qty
	EventBus.inventory_changed.emit()
	EventBus.log_message.emit("Sơ chế %s x%d." % [prepped_key, qty])
	return true


func can_afford_dish(dish: Dictionary) -> bool:
	for k in dish["need"].keys():
		if int(inv.get(k, 0)) < int(dish["need"][k]):
			return false
	return true


func consume_dish(dish: Dictionary) -> bool:
	if not can_afford_dish(dish):
		return false
	var cogs := 0
	for k in dish["need"].keys():
		var q: int = dish["need"][k]
		inv[k] -= q
		## rough COGS for report
		if k == "soup":
			cogs += 25 * q
		elif k.begins_with("meat"):
			cogs += 40 * q
		else:
			cogs += 20 * q
	day_cogs += cogs
	EventBus.inventory_changed.emit()
	return true


func open_day() -> void:
	if phase != Phase.PREP:
		return
	day_revenue = 0
	day_cogs = 0
	day_served = 0
	day_walkouts = 0
	day_satisfaction_sum = 0.0
	day_satisfaction_n = 0
	customers.clear()
	orders.clear()
	kitchen_queue.clear()
	ready_queue.clear()
	_next_order_id = 1
	_next_customer_id = 1
	for t in tables:
		t["busy"] = false
		t["customer_id"] = -1
	set_phase(Phase.OPEN)
	EventBus.log_message.emit("Ngày %d — mở cửa!" % day)


func tick(delta: float) -> void:
	if paused or phase == Phase.PREP or phase == Phase.REPORT:
		return
	if phase == Phase.OPEN or phase == Phase.RUSH:
		time_left -= delta
		var ratio := 1.0 - (time_left / DAY_OPEN_SECONDS)
		if phase == Phase.OPEN and ratio >= RUSH_START_RATIO:
			set_phase(Phase.RUSH)
		if time_left <= 0.0:
			begin_closing()
	_tick_customers(delta)
	_tick_kitchen(delta)
	_tick_staff(delta)


func begin_closing() -> void:
	if phase == Phase.CLOSING or phase == Phase.REPORT:
		return
	set_phase(Phase.CLOSING)
	EventBus.log_message.emit("Đóng cửa — hoàn tất bàn đang phục vụ…")


func _finish_day_if_idle() -> void:
	if phase != Phase.CLOSING:
		return
	var any_busy := false
	for t in tables:
		if t["busy"]:
			any_busy = true
			break
	if any_busy or not kitchen_queue.is_empty() or not ready_queue.is_empty():
		return
	_emit_report()


func _emit_report() -> void:
	var sat := 0.0
	if day_satisfaction_n > 0:
		sat = day_satisfaction_sum / day_satisfaction_n
	var profit := day_revenue - day_cogs
	var report := {
		"day": day,
		"revenue": day_revenue,
		"cogs": day_cogs,
		"profit": profit,
		"served": day_served,
		"walkouts": day_walkouts,
		"satisfaction": sat,
		"cash": cash,
		"debt": debt,
		"v_clear": V_CLEAR,
	}
	set_phase(Phase.REPORT)
	EventBus.day_report_ready.emit(report)
	_check_chapter1_clear()


func pay_debt(amount: int) -> void:
	amount = mini(amount, debt)
	amount = mini(amount, cash)
	if amount <= 0:
		return
	add_cash(-amount)
	set_debt(debt - amount)
	EventBus.log_message.emit("Trả nợ %d. Còn nợ %d." % [amount, debt])
	_check_chapter1_clear()


func try_upgrade(id: String) -> bool:
	if upgrades_done.get(id, false):
		return false
	var cost := 0
	match id:
		"fix_stove":
			cost = 300
		"add_table_4":
			cost = 350
		"hire_staff":
			cost = 400
		"add_table_5":
			cost = 350
		_:
			return false
	if cash < cost:
		EventBus.log_message.emit("Không đủ tiền nâng cấp.")
		return false
	add_cash(-cost)
	upgrades_done[id] = true
	match id:
		"fix_stove":
			stove_level = 1
		"add_table_4":
			unlocked_tables = max(unlocked_tables, 4)
			_reset_tables()
		"hire_staff":
			staff_count = 1
		"add_table_5":
			unlocked_tables = max(unlocked_tables, 5)
			_reset_tables()
	EventBus.quest_updated.emit()
	EventBus.log_message.emit("Hoàn thành nâng cấp: %s (−%d)." % [id, cost])
	_check_chapter1_clear()
	return true


func upgrades_all_done() -> bool:
	for k in upgrades_done.keys():
		if not upgrades_done[k]:
			return false
	return true


func _check_chapter1_clear() -> void:
	if debt == 0 and cash >= V_CLEAR and upgrades_all_done():
		EventBus.chapter1_cleared.emit()
		EventBus.log_message.emit("CHƯƠNG 1 HOÀN THÀNH → sang Chương 2 (danh tiếng).")


func next_day() -> void:
	if phase != Phase.REPORT:
		return
	day += 1
	## Soft daily debt pressure reminder (not full interest for playtest)
	if debt > 0:
		EventBus.log_message.emit("Nhắc: còn nợ %d. Mục tiêu vốn clear %d." % [debt, V_CLEAR])
	set_phase(Phase.PREP)


func free_table_count() -> int:
	var n := 0
	for t in tables:
		if t["unlocked"] and not t["busy"]:
			n += 1
	return n


func spawn_customer() -> void:
	if phase != Phase.OPEN and phase != Phase.RUSH:
		return
	if free_table_count() <= 0:
		return
	var table = null
	for t in tables:
		if t["unlocked"] and not t["busy"]:
			table = t
			break
	if table == null:
		return
	var cid := _next_customer_id
	_next_customer_id += 1
	var dish: Dictionary = dish_menu[randi() % dish_menu.size()]
	var patience := 28.0 if phase != Phase.RUSH else 20.0
	var c := {
		"id": cid,
		"table_id": table["id"],
		"state": "ORDERING",
		"dish_id": dish["id"],
		"patience": patience,
		"patience_max": patience,
		"satisfaction": 70.0,
		"wait": 0.0,
		"order_id": -1,
		"eat_left": 0.0,
	}
	table["busy"] = true
	table["customer_id"] = cid
	customers.append(c)
	## Auto-create order
	var oid := _next_order_id
	_next_order_id += 1
	var order := {
		"id": oid,
		"customer_id": cid,
		"dish_id": dish["id"],
		"state": "CHECKING_STOCK",
		"cook_left": 0.0,
	}
	orders.append(order)
	c["order_id"] = oid
	c["state"] = "WAITING_FOOD"
	_try_accept_order(order)
	EventBus.customer_updated.emit(cid)
	EventBus.order_updated.emit(oid)


func _find_dish(id: String) -> Dictionary:
	for d in dish_menu:
		if d["id"] == id:
			return d
	return dish_menu[0]


func _try_accept_order(order: Dictionary) -> void:
	var dish := _find_dish(order["dish_id"])
	if not can_afford_dish(dish):
		order["state"] = "FAILED_STOCK"
		EventBus.log_message.emit("Hết món %s — khách chờ/đổi hoặc bỏ đi." % dish["name"])
		EventBus.order_updated.emit(order["id"])
		return
	consume_dish(dish)
	order["state"] = "PREPARING"
	var cook: float = float(dish["cook"])
	if stove_level > 0:
		cook *= 0.7
	order["cook_left"] = cook
	kitchen_queue.append(order["id"])
	EventBus.order_updated.emit(order["id"])


func _tick_kitchen(delta: float) -> void:
	var done: Array = []
	for oid in kitchen_queue:
		var order := _find_order(oid)
		if order.is_empty():
			done.append(oid)
			continue
		order["cook_left"] -= delta
		if order["cook_left"] <= 0.0:
			order["state"] = "READY"
			done.append(oid)
			ready_queue.append(oid)
			EventBus.order_updated.emit(oid)
	for oid in done:
		kitchen_queue.erase(oid)


func _tick_staff(delta: float) -> void:
	if staff_count <= 0:
		return
	if ready_queue.is_empty():
		_staff_timer = 0.0
		return
	_staff_timer += delta
	if _staff_timer >= 1.2:
		_staff_timer = 0.0
		deliver_next_ready()


func deliver_next_ready() -> bool:
	if ready_queue.is_empty():
		return false
	var oid: int = ready_queue.pop_front()
	var order := _find_order(oid)
	if order.is_empty():
		return false
	order["state"] = "SERVED"
	var c := _find_customer(order["customer_id"])
	if not c.is_empty():
		c["state"] = "EATING"
		c["eat_left"] = 6.0
		c["satisfaction"] = mini(100.0, c["satisfaction"] + 10.0)
		EventBus.customer_updated.emit(c["id"])
	EventBus.order_updated.emit(oid)
	EventBus.log_message.emit("Phục vụ món xong (order #%d)." % oid)
	return true


func _tick_customers(delta: float) -> void:
	var to_remove: Array = []
	for c in customers:
		if c["state"] == "WAITING_FOOD":
			c["wait"] += delta
			c["patience"] -= delta
			c["satisfaction"] -= delta * 0.6
			var order := _find_order(c["order_id"])
			if not order.is_empty() and order["state"] == "FAILED_STOCK":
				## Retry stock once in a while or walk out
				if c["patience"] > 8.0 and Engine.get_process_frames() % 90 == 0:
					_try_accept_order(order)
			if c["patience"] <= 0.0:
				_walkout(c)
				to_remove.append(c)
		elif c["state"] == "EATING":
			c["eat_left"] -= delta
			if c["eat_left"] <= 0.0:
				_checkout(c)
				to_remove.append(c)
	for c in to_remove:
		customers.erase(c)
	_finish_day_if_idle()


func _checkout(c: Dictionary) -> void:
	var dish := _find_dish(c["dish_id"])
	var pay: int = int(dish["price"])
	add_cash(pay)
	day_revenue += pay
	day_served += 1
	day_satisfaction_sum += c["satisfaction"]
	day_satisfaction_n += 1
	_free_table(c["table_id"])
	EventBus.log_message.emit("Khách #%d thanh toán +%d." % [c["id"], pay])


func _walkout(c: Dictionary) -> void:
	day_walkouts += 1
	day_satisfaction_sum += max(0.0, c["satisfaction"])
	day_satisfaction_n += 1
	## Cancel order if in queues
	var oid: int = c["order_id"]
	kitchen_queue.erase(oid)
	ready_queue.erase(oid)
	_free_table(c["table_id"])
	EventBus.log_message.emit("Khách #%d bỏ về (hết kiên nhẫn / hết món)." % c["id"])


func _free_table(table_id: int) -> void:
	for t in tables:
		if t["id"] == table_id:
			t["busy"] = false
			t["customer_id"] = -1
			break


func _find_order(oid: int) -> Dictionary:
	for o in orders:
		if o["id"] == oid:
			return o
	return {}


func _find_customer(cid: int) -> Dictionary:
	for c in customers:
		if c["id"] == cid:
			return c
	return {}
