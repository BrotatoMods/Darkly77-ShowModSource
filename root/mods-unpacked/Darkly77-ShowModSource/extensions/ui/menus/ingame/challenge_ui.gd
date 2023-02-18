extends "res://ui/menus/ingame/challenge_ui.gd"

const SHOWMODSRC_LOG = "Darkly77-ShowModSource"

onready var ContentLoader_ShowModSrc = get_node("/root/ModLoader/Darkly77-ContentLoader/ContentLoader")


func set_data(p_chal_data:ChallengeData, locked:bool = false, locked_icon:Texture = null)->void :
	.set_data(p_chal_data, locked, locked_icon)

	var mod_id = ContentLoader_ShowModSrc.lookup_modname_by_itemid(p_chal_data.my_id, "challenge")

	if mod_id == "CL_Notice-NotFound":
		return

	var mod_name = mod_id.get_slice("-", 1)

	var vanilla_text = _description.text
	_description.text = vanilla_text + "\n\n" + "Mod: " + mod_name
