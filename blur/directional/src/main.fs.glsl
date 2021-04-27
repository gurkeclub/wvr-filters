uniform bool dither;

uniform sampler2D InputImage;

uniform bool VERTICAL;


void mainImage(out vec4 fragColor, in vec2 fragCoord) {
  vec2 uv = fragCoord.xy / iResolution.xy;

  vec4 color = vec4(0.0);

  vec2 offset = vec2(1.0, 0.0);
  if (VERTICAL) {
    offset = vec2(0.0, 1.0);
  }

  offset /= iResolution.xy;

     color += texture(InputImage, uv - offset * 4.0) * 0.05;
   color += texture(InputImage, uv - offset * 3.0) * 0.09;
   color += texture(InputImage, uv - offset * 2.0) * 0.12;
   color += texture(InputImage, uv - offset) * 0.15;
   color += texture(InputImage, uv) * 0.16;
     color += texture(InputImage, uv + offset * 4.0) * 0.05;
   color += texture(InputImage, uv + offset * 3.0) * 0.09;
   color += texture(InputImage, uv + offset * 2.0) * 0.12;
   color += texture(InputImage, uv + offset) * 0.15;

  fragColor = color;
}
