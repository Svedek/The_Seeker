shader_type canvas_item;

uniform bool tint = false;
uniform vec3 tint_rgb = vec3(1,1,1);
uniform float mix_weight = 0.5;

void fragment() {
	vec4 texture_color = texture(TEXTURE, UV);
	if (tint) {
		vec3 tinted_texture_rgb = mix(texture_color.rgb, tint_rgb, mix_weight);
		COLOR = vec4(tinted_texture_rgb, texture_color.a);
	} else {
		COLOR = texture_color;
	}
}
