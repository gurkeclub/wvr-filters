uniform bool MIRROR;

uniform float THRESHOLD;
uniform float THRESHOLD_SLOPE;
uniform bool THRESHOLD_REVERSE;

uniform bool CHROMA;
uniform vec3 CHROMA_FACTORS;

uniform sampler2D InputImageA;
uniform sampler2D InputImageB;

void mainImage( out vec4 fragColor, in vec2 fragCoord ){
    vec2 uv = fragCoord/iResolution.xy;

    vec3 color = texture(InputImageA, uv).rgb * texture(InputImageB, uv).rgb;
    
    
    fragColor = vec4(color,1.0);
}
