uniform float DIFFUSE_DECAY;
uniform float INTEGRATE_DECAY;


uniform sampler2D emitted_pheromons;
uniform sampler2D pheromons;

void mainImage( out vec4 fragColor, in vec2 fragCoord ) {
    vec2 uv = fragCoord/iResolution.xy;

    float pixel_pheromons = clamp(texture(emitted_pheromons, uv).r, 0.0, 1.0);
    float pheromons_integration = texture(pheromons, uv).g;
    
    float pheromons_diffusion = 0.0;
    for (int x = -1; x<=1; x++) {
        for (int y = -1; y<=1; y++) {
        	vec2 peeking_pos = fract(uv + vec2(float(x) * 1.5, float(y) * 1.5) / iResolution.xy);
            pheromons_diffusion += texture(pheromons, peeking_pos).r;
        }
    }
    pheromons_diffusion /= 9.0;
    
    pheromons_diffusion = max(pixel_pheromons, pheromons_diffusion - DIFFUSE_DECAY);
    
    
    
    pheromons_diffusion = clamp(pheromons_diffusion, 0.0, 2.0);
    
    pheromons_integration = mix(pheromons_diffusion, pheromons_integration + pheromons_diffusion, 1.0 - INTEGRATE_DECAY) ;
    
    pheromons_integration = clamp(pheromons_integration, 0.0, 1.0);
    
    fragColor = vec4(pheromons_diffusion, pheromons_integration, texture(emitted_pheromons, uv).g,1.0);
}
