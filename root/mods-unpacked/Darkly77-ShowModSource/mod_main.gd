extends Node

const SHOWMODSRC_LOG = "Darkly77-ShowModSource"
const MOD_DIR = "Darkly77-ShowModSource/"

var dir = ""
var ext_dir = ""


# Main
# =============================================================================

func _init(modLoader = ModLoader):
	ModLoaderLog.info("Init", SHOWMODSRC_LOG)
	dir = ModLoaderMod.get_unpacked_dir() + MOD_DIR
	ext_dir = dir + "extensions/"

	ModLoaderMod.install_script_extension(ext_dir + "ui/menus/shop/item_description.gd")
	ModLoaderMod.install_script_extension(ext_dir + "ui/menus/ingame/challenge_ui.gd")


func _ready():
	ModLoaderLog.info("Ready", SHOWMODSRC_LOG)
	# _showmodsrc_extend_item_panel_ui()


# Custom
# =============================================================================

func _showmodsrc_extend_item_panel_ui():
	# Customize item_description scene
	var parent_scene = load("res://ui/menus/shop/item_description.tscn").instance()
	var mod_info_label = load("res://mods-unpacked/Darkly77-ShowModSource/scenes/mod_info.tscn").instance()

	# Add mod info label
	# var target = parent_scene.get_node('ScrollContainer').get_node('VBoxContainer').get_node('Effects')
	# parent_scene.add_child_below_node(target, mod_info_label, true)

	var target = parent_scene.get_node('ScrollContainer').get_node('VBoxContainer')
	target.add_child(mod_info_label)



	mod_info_label.set_owner(parent_scene)

	ModLoader.save_scene(parent_scene, "res://ui/menus/shop/item_description.tscn")
