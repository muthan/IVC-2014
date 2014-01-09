#include "colors.inc"
#include "textures.inc"
#include "metals.inc"

// Bulb
#declare bulb = sphere {
 	<0,0,0>, 2.8
 	texture {
 		pigment { color White }
 		finish {
 			ambient 1
 			diffuse 0.6
 		}
 	}
}

// Lamp neck spline
#declare Spline_lamp_neck =	spline {
	    natural_spline
	    1, <0, 0, 0>
	    2, <-1, 15, 0>
	    3, <3, 23, 0>
	}


// The Lamp
#declare Lamp = union{

	// Lamp foot
	cylinder {
	        <0, 0, 0>, <0, 2, 0>, 5
	        texture{ pigment{ color Red }}
	}
	cylinder {
	        <0, 0, 0>, <0, 0.3, 0>, 5.1
	        texture{ pigment{ color White }}
	}

	// Button
	box {
	        <0, 0, 0>, <1.5, 0.2, 1>
	        texture{ pigment{ color White }}
	        translate <2, 2, 0>
	}
	box {
	        <0, 0, 0>, <1, 0.5, 0.6>
	        texture{ pigment{ color White }}
	        rotate <0,0,20>
	        translate <2.4, 1.8, 0.2>
	}

	// Lamp head
	union {
		cylinder {
		        <0, 0, 0>, <0, 5, 0>, 2
		        texture{ pigment{ color Red }}
		}
		difference {
			sphere {
				<0, 0, 0>, 5.0
				texture{ pigment{ color Red }}
				translate <0,-5,0>
			}
			sphere {
				<0, 0, 0>, 4.9
				texture{ pigment{ color White }}
				translate <0,-6,0>
			}
			translate <0,1,0>
		}

		light_source {
		    <0, -2.7, 0>
		    color White
		    looks_like { bulb }
		}	

		rotate <0,0,45>
		translate <5,23,0>
	}

	// Lamp neck
	union {
		#local i = 0;
		#local end_index = 3;

		#while (i <= end_index)
			sphere{ <0,0,0>, 0.5

			  pigment { color White }
			  translate Spline_lamp_neck(i)
			}
			#local i = i + 0.03;
		#end
		translate <-2,0,0>
	}

	cylinder{<0,0.05,0>, <-20,0.01,-8>, 0.3
          pigment { color White }
    }
}