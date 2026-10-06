extends AutoworkTest

const Rules = preload("res://scripts/rules.gd")

func test_hop_arc() -> void:
	var rules = Rules.new()
	assert_gt(rules.hop_height(0.2), 0.0, "rising")
	assert_lt(rules.hop_height(1.0), 0.0, "falling")

func test_hazard_blocks_goal() -> void:
	var rules = Rules.new()
	rules.mark_hazard()
	assert_false(rules.try_goal(), "hazard overlap")
	rules.clear_hazard()
	assert_true(rules.try_goal(), "goal after leaving")

func test_span_gate() -> void:
	var rules = Rules.new()
	rules.mark_hazard()
	assert_false(rules.try_goal(), "blocked")
	assert_false(rules.may_span(), "no advance on hazard")
	rules.clear_hazard()
	assert_true(rules.try_goal(), "goal")
	assert_true(rules.may_span(), "advance")
	assert_true(load("res://scenes/span.tscn") != null, "span loads")

func test_coyote_hop() -> void:
	var rules = Rules.new()
	assert_false(rules.coyote_hop(0.0), "still grounded")
	assert_true(rules.coyote_hop(0.05), "one hop")
	assert_false(rules.coyote_hop(0.05), "next hop")
