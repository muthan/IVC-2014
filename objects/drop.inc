#include "colors.inc"
#include "transforms.inc"


#declare Drop = sphere_sweep {
    b_spline // spline type
    6 // number of
       //<x,y,z>points, radius
    <0, 0, 0>, 0.25
    <0.5, 0, 0.5>, 0.5
    <0.25, 1.0, 0.25>, 0.35
    <0.125, 2, 0.125>, 0.15
    <0.06, 3, 0.06>, 0.05
    <0.0375, 3, 0.0375>, 0.01
    texture{
      pigment{ color rgb<0.2,0.2,0.70>}
      finish { phong 0.5}
    }
   };
        