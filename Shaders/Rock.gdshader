shader_type canvas_item;

uniform float speed = 2.0;

vec2 rotateUV(vec2 vUV, float fRotation) {
	float fCosa = cos(fRotation);
	float fSina = sin(fRotation);
	return vec2(
		fCosa * vUV.x - fSina * vUV.y,
		fCosa * vUV.y + fSina * vUV.x
	);
}

void vertex() {
	VERTEX = rotateUV(VERTEX, TIME * speed);
}