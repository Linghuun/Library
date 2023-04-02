extends Node

@onready var main = $".."



@export var first_name = "test"
@export var last_name = " tezst"



# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func create_author(first_name, last_name):
	self.first_name = first_name
	self.last_name = last_name

func display(listing):
	var aut = Button.new()
	aut.text = self.first_name + " " + self.last_name
	aut.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	aut.size_flags_vertical = Control.SIZE_EXPAND_FILL
	aut.alignment = HORIZONTAL_ALIGNMENT_LEFT
	listing.add_child(aut)
	

