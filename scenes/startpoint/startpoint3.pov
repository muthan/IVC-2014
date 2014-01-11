#include "transforms.inc"
#include "colors.inc"
#include "../../objects/maenchen.inc"
#include "../../objects/drone.inc"


background {Black}

light_source {
  <1000, 2000, 2000> White
}


#declare Y_spline_sustain = spline { 
    linear_spline 
        0.00, <0, 2, 0>,
        0.25, <0, 3, 0>, 
        0.50, <0, 3.5, 0>,
        1.00, <0, 4, 0>,
        2.00, <0, 4, 0>,
    }

camera {
    location <8,3,4>
    look_at Y_spline_sustain(clock)
    angle 40
}
object{man_normal scale 0.5 rotate<0,-120,0>}

object{drone scale 0.5 translate<0, 5, 0> rotate<0,-120,0>}