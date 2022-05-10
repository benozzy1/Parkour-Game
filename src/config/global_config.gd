extends Node

const CONFIG_PATH: String = "user://settings.cfg"

var default_values: Dictionary = {
	"test_section": {
		"test": 1
	}
}

var _config_file: ConfigFile = ConfigFile.new()
var _config_values: Dictionary = {}


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	load_config()


## Loads config from file and saves it into a Dictionary
func load_config() -> void:
	print_debug("""Loading config file...""")
	
	_config_values = default_values
	
	var err = _config_file.load(CONFIG_PATH)
	if err == OK:
		for section in _config_file.get_sections():
			if not _config_values.has(section):
				_config_values[section] = {}
			
			for key in _config_file.get_section_keys(section):
				_config_values[section][key] = _config_file.get_value(section, key)
		print_debug("""Config file successfully loaded.""")
	else:
		printerr("Error: Config file not found. Generating a new one...")
		save_config()


## Saves config from dictionary into file
func save_config() -> void:
	for section in default_values.keys():
		for key in default_values.get(section):
			_config_file.set_value(section, key, _config_values[section][key])
			
			print_debug(
				"""Saved value [%s/%s] with %s."""
				% [section, key, str(_config_values[section][key])]
			)
	_config_file.save(CONFIG_PATH)


## Sets value in dictionary
func set_value(section: String, key: String, value: Variant) -> void:
	_config_values[section][key] = value


## Returns value from dictionary
func get_value(section: String, key: String) -> Variant:
	return _config_values[section][key]
