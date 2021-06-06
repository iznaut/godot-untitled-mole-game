extends Node


func post_import(scene):
    scene.set_script(preload("res://scripts/Room.gd"))

    var index = scene.get_child_count()

    for sr_node in scene.get_children():
        var sr_area2d = Area2D.new()        
        sr_node.replace_by(sr_area2d)
        sr_area2d.name = sr_node.name
    
        sr_area2d.get_node("Objects").set_script(preload("res://scripts/SpawnObjects.gd"))

        sr_area2d.get_node("Foreground").collision_use_parent = true
        
        sr_area2d.set_collision_layer_bit(0, false)
        sr_area2d.set_collision_mask_bit(0, false)
        sr_area2d.set_collision_layer_bit(index, true)

        index -= 1

    return scene