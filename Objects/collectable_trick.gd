extends Node2D

@onready var trick_animation: AnimationPlayer = $TrickAnimation
@onready var collect_particle: CPUParticles2D = $CollectParticle


func _on_area_2d_body_entered(body: Node2D) -> void:
	collect_particle.emitting = true
	var tween = get_tree().create_tween().set_trans(Tween.TRANS_SPRING)
	tween.tween_property(self, "scale", scale * 2, 0.2)
	tween.tween_property(self, "scale", scale, 0.14)
	trick_animation.play("Trick")
	
