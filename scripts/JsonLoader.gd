# Load module_defs.json
static func _loadJson(path):
	var json_str = FileAccess.open(path, FileAccess.READ)
	var content = json_str.get_as_text()
	var module_json = JSON.parse_string(content)
	
	return module_json
