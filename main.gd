extends Control

const Author = preload("res://Author.gd")
const Book = preload("res://Book.gd")

@onready var top_menu = $Panel/VBoxContainer/TopMenu
@onready var display_container = $Panel/VBoxContainer/DisplayContainer
@onready var search_by = $Panel/VBoxContainer/TopMenu/SearchMenu/SearchBy


@onready var authors = {}
@onready var updated = false
 
# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func create_something(text, something):
	var elt = something.new()
	elt.text = text
	elt.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	elt.size_flags_vertical = Control.SIZE_EXPAND_FILL
	return elt
	
func update():
	var file = FileAccess.open("res://Author.txt", FileAccess.READ)
	while not file.eof_reached():
		var line = file.get_line()
		var data = line.split("/")
		if len(data) == 3:
			if int(data[0]) not in authors:
				authors[int(data[0])] = Author.new(int(data[0]), data[1], data[2])
	updated = true
	file.close()

func _on_search_by_item_selected(index):
	delete_children(display_container)
	display_container.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	display_container.size_flags_vertical = Control.SIZE_EXPAND_FILL
	var scroll_container = ScrollContainer.new()
	scroll_container.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	scroll_container.size_flags_vertical = Control.SIZE_EXPAND_FILL
	var listing = VBoxContainer.new()
	listing.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	listing.size_flags_vertical = Control.SIZE_EXPAND_FILL
	display_container.add_child(scroll_container)
	scroll_container.add_child(listing)
	match index:
		0:
			if updated == false:
				update()
			for aut in authors:
				authors[aut].display(listing)
		1:
			print("tt")
		2:
			print("ttt")


func _on_add_author_pressed():
	if updated == false:
		update()
	search_by.selected = -1
	delete_children(display_container)
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
	
	display_container.size_flags_horizontal = Control.SIZE_SHRINK_CENTER
	display_container.size_flags_vertical = Control.SIZE_SHRINK_CENTER
	
	validate_button.connect("pressed" , func() : validate(entry1, entry2))
	entry1.connect("text_changed", func() : on_text_changed(entry1))
	entry2.connect("text_changed", func() : on_text_changed(entry2))
	
func validate(entry1, entry2):
	var aut = Author.new(len(authors), entry1.text, entry2.text)
	authors[len(authors)] = (aut)
	aut.save()
	delete_children(display_container)

func on_text_changed(entry):
	var text_size = entry.get_text_size()
	var width = entry.size.x
	print("ts", text_size)
	print("ws", width)
	if text_size.x > width:
		entry.size.x = text_size

func delete_children(node):
	for child in node.get_children():
		node.remove_child(child)

