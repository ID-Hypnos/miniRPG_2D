extends StaticBody2D
#extends Node

enum QuestStatus { NOT_STARTED, STARTED, COMPLETED } #все статусы "квеста"
var quest_status = QuestStatus.NOT_STARTED #статус квеста на данный момент
var dialogue_state = 0 #статус диалога на данный момент
var necklace_found = false #статус нахождения подвески

var dialoguePopup
var player

func _ready():
	dialoguePopup = get_tree().root.get_node("/root/World/CanvasLayer/DialoguePopUp")
	player = get_tree().root.get_node("/root/World/YSort/Player")
	
func talk(answer = ""):
	# NPC, анимация = "говорит"
	$AnimatedSprite.play("talk")
	
	dialoguePopup.npc = self
	dialoguePopup.npc_name = "Ryu"
	
	# показываем "действующий" диалог
	match quest_status:
		QuestStatus.NOT_STARTED:
			match dialogue_state:
				0:
					# Обновляем ситуацию с диалогом
					dialogue_state = 1
					# Показываем диалог
					dialoguePopup.dialogue = "Hello adventurer! I lost my necklace, can you find it for me?"
					dialoguePopup.answers = "[A] Yes  [B] No"
					dialoguePopup.open()
				1:
					match answer:
						"A":
							# Обновляем ситуацию с диалогом
							dialogue_state = 2
							# Показываем диалог
							dialoguePopup.dialogue = "Thank you!"
							dialoguePopup.answers = "[A] Bye"
							dialoguePopup.open()
						"B":
							# Обновляем ситуацию с диалогом
							dialogue_state = 3
							# Показываем диалог
							dialoguePopup.dialogue = "If you change your mind, you'll find me here."
							dialoguePopup.answers = "[A] Bye"
							dialoguePopup.open()
				2:
					# Обновляем ситуацию с диалогом
					dialogue_state = 0
					quest_status = QuestStatus.STARTED
					# Закрываем диалог
					dialoguePopup.close()
					# Set NPC's animation to "idle"
					$AnimatedSprite.play("idle")
				3:
					# Обновляем ситуацию с диалогом
					dialogue_state = 0
					# Закрываем диалог
					dialoguePopup.close()
					# Set NPC's animation to "idle"
					$AnimatedSprite.play("idle")
		QuestStatus.STARTED:
			match dialogue_state:
				0:
					# Обновляем ситуацию с диалогом
					dialogue_state = 1
					# Показываем диалог
					dialoguePopup.dialogue = "Did you find my necklace?"
					if necklace_found:
						dialoguePopup.answers = "[A] Yes  [B] No"
					else:
						dialoguePopup.answers = "[A] No"
					dialoguePopup.open()
				1:
					if necklace_found and answer == "A":
						# Обновляем ситуацию с диалогом
						dialogue_state = 2
						# Показываем диалог
						dialoguePopup.dialogue = "You're my hero! Thank you!"
						dialoguePopup.answers = "[A] You're welcome"
						dialoguePopup.open()
					else:
						# Обновляем ситуацию с диалогом
						dialogue_state = 3
						# Показываем диалог
						dialoguePopup.dialogue = "Please, find it!"
						dialoguePopup.answers = "[A] I will!"
						dialoguePopup.open()
				2:
					# Обновляем ситуацию с диалогом
					dialogue_state = 0
					quest_status = QuestStatus.COMPLETED
					# Закрываем диалог
					dialoguePopup.close()
					# Set NPC's animation to "idle"
					$AnimatedSprite.play("idle")
					#yield(get_tree().create_timer(0.5), "timeout") 
					#тут по идее должна быть награда
				3:
					# Обновляем ситуацию с диалогом
					dialogue_state = 0
					# Закрываем диалог
					dialoguePopup.close()
					# Set NPC's animation to "idle"
					$AnimatedSprite.play("idle")
		QuestStatus.COMPLETED: #если квест выполнен
			match dialogue_state:
				0:
					# Обновляем ситуацию с диалогом
					dialogue_state = 1
					# Показываем диалог
					dialoguePopup.dialogue = "Thanks again for your help!"
					dialoguePopup.answers = "[A] Bye"
					dialoguePopup.open()
				1:
					# Обновляем ситуацию с диалогом
					dialogue_state = 0
					# Закрываем диалог
					dialoguePopup.close()
					# Set NPC's animation to "idle"
					$AnimatedSprite.play("idle")


func _on_Hurtbox_area_entered(area):
	talk()
