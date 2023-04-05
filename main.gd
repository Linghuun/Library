extends Control

const Author = preload("res://Author.gd")
const Book = preload("res://Book.gd")
const verification_lab_text = """ already exist.
Do you want
to continue ?"""

@onready var top_menu =  $Panel/VBoxContainer/TopMenu
@onready var search_by = $Panel/VBoxContainer/TopMenu/SearchMenu/SearchBy

@onready var search_menu = $Panel/VBoxContainer/SearchMenu
@onready var listing =     $Panel/VBoxContainer/SearchMenu/ScrollContainer/Listing
@onready var search_bar =  $Panel/VBoxContainer/SearchMenu/SearchBar

@onready var add_author_menu =  $Panel/VBoxContainer/AddAuthorMenu
@onready var verification_lab = $Panel/VBoxContainer/AddAuthorMenu/VerificationBox/VerificationLab
@onready var entry_first_name = $Panel/VBoxContainer/AddAuthorMenu/VBoxContainer/HBoxFirstName/EntryFirstName
@onready var entry_last_name =  $Panel/VBoxContainer/AddAuthorMenu/VBoxContainer/HBoxLastName/EntryLastName
@onready var yes_verif_aut =    $Panel/VBoxContainer/AddAuthorMenu/VerificationBox/VBoxContainer/YesVerifAut
@onready var no_verif_aut =     $Panel/VBoxContainer/AddAuthorMenu/VerificationBox/VBoxContainer/NoVerifAut
@onready var verification_box = $Panel/VBoxContainer/AddAuthorMenu/VerificationBox

@onready var add_book_menu = $Panel/VBoxContainer/AddBookMenu
@onready var listing2 =      $Panel/VBoxContainer/AddBookMenu/SearchMenu/ScrollContainer/Listing2
@onready var search_bar2 =   $Panel/VBoxContainer/AddBookMenu/SearchMenu/SearchBar2


@onready var authors = {}
@onready var aut_updated = false
@onready var book_updated = false
@onready var yes_verif_aut_value = false
@onready var no_verif_aut_value = false

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

func _on_validate_aut_pressed():
	if not "/" in entry_first_name.text and not "/" in entry_last_name.text:
		var content = entry_first_name.text + " " + entry_last_name.text
		for id in authors:
			var author_content = authors[id].first_name + " " + authors[id].last_name
			print(author_content)
			if content.similarity(author_content) > 0.9:
				verification_lab.text = author_content + "\n" + verification_lab_text
				verification_box.visible = true
				"""while 1:
					if yes_verif_aut_value:
						print("heheh")
						yes_verif_aut_value = false
					if no_verif_aut_value:
						print("hohoh")
						no_verif_aut_value = false"""
		if verification_box.visible == false:
			var aut = Author.new(len(authors), entry_first_name.text, entry_last_name.text)
			authors[len(authors)] = (aut)
			aut.save()

func delete_children(node):
	for child in node.get_children():
		node.remove_child(child)

func _on_add_author_pressed():
	update_aut()
	search_by.selected = -1
	add_author_menu.visible = true
	search_menu.visible = false
	add_book_menu.visible = false
	verification_box.visible = false
	
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
	var index = search_by.selected
	var node: Node
	if add_book_menu.visible == true:
		node = listing2
	else:
		node = listing
	delete_children(node)
	if node == listing2 or index == 0: 
		search_bar_display_authors(text, node)
	elif index == 1:
		pass

func search_bar_display_authors(text, node):
	for id in authors:
		var name_lastname = authors[id].first_name + authors[id].last_name
		var lastname_name = authors[id].last_name + authors[id].first_name
		if text.similarity(name_lastname) > 0.3 or text.similarity(lastname_name) > 0.3 or text in lastname_name:
			authors[id].display(node, temp)
	if text == "":
		display_authors(node, temp)


func _on_yes_verif_aut_pressed(): yes_verif_aut_value = true
func _on_no_verif_aut_pressed(): no_verif_aut_value = true
