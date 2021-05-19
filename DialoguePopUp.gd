extends Popup

var npc_name setget name_set
var dialogue setget dialogue_set
var answers setget answers_set

func name_set(new_value):
	npc_name = new_value
	$ColorRect/NPCName.text = new_value

func dialogue_set(new_value):
	dialogue = new_value
	$ColorRect/Dialogue.text = new_value

func answers_set(new_value):
	answers = new_value
	$ColorRect/Answers.text = new_value
	
func open(): #когда функция началась, игра останавливается
	get_tree().paused = true
	popup() #функция вызывает функцию popup() и показывает ее диалог
	$AnimationPlayer.playback_speed = 60.0 / dialogue.length()
	$AnimationPlayer.play("ShowDialogue") #вызывает функцию ShowDialog()
	
func close(): #функция закрытия диалога
	get_tree().paused = false #возобновляет игру
	hide() #прячет диалог
	
func _ready(): #если диалог закрыт, то не получает входных данных
	set_process_input(false) 
	
func _on_AnimationPlayer_animation_finished(anim_name):
	set_process_input(true)
	
var npc

func _input(event): #функция, обрабатывающая входную информацию от игрока
	if event is InputEventKey:
		if event.scancode == KEY_A: #если нажата клавиша А
			set_process_input(false)
			npc.talk("A") #отправляет NPC ответ через фукнцию talk()
		elif event.scancode == KEY_B: #если нажата клавиша B
			set_process_input(false)
			npc.talk("B") #отправляет NPC ответ через фукнцию talk()
