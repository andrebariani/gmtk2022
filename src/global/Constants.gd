extends Node


enum {MELEE, RANGED, SUPPORT}
enum { TOP, LEFT, FRONT, RIGHT, BEHIND, DOWN }

var enemy_colors = {MELEE:Color(255, 0, 0),
	RANGED:Color(0, 255, 0), SUPPORT:Color(0, 0, 255)}
