shader_type canvas_item;

uniform float progress : hint_range(0.0, 1.0) = 0.0;
void fragment() {
	// Called for every pixel the material is visible on.
	vec4 color_silhouette = vec4(vec3(1.0, 0.0, 0.0), COLOR.a);
	COLOR = mix(COLOR, color_silhouette, progress * (1.0 - COLOR.a));
}
