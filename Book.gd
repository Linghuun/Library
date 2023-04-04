extends Node

const Author = preload("res://Author.gd")
@onready var main = $".."
@onready var authors = main.authors

@export var id_book: int
@export var id_author: int
@export var book_name: String
@export var ISBN: int
@export var author: Author
@export var date: String

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _init(id_book, id_author, name, ISBN, date):
	self.id_book = id_book
	self.id_author = id_author
	self.book_name = name
	self.ISBN = ISBN
	self.date = date

func display(listing):
	var book = HBoxContainer.new()
	var ISBN_lab = Label.new()
	ISBN_lab.text = self.ISBN
	var book_name_lab = Label.new()
	book_name_lab.text = self.book_name
	var date_lab = Label.new()
	date_lab.text = self.date
	var author_but = Button.new()
	author_but.text = main.authors[self.id_author]
	
	book.add_child(ISBN_lab)
	book.add_child(book_name_lab)
	book.add_child(date_lab)
	book.add_child(author_but)
	book.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	book.size_flags_vertical = Control.SIZE_EXPAND_FILL
	
	listing.add_child(book)

