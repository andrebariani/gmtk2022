shader_type canvas_item;

uniform bool active = false;
uniform float saturation = 1.0;
uniform int color = 0; // 0 for red, 1 for green, 2 for blue

void fragment() {
	vec4 tex = texture(TEXTURE, UV);
	vec3 c = tex.rgb;
	
	if (active) {
		float avg = (c.r + c.g + c.b) / 3.0;
		COLOR.rgb = vec3(avg);
	}
	else {
		COLOR.rgb = vec3(1, 1, 1);
		
		// If the selected color is not the primary color, reduce saturation
		if (color != 1) {
			float avg = (c.r + c.g + c.b) / 3.0;
			c.r = (c.r * saturation) + (avg * (1.0 - saturation));
			c.g = (c.g * saturation) + (avg * (1.0 - saturation));
			c.b = (c.b * saturation) + (avg * (1.0 - saturation));
		}
		
		COLOR.rgb = c;
	}
	COLOR.a = tex.a; 
}