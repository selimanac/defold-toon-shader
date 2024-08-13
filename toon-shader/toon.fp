#version 330

in highp vec4 var_position;
in mediump vec3 var_normal;
in mediump vec2 var_texcoord0;
in mediump vec4 var_light;
in lowp vec3 var_view_direction;

out vec4 fragColor;

// resource bindings
uniform sampler2D tex0;
uniform uniforms_fs {
  lowp vec4 toon_color;
  lowp vec4 toon_ambient_color;
  lowp vec4 toon_specular_color;
  lowp vec4 toon_glossiness;
  lowp vec4 toon_rim_color;
  lowp vec4 toon_rim_amount;
  lowp vec4 toon_rim_threshold;
  lowp vec4 toon_light_smooth_interpolation;
  lowp vec4 toon_rim_smooth;
  lowp vec4 toon_specular_smooth;
};

void main() {

  vec3 normal = vec3(normalize(var_normal));
  vec4 sample = texture(tex0, var_texcoord0.xy);
  vec3 diff_light = vec3(normalize(var_light.xyz - var_position.xyz));

  // Calculate illumination from directional light.
  // direction of the main directional light.
  float NdotL = dot(diff_light, normal);

  // Partition the intensity into light and dark, smoothly interpolated
  // between the two to avoid a jagged break.
  float light_intensity =
      smoothstep(0, toon_light_smooth_interpolation.x, NdotL);

  // Multiply by the main directional light's intensity and color.
  vec4 light = vec4(light_intensity * sample.rgba);

  // Calculate specular reflection.
  vec3 half_vector = vec3(normalize(var_light.xyz - var_position.xyz));
  float NdotH = dot(normal, half_vector);

  // Multiply toon_glossiness by itself to allow artist to use smaller
  // glossiness values in the inspector.
  float specular_intensity =
      pow(NdotH * light_intensity, toon_glossiness.x * toon_glossiness.x);
  float specular_intensity_smooth =
      smoothstep(0.005, toon_specular_smooth.x, specular_intensity);
  vec4 specular = vec4(specular_intensity_smooth * toon_specular_color);

  // Calculate rim lighting.
  float rim_dot = 1 - dot(var_view_direction, normal);
  // We only want rim to appear on the lit side of the surface,
  // so multiply it by NdotL, raised to a power to smoothly blend it.
  float rim_intensity = rim_dot * pow(NdotL, toon_rim_threshold.x);
  rim_intensity =
      smoothstep(toon_rim_amount.x - toon_rim_smooth.x,
                 toon_rim_amount.x + toon_rim_smooth.x, rim_intensity);
  vec4 rim = vec4(rim_intensity * toon_rim_color);

  fragColor = (light + toon_ambient_color + specular + rim) * toon_color *
              sample; //* sample
}