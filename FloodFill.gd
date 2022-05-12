extends Node2D

const TILE_SIZE = 16
onready var map := $TileMap

enum Tiles {
	WATER,
	GRASS
}
var used_rect: Rect2
var queue: Array = []

onready var start_cell: Vector2


func _ready() -> void:
	var s_cell = Vector2(34,20)
	queue.append(s_cell)
	used_rect = map.get_used_rect()


func flood_fill():
	while !queue.empty():
		var c_cell = queue[0]
		queue.pop_front()
		if c_cell.x >=0 and c_cell.x < used_rect.size.x and c_cell.y >=0 and c_cell.y < used_rect.size.y:# and (map.get_cellv(c_cell) != Tiles.WATER):# or (map.get_cellv(c_cell) != Tiles.GRASS)):
			if map.get_cellv(c_cell) != Tiles.WATER and map.get_cellv(c_cell) != Tiles.GRASS:
				map.set_cellv(c_cell, Tiles.WATER)
				queue.append(Vector2(c_cell.x - 1, c_cell.y))
				queue.append(Vector2(c_cell.x + 1, c_cell.y))
				queue.append(Vector2(c_cell.x, c_cell.y - 1))
				queue.append(Vector2(c_cell.x, c_cell.y + 1))
		
		yield(get_tree(), "idle_frame")


func _physics_process(delta: float) -> void:
	flood_fill()
