extends Node2D

func create_grass_effect():
	var GrassEffect = load("res://Effects/GrassEffect.tscn") #доступ к эффекту
	var grassEffect = GrassEffect.instance()
	var world = get_tree().current_scene #добавлем сцену эффекта травы к корневой сцене
	world.add_child(grassEffect) #делаем добавленную сцену ребенком корневой сцены
	grassEffect.global_position = global_position #настраиваем позицию эффекта травы

func _on_Hurtbox_area_entered(area):
	create_grass_effect()
	queue_free()
