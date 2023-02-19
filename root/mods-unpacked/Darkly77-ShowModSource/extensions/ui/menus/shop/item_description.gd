extends "res://ui/menus/shop/item_description.gd"

const SHOWMODSRC_LOG = "Darkly77-ShowModSource"

onready var ContentLoader_ShowModSrc = get_node("/root/ModLoader/Darkly77-ContentLoader/ContentLoader")
# onready var mod_info_label = get_node('ScrollContainer/VBoxContainer/ModInfo/ModName')


# Extensions
# =============================================================================

func set_item(item_data:ItemParentData):
	.set_item(item_data)
	_showmodsrc_apply_mod_name(item_data)
	# _showmodsrc_scene_edit_version(item_data)


# Custom
# =============================================================================

func _showmodsrc_apply_mod_name(item_data:ItemParentData) -> void:
	var mod_name = ContentLoader_ShowModSrc.lookup_modid_by_itemdata(item_data) # requires ContentLaoder v6.0.0+
	var default_text = ""

	# Uncomment to debug
	#ModLoaderUtils.log_debug("[ContentLoader] mod_name=" + mod_name, SHOWMODSRC_LOG)

	# This mod_name means that the item wasn't added via ContentLoader
	if mod_name == "CL_Notice-NotFound":
		mod_name = "Vanilla"
		return # Uncomment to show "Vanilla" text (useful for debugging)

	var custom_text = _showmodsrc_get_mod_info_text(mod_name, false)

	if item_data is WeaponData:
		default_text = get_effects().bbcode_text

		# If effects are empty, extend weapon_stats instead. Without this,
		# there would be an extra empty line before the mod name text
		if default_text != "":
			get_effects().bbcode_text = default_text + custom_text
		else:
			default_text = get_weapon_stats().bbcode_text
			get_weapon_stats().bbcode_text = default_text + custom_text

	elif item_data is CharacterData:
		default_text = get_effects().bbcode_text
		get_effects().bbcode_text = default_text + custom_text

	elif item_data is ItemData:
		default_text = get_effects().bbcode_text
		get_effects().bbcode_text = default_text + custom_text


# Helpers
# =============================================================================

func _showmodsrc_get_mod_info_text(mod_id:String, add_line_breaks: bool = true) -> String:
	var text_edit = _showmodsrc_get_mod_name_from_mod_id(mod_id)
	var text_code = _showmodsrc_get_text_color_bbcode(text_edit)
	var img_code = _showmodsrc_get_img_bbcode()

	var table_text = _showmodsrc_get_table_text(img_code, text_code)

	if add_line_breaks:
		return "\n\n" + table_text
	else:
		return table_text


func _showmodsrc_get_mod_name_from_mod_id(mod_id:String = "") -> String:
	return mod_id.get_slice("-", 1)


func _showmodsrc_get_table_text(img_code, modname_text:String) -> String:
	# Hacky workaround to fix vertical alignment of img when using BBCode
	# via: https://stackoverflow.com/questions/70410163/godot-how-to-vertically-align-bbcode
	return "[table=2][cell]%s[/cell][cell]%s[/cell][/table]" % [img_code, modname_text]


func _showmodsrc_get_text_color_bbcode(text: String) -> String:
	return "[color=%s]%s[/color]" % [Utils.GRAY_COLOR_STR, text]


func _showmodsrc_get_img_bbcode() -> String:
	var w = 20 * ProgressData.settings.font_size
	# var icon_path = "res://mods-unpacked/Darkly77-ShowModSource/assets/mod_cog_icon.png"
	var icon_path = "res://mods-unpacked/Darkly77-ShowModSource/assets/mod_cog_icon_small.png"
	return "[img=%sx%s]%s[/img]" % [w, w, icon_path]


# Unused
# =============================================================================

# I tried to do it this way but abandoned it. I want to make the text align
# with the bottom-right of the container. Maybe someone who knows more about
# this can fix it 🤷‍♂️
func _showmodsrc_scene_edit_version(item_data:ItemParentData) -> void:
	var mod_name = ContentLoader_ShowModSrc.lookup_modid_by_itemdata(item_data)
	var default_text = ""

	# Uncomment to debug
	#ModLoaderUtils.log_debug("[ContentLoader] mod_name=" + mod_name, SHOWMODSRC_LOG)

	# This mod_name means that the item wasn't added via ContentLoader
	if mod_name == "CL_Notice-NotFound":
		mod_name = "Vanilla"
		# return

	var custom_text = _showmodsrc_get_mod_info_text(mod_name, false)

	# Update mod info label
	# mod_info_label.text = custom_text
	# mod_info_label.bbcode_text = custom_text #@todo: Uncomment this


	# Reduce the height of vanilla's ScrollContainer to make room for the mod name
	# _scroll_container.size.y = _scroll_container.size.y - 50

	# var scroll_size = _scroll_container.rect_size
	# var scroll_width = scroll_size.x
	# var scroll_height = scroll_size.y
	# var new_size = Vector2(scroll_width, scroll_height - 25)
	# _scroll_container.set_size(new_size)
	# print(str(scroll_size))
