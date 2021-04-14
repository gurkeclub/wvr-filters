uniform float DOT_DENSITY;
uniform float DOT_SIZE;


void mainImage( out vec4 fragColor, in vec2 fragCoord ){
    vec2 uv = fragCoord/iResolution.xy;

    vec3 color = vec3(0.0);
    
    float is_peak = 0.0;
    

    
    is_peak = 0.0;
    uv = (uv * 2.0 - 1.0) * iResolution.xy / iResolution.yy;

    uv = uv * DOT_DENSITY / 2.0;
    uv = fract(0.5 +  uv) * 2.0 - 1.0; 
    is_peak = max(is_peak, step(0.0, DOT_SIZE - distance(uv, vec2(0.0 , 0.0))));
    
    
    color = vec3(is_peak);  
    
    fragColor = vec4(color,1.0);
}
