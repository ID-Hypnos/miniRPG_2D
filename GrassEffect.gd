extends Node2D

onready var animatedSprite = $AnimatedSprite

func _ready(): #проигрывание анимации
	animatedSprite.frame = 0 #если не сделать этого, то анимация будет проигрываться с конца
	animatedSprite.play("Animate")

func _on_AnimatedSprite_animation_finished():
	queue_free() #разрушаем анимацию после использования
