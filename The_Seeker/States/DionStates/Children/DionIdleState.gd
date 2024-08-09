extends DionState


@export_category("State Transitions")
@export var strike_node: NodePath
@export var fan_node: NodePath
@export var charge_node: NodePath
@export var channel_orb_node: NodePath
@export var toss_orb_node: NodePath

@onready var strike_state: BaseState = get_node(strike_node)
@onready var fan_state: BaseState = get_node(fan_node)
@onready var charge_state: BaseState = get_node(charge_node)
@onready var channel_orb_state: BaseState = get_node(channel_orb_node)
@onready var toss_orb_state: BaseState = get_node(toss_orb_node)


# TODO logic to decide what to do
