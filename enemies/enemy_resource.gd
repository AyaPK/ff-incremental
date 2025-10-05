class_name EnemyResource extends Resource

@export_category("Details")
@export var name: String
@export var image: Texture2D
@export var is_boss: bool

@export_category("Stats")
@export var hp: int
@export var attack: int
@export var defense: int
@export var speed: float

@export_category("Drops")
@export var exp_drop: int
@export var gp_drop: int
