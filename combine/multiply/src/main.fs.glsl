uniform sampler2D inputImageA;
uniform sampler2D inputImageB;

void mainImage( out vec4 fragColor, in vec2 fragCoord ){
    vec2 uv = fragCoord/iResolution.xy;

    vec3 color = texture(inputImageA, uv).rgb * texture(inputImageB, uv).rgb;
    
    
    fragColor = vec4(color,1.0);
}
