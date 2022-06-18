@tool
extends MeshInstance3D

@export var size: Vector2 = Vector2(4,5): set = set_mirror_size
@export var pixels_per_unit: int = 200

@onready var viewport: SubViewport = $SubViewport
@onready var plane_mark = $PlaneTransform

var main_cam = null
var mirror_cam = null


func set_mirror_size(new_size: Vector2) -> void:
	size = new_size
	mesh.size = size
	initialize_camera()


func _ready() -> void:
	initialize_camera()


func _process(delta: float) -> void:
	main_cam = get_viewport().get_camera_3d()
	
	# Compute reflection plane and its global transform  (origin in the middle, 
	#  X and Y axis properly aligned with the viewport, -Z is the mirror's forward direction) 
	var plane_origin = plane_mark.global_transform.origin
	var plane_normal = plane_mark.global_transform.basis.z.normalized()
	var reflection_plane = Plane(plane_normal, plane_origin.dot(plane_normal))
	var reflection_transform = plane_mark.global_transform
	
	# Main camera position
	var cam_pos = main_cam.global_transform.origin 
	
	# The projected point of main camera's position onto the reflection plane
	var proj_pos = reflection_plane.project(cam_pos)
	
	# Main camera position reflected over the mirror's plane
	var mirrored_pos = cam_pos + (proj_pos - cam_pos) * 2.0
	
	# Compute mirror camera transform
	# - origin at the mirrored position
	# - looking perpedicularly into the relfection plane (this way the near clip plane will be 
	#      parallel to the reflection plane) 
	var t = Transform3D(Basis(), mirrored_pos)
	t = t.looking_at(proj_pos, reflection_transform.basis.y.normalized())
	mirror_cam.set_global_transform(t)
	
	# Compute the tilting offset for the frustum (the X and Y coordinates of the mirrored camera position
	#	when expressed in the reflection plane coordinate system) 
	var offset = reflection_transform.xform_inv(cam_pos)
	offset = Vector2(offset.x, offset.y)
	
	# Set mirror camera frustum
	# - size 	-> mirror's width (camera is set to KEEP_WIDTH)
	# - offset 	-> previously computed tilting offset
	# - z_near 	-> distance between the mirror camera and the reflection plane (this ensures we won't
	#               be reflecting anything behind the mirror)
	# - z_far	-> large arbitrary value (render distance limit form th mirror camera position)
	mirror_cam.set_frustum(mesh.size.x, -offset, proj_pos.distance_to(cam_pos), 1000.0)


func initialize_camera() -> void:
	if !is_inside_tree():
		return
		
	# Get main camera
	main_cam = get_viewport().get_camera_3d()
	
	# Free mirror camera if it already exists
	if mirror_cam != null:
		mirror_cam.queue_free()
	
	# Add a mirror camera
	mirror_cam = Camera3D.new()
	viewport.add_child(mirror_cam)
	mirror_cam.keep_aspect = Camera3D.KEEP_WIDTH
	mirror_cam.current = true
	
	# Adjust viewport size to match the actual mirror size, multiplied by the resolution ratio
	viewport.size = mesh.size * pixels_per_unit
	
	# Set material texture
	get_surface_override_material(0).albedo_texture = viewport.get_texture()
