extends Node


@onready var page = $"../Panel/VBoxContainer/DisplayContainer/ScrollContainer/Page"
@onready var display_container = $"../Panel/VBoxContainer/DisplayContainer"
@onready var scroll_container = $"../Panel/VBoxContainer/DisplayContainer/ScrollContainer"
@onready var main = $".."
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func display():
	var file = FileAccess.open("res://Book.txt", FileAccess.READ_WRITE)
	var title_box = HBoxContainer.new()
	var image_lab = main.create_something("Image", Label)
	title_box.add_child(image_lab)
	var name_lab = main.create_something("Book's Name", Label)
	title_box.add_child(name_lab)
	var Author = main.create_something("Author", Label)
	title_box.add_child(Author)
	var ISBN = main.create_something("ISBN", Label)
	title_box.add_child(ISBN)
	
	display_container.add_child(title_box)
	display_container.move_child(title_box, 0)
	
	while not file.eof_reached():
		var line = file.get_line()
