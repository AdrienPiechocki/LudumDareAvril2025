shader_type canvas_item;

uniform float fSpeed = 0.8;

void vertex()
{
	UV.y += TIME * fSpeed;
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
