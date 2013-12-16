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
}

light_source {
	<1000, 1000, 0> White
}



#declare headR = 0.75;
#declare bodyR = 0.25;
#declare limbR = 0.2;
//kopf
#declare head =
  sphere{
    < 0,0, 0>,KopfR
    texture{pigment{color Orange}}
    }


//koerper
#declare  body =  
  sphere_sweep {
      linear_spline // spline type
      2, //7 number of <x,y,z> points, radius
      <0.0, 3.00,0.0>, bodyR
      < 0.00, 0.0, 0>, bodyR
      texture{
            pigment{ color Orange}
            finish { phong 1}
            } // end of texture
      scale<1,1,1>
      } // end of sphere sweep

//glied
:#declare limb =
  sphere_sweep {
        linear_spline // spline type
        2, //7 number of <x,y,z> points, radius
        <0.0, 0.0,0.0>, limbR
        < 0.50, 0.5, 0>, limbR
        texture{
            pigment{ color Orange}
            finish { phong 1}
            } // end of texture
        scale<1,1,1>
        } // end of sphere sweep
