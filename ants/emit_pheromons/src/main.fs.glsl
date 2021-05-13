in float ant_pheromons;


uniform float ANT_SIZE;
uniform int ANT_COUNT;


void mainImage( out vec4 fragColor, in vec2 fragCoord ) {
    vec2 uv = fragCoord/iResolution.xy;

    uv = uv * 2.0 - 1.0;

    float pheromon_intensity =  ant_pheromons * max(0.0, 1.0 - 2.0 * smoothstep(0.0, 1.0, length(uv) ));


    
    fragColor = vec4(vec3(max(0.0, pheromon_intensity)), 1.0);
}
