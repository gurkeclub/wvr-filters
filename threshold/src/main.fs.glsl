uniform bool MIRROR;

uniform float THRESHOLD;
uniform float THRESHOLD_SLOPE;
uniform bool THRESHOLD_REVERSE;

uniform bool CHROMA;
uniform vec3 CHROMA_FACTORS;

uniform sampler2D InputImage;

void mainImage( out vec4 fragColor, in vec2 fragCoord ){
    vec2 uv = fragCoord/iResolution.xy;
    if (MIRROR) {
        uv.x = 1.0 - uv.x;
    }

    vec3 color = texture(InputImage, uv).rgb;
    
    float is_peak = 0.0;
    if (CHROMA) {
        is_peak += dot(CHROMA_FACTORS, color);
    } else {
        is_peak = length(color);
    }
    is_peak = smoothstep(-THRESHOLD_SLOPE * 0.5, THRESHOLD_SLOPE * 0.5, is_peak - THRESHOLD);
    
    if (THRESHOLD_REVERSE) {
        is_peak = 1.0 - is_peak;
    }
    
    color = vec3(is_peak);
    
    fragColor = vec4(color,1.0);
}
