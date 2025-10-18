shader_type canvas_item;

uniform sampler2D screen_texture : hint_screen_texture;
uniform int effectsToUse;
uniform float chromeAbberStrength;

void vertex() {
	// Called for every vertex the material is visible on.
}


vec4 GrayScale(vec4 bg)
{
	float avg = (bg.r + bg.g + bg.b) / 3.0;
    return vec4(avg, avg, avg, 1.0);
}

vec4 Desaturate(vec4 bg)
{
    return vec4(bg.r / 5.0, bg.g / 5.0, bg.b / 5.0, 1.0);
}

vec4 Desagray(vec4 bg)
{
	float avg = (bg.r + bg.g + bg.b) / 3.0;
	return vec4((bg.r + avg) / 2.0, (bg.g + avg) / 2.0, (bg.b + avg) / 2.0, 1.0);
}

vec4 ChromaticAbberation(vec2 uv, float pixelSize)
{
    vec2 offset = vec2(pixelSize * chromeAbberStrength, 0.0);

    vec4 green_channel = textureLod(screen_texture, uv, 0.0);
    vec4 red_channel = textureLod(screen_texture, uv + offset, 0.0);
    vec4 blue_channel = textureLod(screen_texture, uv - offset, 0.0);

    return vec4(red_channel.r, green_channel.g, blue_channel.b, 1.0);
}

void fragment() {
	vec4 bg = textureLod(screen_texture, SCREEN_UV, 0.0);
	vec2 uv = SCREEN_UV;
	float pixelSize = SCREEN_PIXEL_SIZE.x;
	float shadersUsed = 1.0;
	vec4 shaderMix = bg;

	if(effectsToUse == 1)
	{
		shaderMix = bg;
	}
	else if((effectsToUse % 2) == 0)
	{
    	shaderMix = mix(shaderMix, GrayScale(bg), (1.0 / shadersUsed));
		shadersUsed += 1.0;
	}
	else if((effectsToUse % 3) == 0)
	{
    	shaderMix = mix(shaderMix, Desaturate(bg), (1.0 / shadersUsed));
		shadersUsed += 1.0;
	}
	else if((effectsToUse % 5) == 0)
	{
    	shaderMix = mix(shaderMix, ChromaticAbberation(uv, pixelSize), (1.0 / shadersUsed));
		shadersUsed += 1.0;
	}

	COLOR = shaderMix;
	//COLOR = bg; //So that I can get nicer images of the levels
}
