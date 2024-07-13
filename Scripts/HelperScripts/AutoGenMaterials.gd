extends Node
func _ready():
	var folder_path = "res://Assets/Models/Industrial_exterior_v2/Textures/"  # Replace with your actual folder path
   
	var image_files = DirAccess.get_files_at(folder_path)

	for file in image_files:
		if not file.ends_with(".png") and not file.ends_with(".jpg") and not file.ends_with(".tga"):  # Check for PNG or JPG images
			continue
		var image_path = folder_path + file
		var image = load(image_path)
		if not image:
			print("Error loading image:", image_path)
			continue

		var material = StandardMaterial3D.new()
		material.albedo_texture = image

		var save_path = folder_path + file.split(".")[0] + ".tres"  # Save material with same name (excluding extension)
		ResourceSaver.save(material, save_path)
		print("Saved material:", save_path)
