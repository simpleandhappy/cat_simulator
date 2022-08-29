extends MeshInstance

func _ready():
	var new_material = SpatialMaterial.new()
	new_material.albedo_color = Color(0.0, 0.0, 0.0)
	self.get_mesh().surface_set_material(0, new_material)
