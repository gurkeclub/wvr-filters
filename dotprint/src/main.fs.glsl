uniform float DOT_RADIUS;

uniform float BEAT_SYNC;
uniform float BEAT_EFFECT;

uniform float BORDER_EFFECT;
uniform float POSTERIZATION_LEVELS;

vec2 rot(vec2 p, float r) {
  return vec2(p.x * cos(r) - p.y * sin(r), p.y * cos(r) + p.x * sin(r));
}

vec3 scene_color(vec2 uv) {
  vec2 interval = vec2(DOT_RADIUS);

  // time varying density
  interval *= (1.0 - BEAT_EFFECT * cos(iBeat * BEAT_SYNC * PI));

  // border effect
  interval *=
      (1.0 + BORDER_EFFECT *
                 smoothstep(0.0, 0.25,
                            max(abs(uv.x - 0.5), abs(uv.y - 0.5)) - 0.375));

  // computation of the closest dot center;
  vec2 ref = uv - 0.5;
  ref =
      floor(ref * iResolution.xy / interval + 0.5) * interval / iResolution.xy;
  ref += 0.5;

  // initial value set to 1.0 as we're doing substractive coloring
  vec3 value = vec3(1.0);

  float lod = log2(DOT_RADIUS);

  // substraction of the neighbour ink dots
  for (int x = -1; x <= 1; x++) {
    for (int y = -1; y <= 1; y++) {
      // Currently considered ink dot center point
      vec2 center = ref + vec2(x, y) * interval / iResolution.xy;

      // Distance to the ink dot center
      float center_distance =
          length((uv - center) / (interval / iResolution.xy));

      vec3 col = textureLod(iChannel0, center, lod).rgb;
      // Color intensity for the ink dot
      col = floor(col * POSTERIZATION_LEVELS) / POSTERIZATION_LEVELS;
      col = hsv2rgb(pow(rgb2hsv(col), vec3(1.0, 1.0 / 2.0, 1.0)));

      // col = pow(col * 2.0 - 1.0, vec3(3.0)) * 0.5 + 0.5;
      // radius of the dot for each of the color components
      vec3 radius = (1.0 - col) / 1.5 * sqrt(2.0);

      // Substraction of each color component for the currently considered ink
      // dot
      value = min(value,
                  smoothstep(-1.0 / interval.x, 0.0, center_distance - radius));
    }
  }

  return vec3(value);
}

void mainImage(out vec4 fragColor, in vec2 fragCoord) {
  vec2 uv = fragCoord / iResolution.xy;
  uv.x = 1.0 - uv.x;

  vec3 col = scene_color(uv);

  float lod = log2(DOT_RADIUS);
  // col = mix(col, textureLod(iChannel0, uv, lod).rgb, step(uv.x, 0.5));

  fragColor = vec4(col, 1.0);
}