extends RigidBody

export (float, 1, 100) var min_throw_speed := 25
export (float, 2, 200) var max_throw_speed := 50


func throw_dice():
	var throw_direction = Vector3(rand_range(-1, 1), rand_range(0, -0.5), rand_range(-1, 1))
	var throw_speed = rand_range(min_throw_speed, max_throw_speed)
	
	self.sleeping = false
	self.apply_impulse(Vector3(0,0,0), throw_direction * throw_speed)
	self.apply_torque_impulse(throw_direction * 20)


func reset_dice(spawn_position : Vector3):
	self.sleeping = true
	self.set_translation(spawn_position)
	self.set_rotation(Vector3(rand_range(0, 360), rand_range(0, 360), rand_range(0, 360)))
