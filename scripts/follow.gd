extends Node2D

var bob := 0.0

func _ready() -> void:
	$SheetLens.make_current()

func _process(delta: float) -> void:
	bob += delta
	$MovingStep.position.y = 160.0 + sin(bob) * 24.0
