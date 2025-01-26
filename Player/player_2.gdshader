shader_type canvas_item;

uniform vec4 line_color : source_color = vec4(1.0);
uniform float line_thickness : hint_range(0, 10) = 1.0;
uniform float alpha_threshold : hint_range(0, 1) = 0.5; // New threshold control

const vec2 OFFSETS[8] = {
	vec2(-1, -1), vec2(-1, 0), vec2(-1, 1), vec2(0, -1), vec2(0, 1), 
	vec2(1, -1), vec2(1, 0), vec2(1, 1)
};

void fragment() {
	vec2 size = TEXTURE_PIXEL_SIZE * line_thickness;
	float outline = 0.0;
	
	vec4 center_color = texture(TEXTURE, UV);
	
	// Only calculate outline if current pixel is transparent
	if (center_color.a < alpha_threshold) {
		for (int i = 0; i < OFFSETS.length(); i++) {
			vec2 sample_uv = UV + size * OFFSETS[i];
			sample_uv = clamp(sample_uv, vec2(0.0), vec2(1.0));
			float neighbor_alpha = texture(TEXTURE, sample_uv).a;
			// Only count fully opaque neighbors
			if (neighbor_alpha >= alpha_threshold) {
				outline = 1.0;
				break; // Exit early if we find any qualifying pixel
			}
		}
	}
	
	COLOR = mix(center_color, line_color, outline);
}