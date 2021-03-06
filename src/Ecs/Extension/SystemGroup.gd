extends Node2D

const DisplaySystem = preload("res://Ecs/Systems/DisplaySystem.gd")
const FovSystem = preload("res://Ecs/Systems/FovSystem.gd")
const PlayerMovementSystem = preload("res://Ecs/Systems/PlayerMovementSystem.gd")
const EntityMovementSystem = preload("res://Ecs/Systems/EntityMovementSystem.gd")
const CameraSystem = preload("res://Ecs/Systems/CameraSystem.gd")
const CombatSystem = preload("res://Ecs/Systems/CombatSystem.gd")
const ChasePlayerSystem = preload("res://Ecs/Systems/ChasePlayerSystem.gd")
const HealthBarSystem = preload("res://Ecs/Systems/HealthBarSystem.gd")
const DamageSystem = preload("res://Ecs/Systems/DamageSystem.gd")
const SkillSelectSystem = preload("res://Ecs/Systems/SkillSelectSystem.gd")
const TargetedSkillSystem = preload("res://Ecs/Systems/TargetedSkillSystem.gd")
const SetPlayerSystem = preload("res://Ecs/Systems/SetPlayerSystem.gd")
const ActivateTileSystem = preload("res://Ecs/Systems/ActivateTileSystem.gd")
const PlayerSwitchSystem = preload("res://Ecs/Systems/PlayerSwitchSystem.gd")
const SelfSkillSystem = preload("res://Ecs/Systems/SelfSkillSystem.gd")
const EffectsDisplaySystem = preload("res://Ecs/Systems/EffectsDisplaySystem.gd")
const DamageModifierSystem = preload("res://Ecs/Systems/DamageModifierSystem.gd")
const SkillMenuSystem = preload("res://Ecs/Systems/SkillMenuSystem.gd")
const StunSystem = preload("res://Ecs/Systems/StunSystem.gd")
const ExplosionSystem = preload("res://Ecs/Systems/ExplosionSystem.gd")
const StatusEffectsSystem = preload("res://Ecs/Systems/StatusEffectsSystem.gd")
const HealSystem = preload("res://Ecs/Systems/HealSystem.gd")

# skill systems
const StunPistolSystem = preload("res://Skills/Systems/StunPistolSystem.gd")
const RocketLauncherSystem = preload("res://Skills/Systems/RocketLauncherSystem.gd")
const LightningCannonSystem = preload("res://Skills/Systems/LightningCannonSystem.gd")
const EnergyShieldSystem = preload("res://Skills/Systems/EnergyShieldSystem.gd")
const HealSelfSystem = preload("res://Skills/Systems/HealSelfSystem.gd")

func add_entity(e):
	for system in get_children():
		system.add(e)

func remove_entity(e):
	for system in get_children():
		system.remove(e)

func change_entity(e):
	remove_entity(e)
	add_entity(e)

func _setup(ground_tilemap, creatures_tilemap, effects_tilemap, camera, ui, event_bus):
	_setup_tilemaps(ground_tilemap, creatures_tilemap, effects_tilemap)
	_setup_systems(ground_tilemap, creatures_tilemap, effects_tilemap, camera, ui, event_bus)
	event_bus.connect("spawn_entity", self, "add_entity")
	event_bus.connect("change_entity", self, "change_entity")
	event_bus.connect("entity_died", self, "remove_entity")

func _setup_tilemaps(ground_tilemap, creatures_tilemap, effects_tilemap):
	var cell_size = Vector2(Constants.TILE_WIDTH, Constants.TILE_HEIGHT)
	ground_tilemap.cell_size = cell_size
	creatures_tilemap.cell_size = cell_size
	effects_tilemap.cell_size = cell_size

func _setup_systems(ground_tilemap, creatures_tilemap, effects_tilemap, camera, ui, event_bus):
	add_child(DisplaySystem.new(event_bus, ground_tilemap, creatures_tilemap))
	add_child(FovSystem.new(event_bus, ground_tilemap))
	add_child(PlayerMovementSystem.new(event_bus))
	add_child(EntityMovementSystem.new(event_bus))
	add_child(CameraSystem.new(camera))
	add_child(CombatSystem.new(event_bus))
	add_child(ChasePlayerSystem.new(event_bus))
	add_child(HealthBarSystem.new(event_bus))
	add_child(DamageSystem.new(event_bus))
	add_child(SkillSelectSystem.new(event_bus))
	add_child(TargetedSkillSystem.new(event_bus, ground_tilemap))
	add_child(SetPlayerSystem.new(event_bus))
	add_child(ActivateTileSystem.new(event_bus, creatures_tilemap))
	add_child(PlayerSwitchSystem.new(event_bus))
	add_child(SelfSkillSystem.new(event_bus))
	add_child(EffectsDisplaySystem.new(effects_tilemap))
	add_child(DamageModifierSystem.new(event_bus))
	add_child(SkillMenuSystem.new(ui, event_bus))
	add_child(StunSystem.new(event_bus))
	add_child(ExplosionSystem.new(event_bus, ground_tilemap))
	add_child(StatusEffectsSystem.new(event_bus))
	add_child(HealSystem.new(event_bus))

	# skills
	add_child(StunPistolSystem.new(event_bus))
	add_child(RocketLauncherSystem.new(event_bus))
	add_child(LightningCannonSystem.new(event_bus, ground_tilemap))
	add_child(EnergyShieldSystem.new(event_bus))
	add_child(HealSelfSystem.new(event_bus))
