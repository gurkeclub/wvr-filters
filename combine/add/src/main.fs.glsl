uniform sampler2D inputImageA;
uniform sampler2D inputImageB;

void mainImage(out vec4 fragColor, in vec2 fragCoord) {
  vec2 uv = fragCoord / iResolution.xy;

  vec4 color = texture(inputImageA, uv) +  texture(inputImageB, uv);


  fragColor = color;
}
