extends CharacterBody2D
@export var velocidad: float = 500.0
@export var velocidad_salto: float = 600.0
@export var animaciones:AnimatedSprite2D
var _muerto:bool
var inframundo = false
func _physics_process(delta: float) -> void:
	# gravedad
	velocity +=get_gravity() * delta
	# salto
	if Input.is_action_just_pressed("salto") and is_on_floor():
		velocity.y = -velocidad_salto
	#movimineto lateral
	if Input.is_action_pressed("derecha"):
		velocity.x = velocidad
		animaciones.flip_h = false
	elif Input.is_action_pressed("izquierda"):
		velocity.x = -velocidad
		animaciones.flip_h = true
	else:
		velocity.x = 0
	move_and_slide()
	if inframundo == true:
		get_tree().change_scene_to_file("res://inframundo.tscn")
	if !is_on_floor():
		animaciones.play("saltar")
	elif velocity.x != 0:
		animaciones.play("correr")
	else:
		animaciones.play("idle")
	


func _on_area_2d_body_entered(body: Node2D) -> void:
	global_position = Vector2(0,0)


func _on_area_2d_area_entered(area: Area2D) -> void:
	inframundo = true


func _on_alpaca_area_entered(area: Area2D) -> void:
	get_tree().change_scene_to_file("res://ganar.tscn")
