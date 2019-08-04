extends MarginContainer

func enable():
	$VBoxContainer/Username.editable = true
	$VBoxContainer/HBoxContainer1/IP.editable = true
	$VBoxContainer/HBoxContainer1/Port.editable = true
	$VBoxContainer/HBoxContainer2/Create.disabled = false
	$VBoxContainer/HBoxContainer2/Join.disabled = false

func disable():
	$VBoxContainer/Username.editable = false
	$VBoxContainer/HBoxContainer1/IP.editable = false
	$VBoxContainer/HBoxContainer1/Port.editable = false
	$VBoxContainer/HBoxContainer2/Create.disabled = true
	$VBoxContainer/HBoxContainer2/Join.disabled = true