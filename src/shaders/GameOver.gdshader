shader_type canvas_item;

void fragment() {
	vec4 not_working_tex_color = texture(TEXTURE, UV);
	vec4 own_texture_color = vec4(COLOR.rgb, not_working_tex_color.a);
	
	if (own_texture_color.a == 0.0) {
		own_texture_color.a = 1.0;
	}
	
	own_texture_color.a *= 0.5 + (0.5*15.0*UV.y);
	own_texture_color.a *= 0.8 + (0.2*(sin((UV.x*10.0) + 10.0* (TIME*1.0) )));
	
	COLOR = own_texture_color;
}