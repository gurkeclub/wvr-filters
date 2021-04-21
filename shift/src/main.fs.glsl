uniform vec2 OFFSET;

uniform sampler2D inputImage;

void mainImage( out vec4 fragColor, in vec2 fragCoord ){
    vec2 uv = fragCoord/iResolution.xy;

    vec3 color = texture(inputImage, uv - OFFSET).rgb ;
    

    fragColor = vec4(color,1.0);
}
