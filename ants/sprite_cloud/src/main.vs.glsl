#version 140
uniform mat4 matrix;

uniform vec3 iResolution;
uniform sampler2D ants;
uniform float ANT_SIZE;

in vec2 position;
in vec2 tex_coords;
in int instance_id;

out vec2 v_tex_coords;
out float ant_pheromons;

#define PI 3.141592653

vec2 rot2(vec2 p, float r) {
  return vec2(
    cos(r) * p.x - sin(r) * p.y,
    cos(r) * p.y + sin(r) * p.x
  );
}

void main() {
    
    int i = instance_id % int(iResolution.x);
    int j = instance_id / int(iResolution.x);
    vec4 ant_info = texelFetch(ants, ivec2(i, j), 0).rgba;
    ant_pheromons = ant_info.z;

    vec2 p = position;
    p = rot2(p - 0.5, ant_info.w - PI / 2.0) + 0.5;
    p /=iResolution.xy / (ANT_SIZE * (0.1 + 0.9 * ant_pheromons));
    p+= ant_info.xy * 2.0 - 1.0;


    gl_Position = matrix * vec4(p, 0.0, 1.0);

    v_tex_coords = tex_coords;
}
