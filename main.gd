extends Control

const Author = preload("res://Author.gd")
const Book = preload("res://Book.gd")
@onready var top_menu = $Panel/VBoxContainer/TopMenu
@onready var listing = $Panel/VBoxContainer/DisplayContainer/ScrollContainer/Listing
@onready var display_container = $Panel/VBoxContainer/DisplayContainer


@export var authors: Array = []

# Called when the node enters the scene tree for the first time.
func _ready():
	var A = Author.new()
	A.create_author("f_n", "l_n")
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func create_something(text, something):
	var elt = something.new()
	elt.text = text
	elt.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	elt.size_flags_vertical = Control.SIZE_EXPAND_FILL
	return elt
	


func _on_search_by_item_selected(index):
	match index:
		0:
			print("t")
		1:
			print("tt")
		2:
			print("ttt")


func _on_add_author_pressed():
	
	var hbox_first_name = HBoxContainer.new()
	var hbox_last_name = HBoxContainer.new()
	
	var lab1 = Label.new()
	lab1.text = "First Name"
	var lab2 = Label.new()
	lab2.text = "Last Name"
	var entry1 = LineEdit.new()
	var entry2 = LineEdit.new()
	var validate_button = Button.new()
	validate_button.text = "Validate"
	
	hbox_first_name.add_child(lab1)
	hbox_first_name.add_child(entry1)
	hbox_last_name.add_child(lab2)
	hbox_last_name.add_child(entry2)
	
	display_container.add_child(hbox_first_name)
	display_container.add_child(hbox_last_name)
	display_container.add_child(validate_button)
	display_container.alignment = PRESET_CENTER
	validate_button.connect("pressed" , validate)
	entry1.connect("text_changed", func() : on_text_changed(entry1))
	entry2.connect("text_changed", func() : on_text_changed(entry2))
	
func validate():
	print("test")

func on_text_changed(entry):
	var text_size = entry.get_text_size()
	var width = entry.size.x
	print("ts", text_size)
	print("ws", width)
	if text_size.x > width:
		entry.size.x = text_size

