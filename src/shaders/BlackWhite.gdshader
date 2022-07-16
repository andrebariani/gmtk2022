shader_type canvas_item;

uniform bool active = false;

void fragment() {
	vec3 c = texture(TEXTURE, UV).rgb;
	
	if (!active)
		COLOR.rgb = c;
	else {
		float avg = (c.r + c.g + c.b) / 3.0;
		COLOR.rgb = vec3(avg);
	}
}
