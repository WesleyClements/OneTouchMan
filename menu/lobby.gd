extends MarginContainer

func enable():
	$HBoxContainer/CenterContainer/Start.disabled = false;

func disable():
	$HBoxContainer/CenterContainer/Start.disabled = true;