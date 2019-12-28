extends "res://Scripts/Ecs/Core/System.gd"

var _event_bus

func _init(event_bus):
	self.required_component_types = ["PlayerMovementComponent"]
	_event_bus = event_bus

func on_update():
	for entity in self.entities:
		var movement = Vector2()
		if Input.is_action_just_pressed("move_up"):
			movement.y -= 1
		elif Input.is_action_just_pressed("move_down"):
			movement.y += 1
		elif Input.is_action_just_pressed("move_left"):
			movement.x -= 1
		elif Input.is_action_just_pressed("move_right"):
			movement.x += 1
		
		if movement != Vector2(0, 0):
			_event_bus.emit_signal("move_entity", entity, entity.position + movement)
			end_turn()

func end_turn():
	_event_bus.emit_signal("end_turn")