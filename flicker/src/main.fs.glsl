
uniform int BEAT_SYNC_MUL;
uniform int BEAT_SYNC_DIV;

void mainImage(out vec4 fragColor, in vec2 fragCoord) {
  vec2 uv = fragCoord / iResolution.xy;

  vec3 color = texture(iChannel0, uv).rgb;
  color = color * abs(fract(iBeat * float(BEAT_SYNC_MUL) / float(BEAT_SYNC_DIV)) * 2.0 - 1.0);

  fragColor = vec4(color, 1.0);
}
