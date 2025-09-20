// Example of an outline shader structure (details vary based on approach)
shader_type spatial;
render_mode unshaded; // Makes the outline not affected by lighting

uniform sampler2D screen_texture; // To sample the entire screen
uniform vec4 outline_color;
uniform float outline_width;
uniform vec2 pixel_size; // Represents the size of one pixel

void fragment() {
    // Sample the screen color at the current pixel
    vec4 current_color = texture(screen_texture, UV);

    // Check neighboring pixels to detect edges (depth and normal comparison)
    // ... calculate differences in depth and normals ...

    if (/* edge detected */) {
        ALBEDO = outline_color.rgb;
        ALPHA = 1.0;
    } else {
        ALBEDO = current_color.rgb;
        ALPHA = current_color.a;
    }
}