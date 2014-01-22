#include "colors.inc"
#include "woods.inc"

#declare red_pencil= union{
	cylinder{
		<0,0,0>, <40,0,0>, 1
		texture { pigment { Red } }
	}
	difference{
		cone{
			<40,0,0>, 1 <45,0,0>, 0.1
			texture {
				T_Wood35
				finish{
			        specular 0.15
			        roughness 0.025
			        ambient 0.25
			        reflection 0
				}
			}
		}
		cylinder{
			<44,0,0>, <45,0,0>, 1
		}
	}
	cone{
		<40,0,0>, 0.9 <45,0,0>, 0.1
		texture {
			pigment { rgb <0.1, 0.1, 0.1> }
			finish { Dull }
		}
	}
}