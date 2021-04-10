uniform sampler2D picture_a;
uniform sampler2D picture_b;
uniform sampler2D mix_mask;


void mainImage( out vec4 fragColor, in vec2 fragCoord ){
    vec2 uv = fragCoord/iResolution.xy;

    vec3 color = mix(texture(picture_a, uv).rgb, texture(picture_b, uv).rgb, texture(mix_mask, uv).r);
    
    fragColor = vec4(color,1.0);
}
