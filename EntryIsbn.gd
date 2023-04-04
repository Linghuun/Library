extends SpinBox
func _ready():
	self.get_line_edit().expand_to_text_length = true
	self.get_line_edit().clear()
