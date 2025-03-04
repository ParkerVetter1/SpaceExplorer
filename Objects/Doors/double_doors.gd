extends AnimatableBody2D

@onready var anim = $AnimationPlayer

func openDoor():
	#open
	anim.play("doubleDoorSlide")

func closeDoor():
	#close
	anim.play_backwards("doubleDoorSlide")

func _on_area_2d_body_entered(_body: Node2D) -> void:
	openDoor()


func _on_area_2d_body_exited(_body: Node2D) -> void:
	closeDoor()
