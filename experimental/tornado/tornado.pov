#include "colors.inc"
#include "shapes.inc"
#include "shapes2.inc"
#include "consts.inc"
#include "glass.inc"
#include "textures.inc"

background { White }

camera {
  location <4, 5, -20>
  look_at <0, 0, 0> 
  angle 36
  rotate y*-360*clock
}

light_source {
	<1000, 1000, 0> White
}

sphere {
	0, 1.5
	pigment { rgbt 1 }
	hollow
	interior {
		media {
			absorption 7
			density {
				spherical density_map {
					[ 0 rgb 0 ]
					[ 0.5 rgb 0 ]
					[ 0.7 rgb .5 ]
					[ 1 rgb 1 ]
				}
				scale 1/2
				warp { turbulence 0.5 }
				scale 2
			}
		}
	}
	scale <1.5 ,6 ,1.5 > translate y
	rotate y*360*clock
}