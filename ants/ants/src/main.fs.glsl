uniform float PHEROMON_DECAY;
uniform float ANT_SIZE;
uniform float ANT_EXPLORATION;
uniform float ANT_GROUPING;
uniform float ANT_REINFORCEMENT;
uniform bool RESET;

uniform sampler2D ants;
uniform sampler2D pheromons;
uniform sampler2D food;


void mainImage( out vec4 fragColor, in vec2 fragCoord ) {
    vec2 uv = fragCoord/iResolution.xy;
    
    vec4 ant_info = texture(ants, uv).rgba;
    
    
    if (iFrame == 0 || RESET) {
        ant_info = vec4(0.0);
        ant_info.xy = vec2(rand(uv), rand(uv + fract(uv *4.123) + 0.1));
    }
    if (iFrame < 10 || RESET) {
        ant_info.w = (rand(uv) * 2.0 - 1.0) * PI;
    }
    
    
    vec2 ant_pos = ant_info.xy;
    
    float ant_pheromons = ant_info.z;
    float ant_direction = ant_info.w;
    ant_direction = mod(ant_direction, 2.0 * PI);
    
    float ant_on_peak = texture(food, ant_pos).r;
    
    float ant_speed = 0.5;
    ant_speed += 0.25 * ant_on_peak;
    ant_speed += 0.25 * ant_pheromons;
    ant_speed = clamp(ant_speed, 0.0, 1.0);
    ant_speed = mix(ant_speed, 2.0, smoothstep(-PHEROMON_DECAY, 0.0, - ant_pheromons));
    ant_speed *= max(ANT_SIZE / 2.0, 2.0);
    
    vec2 stream_direction = vec2(0.0);
    float stream_strength = 0.0;
    float sniffed_pheromons = 0.0;

    vec2 ant_direction_cart = vec2(cos(ant_direction), sin(ant_direction));
    
    vec2 ant_nose = ant_pos;
    ant_nose += 4.0 * ANT_SIZE * ant_direction_cart / iResolution.xy;
    
    sniffed_pheromons = texture(pheromons, ant_nose).g;
    
    stream_direction = vec2(
    	texture(pheromons, ant_nose + vec2(1.0, 0.0) / iResolution.xy).g - texture(pheromons, ant_nose - vec2(1.0, 0.0) / iResolution.xy).g,
    	texture(pheromons, ant_nose + vec2(0.0, 1.0) / iResolution.xy).g - texture(pheromons, ant_nose - vec2(0.0, 1.0) / iResolution.xy).g
	);
	
    
    stream_strength = length(stream_direction);
    stream_direction = normalize(stream_direction);

    float grouping_factor = 1.0;
    grouping_factor *= clamp(1.0 - ant_on_peak, 0.0, 1.0);
    grouping_factor *= smoothstep(PHEROMON_DECAY, PHEROMON_DECAY * 4.0, sniffed_pheromons);
    grouping_factor *= 1.0 - smoothstep(1.5, 2.0, sniffed_pheromons);
    grouping_factor *= 1.0 - ANT_EXPLORATION * smoothstep(1.5, 2.0, ant_pheromons);
    grouping_factor *= ANT_GROUPING;
    
    float exploration_factor = 1.0;
    exploration_factor *= 1.0 - 0.5 *smoothstep(1.5, 2.0, ant_pheromons);
    exploration_factor *= smoothstep(0.0, PHEROMON_DECAY, ant_pheromons);
    exploration_factor = max(exploration_factor, ant_on_peak);
    exploration_factor *= ANT_EXPLORATION;
    
    float exploration = PI * 2.0 * (rand(uv + vec2(iTime  / 100.0, uv.x + uv.y)) * 2.0 - 1.0);
    vec2 exploration_cart = vec2(cos(exploration), sin(exploration)); 

    if (stream_strength > PHEROMON_DECAY) {
        ant_direction_cart = normalize(mix(ant_direction_cart, stream_direction, grouping_factor));
    }
    ant_direction_cart = normalize(mix(ant_direction_cart, exploration_cart, exploration_factor));
    

    ant_direction = atan(ant_direction_cart.y, ant_direction_cart.x);


    
    ant_pos = ant_pos + ant_speed * vec2(cos(ant_direction), sin(ant_direction)) / iResolution.xy;
    ant_pheromons += PHEROMON_DECAY * max(ant_on_peak * 100.0, ANT_REINFORCEMENT * smoothstep(-2.0, -1.0, -sniffed_pheromons));
    ant_pheromons -= PHEROMON_DECAY;
    //ant_pheromons *= 1.0 - step(-16.0 / iResolution.x, abs(ant_pos.x - 0.5) - 0.5);
    //ant_pheromons *= 1.0 - step(-16.0 / iResolution.y, abs(ant_pos.y - 0.5) - 0.5);
    ant_pheromons = clamp(ant_pheromons, 0.0, 2.0);
     
    
    ant_pos = fract(ant_pos);
    
    fragColor = vec4(ant_pos, ant_pheromons, ant_direction);
}
