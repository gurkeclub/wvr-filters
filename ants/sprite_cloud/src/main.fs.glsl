in float ant_pheromons;


uniform sampler2D sprite;

uniform float ANT_SIZE;
uniform int ANT_COUNT;


void mainImage( out vec4 fragColor, in vec2 fragCoord ) {
    vec2 uv = fragCoord/iResolution.xy;


    float pheromon_intensity =  smoothstep(0.5, 1.5, ant_pheromons);// * smoothstep(0.0, 0.05, 0.5 - length(uv - 0.5) - 0.05 );

    vec3 color = texture(sprite, uv).rgb;
    color = 1.0 - color;
    color *= pheromon_intensity;


    
    fragColor = vec4(color, 1.0);
}
