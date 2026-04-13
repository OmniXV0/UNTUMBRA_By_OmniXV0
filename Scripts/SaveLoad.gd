extends Node

const save_location = "user://UNTUMBRASaveFile.json"

var contents_to_save: Dictionary = {
	"high_score": 0,
	"time_score": 0
}

func _ready() -> void:
	_load()

func _save():
	var file = FileAccess.open(save_location, FileAccess.WRITE)
	file.store_var(contents_to_save)
	file.close()
	
func _load():
	if FileAccess.file_exists(save_location):
		var file = FileAccess.open(save_location, FileAccess.READ)
		var data = file.get_var()
		file.close()
		
		if typeof(data) == TYPE_DICTIONARY:
			if data.has("high_score"):
				contents_to_save["high_score"] = data["high_score"]
			
			if data.has("time_score"):
				contents_to_save["time_score"] = data["time_score"]
