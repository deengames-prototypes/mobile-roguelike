extends Node

# The idea here is that every effect will be able to process every type of affect-able stat
# with this class defining stubs that do nothing, so an effect only defines what it needs.

var _parent
var tile_name: String

func _super(parent):
    _parent = parent

func _end_effect():
    _parent.effects.erase(self)

func process_damage(damage):
    return damage

func on_end_turn():
    pass