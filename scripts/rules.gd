extends RefCounted

var on_hazard := false
var goal_taken := false

func hop_height(elapsed: float) -> float:
	var impulse := 8.0
	var gravity := 20.0
	return impulse * elapsed - 0.5 * gravity * elapsed * elapsed

func mark_hazard() -> void:
	on_hazard = true

func clear_hazard() -> void:
	on_hazard = false

func try_goal() -> bool:
	if on_hazard:
		return false
	goal_taken = true
	return true

var coyote_used := false

func coyote_hop(since_ground: float) -> bool:
	if since_ground <= 0.0 or since_ground > 0.15:
		return false
	if coyote_used:
		return false
	coyote_used = true
	return true

func may_span() -> bool:
	return goal_taken and not on_hazard
