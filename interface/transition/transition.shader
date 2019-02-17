shader_type canvas_item;

uniform float value: hint_range(0.0, 1.0, 0.01) = 0.0;
uniform vec2 offset = vec2(0.0);

void fragment() {
	vec2 screen_size = 1.0 / SCREEN_PIXEL_SIZE;
	vec2 coord = UV.xy * screen_size - offset;
	
	float bounds = max(screen_size.x, screen_size.y) * sqrt(2.0);
	COLOR.a = step(value * bounds, length(coord));
}
