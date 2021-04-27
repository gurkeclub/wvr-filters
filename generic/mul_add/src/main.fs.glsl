uniform float FACTOR;
uniform float OFFSET;

uniform sampler2D InputImage;

void mainImage( out vec4 fragColor, in vec2 fragCoord ){
    vec2 uv = fragCoord/iResolution.xy;

    vec3 color = texture(InputImage, uv).rgb * FACTOR + OFFSET;
    
    fragColor = vec4(color,1.0);
}
