extends Node
## Global signals — UI and systems subscribe here.

signal phase_changed(phase: String)
signal cash_changed(cash: int)
signal debt_changed(debt: int)
signal inventory_changed()
signal order_updated(order_id: int)
signal customer_updated(customer_id: int)
signal quest_updated()
signal day_report_ready(report: Dictionary)
signal chapter1_cleared()
signal log_message(text: String)
