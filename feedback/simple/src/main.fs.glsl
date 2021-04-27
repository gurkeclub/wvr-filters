uniform sampler2D image;
uniform sampler2D feedback;
uniform sampler2D feedback_mask;

uniform vec2 FEEDBACK_OFFSET;
uniform float FEEDBACK_DECAY;
uniform bool INVERT_MASK;

void mainImage( out vec4 fragColor, in vec2 fragCoord ){
    vec2 uv = fragCoord/iResolution.xy;

    vec3 input_color = texture(image, uv).rgb;
    vec3 feedback_mask = texture(feedback_mask, uv).rgb;
    vec3 feedback_color = texture(feedback, uv - FEEDBACK_OFFSET / iResolution.xy).rgb;

    if (INVERT_MASK) {
        feedback_mask = 1.0 - feedback_mask;
    }

    vec3 color = mix(input_color, feedback_color - vec3(FEEDBACK_DECAY), feedback_mask);

    color = clamp(color, vec3(0.0), vec3(1.0));
    
    fragColor = vec4(color,1.0);
}
