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


sphere{
  < 0,3, 0>,0.75 
  texture{pigment{color Orange}}
  }



sphere_sweep {
      linear_spline // spline type
      2, //7 number of <x,y,z> points, radius
      <0.0, 3.00,0.0>, 0.25
      < 0.00, -1.0, 0>, 0.25
      texture{
            pigment{ color Orange}
            finish { phong 1}
            } // end of texture
      scale<1,1,1>
      rotate<0,0,0>
      translate<0,0.5,0>
      } // end of sphere sweep


sphere_sweep {
      linear_spline // spline type
      4, //7 number of <x,y,z> points, radius
      <0.0, 1.50,0.0>, 0.25
      < 1.50, 2.0, 0>, 0.25
      < 1.70, 3.0, 0>, 0.25
      < 1.50, 3.0, 0>, 0.25
      texture{
            pigment{ color Orange}
            finish { phong 1}
            } // end of texture
      scale<1,1,1>
      rotate<0,0,0>
      translate<0,0.5,0>
      } // end of sphere sweep

      
