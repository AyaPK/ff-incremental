class_name Item extends Resource

enum RARITY {COMMON, UNCOMMON, RARE, EPIC, LEGENDARY, MYTHICAL, SPECIAL}
@export var rarities: RARITY

@export var name: String
@export var buy_price: int
@export var sell_price: int

var coloured_name: String :
	get: return "[color="+ResourceManager.rarity_colours[rarities].to_html()+"]"+name+"[/color]"
