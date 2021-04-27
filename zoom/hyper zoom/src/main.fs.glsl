
uniform float MAGNITUDE;


void mainImage(out vec4 fragColor, in vec2 fragCoord) {
  vec2 uv = fragCoord / iResolution.xy;
  
  uv -= 0.5;
  uv /= (1.0 + MAGNITUDE * smoothstep(0.0, 2.0, 2.0 * length(uv.xy * iResolution.xy / iResolution.yy) - 1.0 + 1.0 * MAGNITUDE));
  uv += 0.5;

  vec3 col = texture(iChannel0, uv).rgb;


  fragColor = vec4(col, 1.0);
}