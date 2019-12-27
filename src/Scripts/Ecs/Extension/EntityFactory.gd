const Entity = preload("res://Scripts/Ecs/Core/Entity.gd")

const AttackComponent = preload("res://Scripts/Ecs/Components/AttackComponent.gd")
const CameraFollowComponent = preload("res://Scripts/Ecs/Components/CameraFollowComponent.gd")
const ChasePlayerComponent = preload("res://Scripts/Ecs/Components/ChasePlayerComponent.gd")
const HealthComponent = preload("res://Scripts/Ecs/Components/HealthComponent.gd")
const PlayerMovementComponent = preload("res://Scripts/Ecs/Components/PlayerMovementComponent.gd")
const SightComponent = preload("res://Scripts/Ecs/Components/SightComponent.gd")
const SpriteComponent = preload("res://Scripts/Ecs/Components/SpriteComponent.gd")

func create_player(tile):
    return Entity.new(tile.x, tile.y) \
		.add("SpriteComponent", SpriteComponent.new("Creatures", "Player")) \
		.add("PlayerMovementComponent", PlayerMovementComponent.new()) \
		.add("CameraFollowComponent", CameraFollowComponent.new()) \
		.add("AttackComponent", AttackComponent.new(Constants.PLAYER_ATTACK_DAMAGE)) \
		.add("HealthComponent", HealthComponent.new(Constants.PLAYER_MAX_HEALTH)) \
        .add("SightComponent", SightComponent.new(Constants.PLAYER_SIGHT))

func create_monster(tile):
    return Entity.new(tile.x, tile.y) \
        .add("SpriteComponent", SpriteComponent.new("Creatures", "Enemy")) \
        .add("AttackComponent", AttackComponent.new(Constants.PLAYER_ATTACK_DAMAGE)) \
        .add("HealthComponent", HealthComponent.new(Constants.PLAYER_MAX_HEALTH)) \
        .add("ChasePlayerComponent", ChasePlayerComponent.new()) \
        .add("SightComponent", SightComponent.new(3))

func create_wall(tile):
    return Entity.new(tile.x, tile.y).add("SpriteComponent", SpriteComponent.new("Ground", "Wall", "DiscoveredWall"))