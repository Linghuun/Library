extends Control

const Author = preload("res://Author.gd")
const Book = preload("res://Book.gd")


@onready var top_menu = $Panel/VBoxContainer/TopMenu
@onready var search_by = $Panel/VBoxContainer/TopMenu/SearchMenu/SearchBy

@onready var search_menu = $Panel/VBoxContainer/SearchMenu
@onready var listing =     $Panel/VBoxContainer/SearchMenu/ScrollContainer/Listing
@onready var search_bar =  $Panel/VBoxContainer/SearchMenu/SearchBar

@onready var add_author_menu = $Panel/VBoxContainer/AddAuthorMenu

@onready var add_book_menu = $Panel/VBoxContainer/AddBookMenu
@onready var listing2 =      $Panel/VBoxContainer/AddBookMenu/SearchMenu/ScrollContainer/Listing2
@onready var search_bar2 =    $Panel/VBoxContainer/AddBookMenu/SearchMenu/SearchBar2


@onready var authors = {}
@onready var aut_updated = false
@onready var book_updated = false

 
	
func update_aut():
	var file = FileAccess.open("res://Author.txt", FileAccess.READ)
	while not file.eof_reached():
		var line = file.get_line()
		var data = line.split("/")
		if len(data) == 3:
			if int(data[0]) not in authors:
				authors[int(data[0])] = Author.new(int(data[0]), data[1], data[2])
	aut_updated = true
	file.close()
	
func update_book():
	pass

	
func display_authors(node, function):
	if aut_updated == false:
		update_aut()
	for aut in authors:
		authors[aut].display(node, function)

func temp():
	pass
	
func _on_search_by_item_selected(index):
	delete_children(listing)
	add_author_menu.visible = false
	add_book_menu.visible = false
	search_menu.visible = true
	print(index)
	match index:
		0:
			search_bar.clear()
			display_authors(listing, temp)
		1:
			print("tt")
		2:
			print("ttt")


func validate_aut(entry1, entry2):
	if not "/" in entry1.text and not "/" in entry2.text:
		var aut = Author.new(len(authors), entry1.text, entry2.text)
		authors[len(authors)] = (aut)
		aut.save()


func delete_children(node):
	for child in node.get_children():
		node.remove_child(child)

func _on_add_author_pressed():
	search_by.selected = -1
	add_author_menu.visible = true
	search_menu.visible = false
	add_book_menu.visible = false
	
func _on_add_book_pressed():
	search_bar2.clear()
	search_by.selected = -1
	add_author_menu.visible = false
	search_menu.visible = false
	add_book_menu.visible = true
	delete_children(listing2)
	display_authors(listing2, temp)
	
func validate_book(grid_container):
	var flag = true
	for child in grid_container.get_children():
		if child is LineEdit:
			if "/" in child.text:
				flag = false
	if flag == true:
		pass


func _on_search_bar_text_changed(text):
	var node: Node
	if add_book_menu.visible == true:
		node = listing2
	else:
		node = listing
	delete_children(node)
	for id in authors:
		var name_lastname = authors[id].first_name + authors[id].last_name
		var lastname_name = authors[id].last_name + authors[id].first_name
		if text.similarity(name_lastname) > 0.2 or text.similarity(lastname_name) > 0.2 or text in lastname_name:
			authors[id].display(node, temp)
	if text == "":
		display_authors(node, temp)
