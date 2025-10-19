class_name PartyScene extends ScenePanel

@onready var party_panel_1: PartyPanel = $PartyPanel1
@onready var party_panel_2: PartyPanel = $PartyPanel2
@onready var party_panel_3: PartyPanel = $PartyPanel3
@onready var party_panel_4: PartyPanel = $PartyPanel4

func run_on_enter() -> void:
	refresh_party()

func refresh_party() -> void:
	party_panel_1.character = PartyManager.member_1
	party_panel_1.show_party_member()
	party_panel_2.character = PartyManager.member_2
	party_panel_2.show_party_member()
	party_panel_3.character = PartyManager.member_3
	party_panel_3.show_party_member()
	party_panel_4.character = PartyManager.member_4
	party_panel_4.show_party_member()
