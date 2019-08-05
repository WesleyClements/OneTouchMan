extends MarginContainer

func enable():
	$VBoxContainer/Username.editable = true
	$VBoxContainer/Network/IP.editable = true
	$VBoxContainer/Network/Port.editable = true
	$VBoxContainer/HBoxContainer2/Create.disabled = false
	$VBoxContainer/HBoxContainer2/Join.disabled = false

func disable():
	$VBoxContainer/Username.editable = false
	$VBoxContainer/Network/IP.editable = false
	$VBoxContainer/Network/Port.editable = false
	$VBoxContainer/HBoxContainer2/Create.disabled = true
	$VBoxContainer/HBoxContainer2/Join.disabled = true