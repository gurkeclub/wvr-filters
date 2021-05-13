#version 140
uniform mat4 matrix;

uniform vec3 iResolution;

uniform float ANT_SIZE;

uniform sampler2D ants;

in vec2 position;
in vec2 tex_coords;
in int instance_id;

out vec2 v_tex_coords;

out float ant_pheromons;

void main() {
    
    int i = instance_id % int(iResolution.x);
    int j = instance_id / int(iResolution.x);
    vec4 ant_info = texelFetch(ants, ivec2(i, j), 0).rgba;
    ant_pheromons = ant_info.z;

    vec2 p = position;
    p /=iResolution.xy / ANT_SIZE;
    p+= ant_info.xy * 2.0 - 1.0;

    gl_Position = matrix * vec4(p, 0.0, 1.0);

    v_tex_coords = tex_coords;
}
