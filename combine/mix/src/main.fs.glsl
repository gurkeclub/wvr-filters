uniform sampler2D picture_a;
uniform sampler2D picture_b;
uniform sampler2D mix_mask;

uniform bool USE_MASK;
uniform float MIX;


void mainImage( out vec4 fragColor, in vec2 fragCoord ){
    vec2 uv = fragCoord/iResolution.xy;

    vec3 mix_factor = vec3(0.0);
    if (USE_MASK) {
        mix_factor = texture(mix_mask, uv).rgb;
    } else {
        mix_factor = vec3(MIX);
    }

    vec3 color = mix(texture(picture_a, uv).rgb, texture(picture_b, uv).rgb, mix_factor);
    
    fragColor = vec4(color,1.0);
}
