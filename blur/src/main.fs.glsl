uniform bool dither;

uniform sampler2D InputImage;

void mainImage(out vec4 fragColor, in vec2 fragCoord) {
  vec2 uv = fragCoord.xy / iResolution.xy;

  vec3 color = vec3(0.0);

  vec2 off = vec2(2.55) / iResolution.xy;

  for (int x = -1; x <= 1; x++) {
    for (int y = -1; y <= 1; y++) {
      vec2 dir = vec2(int(x), int(y));
      color += textureLod(InputImage, uv.xy + dir * off, 3.375).rgb * 1.0 /
               (1.0 + length(dir));
    }
  }
  color /= 4.5;

  if (dither) {
    color +=
        (rand(uv.xy + rand(fragCoord.xy * 1.0) + fract(iTime)) * 2.0 - 1.0) *
        0.5 / 255.0;
  }
  // color *= 1.5;

  fragColor = vec4(color, 1.0);
}
