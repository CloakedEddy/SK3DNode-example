#pragma transparent

uniform float fragIntensity;

vec4 originalColor = _output.color.rgba;
vec4 color = originalColor;

float FresnelPower = 1.0;
float fresnelFactor = 1.0;

vec3 xRayColor = color.rgb;
float fresnel = pow(1. - dot(_surface.view, _surface.normal), FresnelPower);
fresnel = (1.0-fresnelFactor) + fresnelFactor * fresnel;

// color.rb = vec2(0.0);

float videoShadow = 1.0;
float y = gl_FragCoord.y + u_time * 30.0;
if (fract(y / 16.0 / 2.0) > 0.5) {
    videoShadow = 0.0;
}

_output.color.rgba = color;
_output.color.a = 1.0;

//_output.color.rgba *= (1.0 - (1.0 - fresnel) * (videoShadow * _surface.specular.r / 0.2));
_output.color.rgba *= videoShadow;

_output.color.rgba = mix(originalColor, _output.color.rgba, fragIntensity);

if (length(_surface.emission.rgba) > 1.3) {
	_output.color.rgba = vec4(1.0);
}


float tgtLength = length(vec4(0.722,0.059,0.102,1.000));
float curLength = length(_surface.diffuse.rgba); // color of the wings will be unaffected

if (curLength - 0.1 < tgtLength && tgtLength < curLength + 0.1) {
	_output.color.rgba = originalColor;
}
