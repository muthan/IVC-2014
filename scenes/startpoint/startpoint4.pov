#include "transforms.inc"
#include "colors.inc"
#include "../../objects/maenchen.inc"
#include "../../objects/drop.inc"
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


object{man_lookup_no_movement scale 0.5 rotate<0,-120,0>}
//initial idea: drop on his head, should show that he is thinking something -- but the drops shadow does not look nice.
//object{Drop scale 0.1 translate<0.2,2,0.3>}

object{drone scale 0.5 translate<0, 5, 0> rotate<0,-120,0>}