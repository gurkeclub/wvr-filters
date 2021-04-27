uniform bool FLIP_VERTICAL;
uniform bool FLIP_HORIZONTAL;

void mainImage(out vec4 fragColor, in vec2 fragCoord) {
  vec2 uv = fragCoord / iResolution.xy;

  if (FLIP_VERTICAL) {
    uv.y = 1.0 - uv.y;
  }
  if (FLIP_HORIZONTAL) {
    uv.x = 1.0 - uv.x;
  }

  vec3 color = texture(iChannel0, uv).rgb;

  fragColor = vec4(color, 1.0);
}
