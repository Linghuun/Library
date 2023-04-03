extends Node

@onready var main = $".."


@export var id_author: int
@export var first_name: String
@export var last_name: String



# Called when the node enters the scene tree for the first time.
func _ready():
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _init(id , first_name, last_name):
	self.id_author = id
	self.first_name = first_name
	self.last_name = last_name

func save():
	var file = FileAccess.open("res://Author.txt", FileAccess.READ_WRITE)
	file.seek_end()
	file.store_string("\n{id}/{f_n}/{l_n}".format({"id": self.id_author, "f_n": self.first_name, "l_n": self.last_name}))
	file.close()
	

func display(listing):
	var aut = Button.new()
	aut.text = first_name + " " + last_name
	aut.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	aut.size_flags_vertical = Control.SIZE_EXPAND_FILL
	aut.alignment = HORIZONTAL_ALIGNMENT_LEFT
	listing.add_child(aut)
	

