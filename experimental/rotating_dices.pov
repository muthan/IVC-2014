#include "colors.inc"
#include "shapes.inc"
#include "shapes2.inc"
#include "consts.inc"
#include "glass.inc"
#include "textures.inc"

background { Black }

camera {
  location <4, 5, -20>
  look_at <0, 0, 0> 
  angle 36
  rotate y*-360*clock
}

light_source {
	<1000, 1000, 0> White
} 
/*
plane { y , 0
	pigment {
		White
		//checker colour Black colour White
		//scale 5
	}
	finish {
		ambient 0.2
		diffuse 0.8
	}
}
*/
box {
	<5.0, 0, 5.0> <-5.0, 0.1, -5.0>
	pigment { White }
}

object{
 	Icosahedron
	translate -2*x
	translate +2*y
	pigment { Green filter 0.8 }
	hollow
	interior{ ior Diamond_Ior } //Plexiglas_Ior
	rotate y*360*clock
}

object{
 	Icosahedron
	translate +2*x
	translate +2*y
	pigment { Col_Glass_Orange }
	hollow
	interior{ ior Diamond_Ior }
	rotate y*360*clock
}
