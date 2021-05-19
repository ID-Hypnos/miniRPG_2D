tool
#extends Node
extends Area2D

var NPC

func _ready():
	NPC = get_tree().root.get_node("/root/WorldYSort/NPC")

#если игрок нашел ожерелье, то  necklace найден
func _on_Necklace_body_entered(body):
	if body.name == "Player":
		get_tree().queue_delete(self)
		NPC.necklace_found = true
