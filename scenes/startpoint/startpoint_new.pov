#include "transforms.inc"
#include "colors.inc"
#include "../../objects/maenchen.inc"
#include "../../objects/drone.inc"


background {Black}

light_source {
  <1000, 2000, 2000> White
}

camera {
    location <8,3,4>
    look_at <0,2,0>
    angle 40
}

#declare Y_spline_sustain = spline { 
    linear_spline 
        8.00, <0, 2, 0>,
        8.25, <0, 3, 0>, 
        8.50, <0, 3.5, 0>,
        9.00, <0, 4, 0>,
        10.00, <0, 4, 0>,
    }


object{drone scale 0.5 translate<0, 5, 0> rotate<0,-120,0>}

//look right - means left, since we watch from the front
#if( clock <= 2)
    object{manLooks(1, 0) scale 0.5 rotate<0,-120,0>}
#end

//look left - means right, since we watch from the front
#if( clock > 2 & clock <= 4)
    object{manLooks(-1, 2) scale 0.5 rotate<0,-120,0>}
#end

// look straight forward in the cam 
#if( clock > 4 & clock <= 6)
    object{manLooks(0, 0) scale 0.5 rotate<0,-120,0>}
#end

//look up to the drone
#if( clock > 6 & clock <= 8)
    object{man_lookup(6) scale 0.5 rotate<0,-120,0>}
#end

//look up to the drone
#if( clock > 8 & clock <= 10)
    object{man_lookup_no_movement scale 0.5 rotate<0,-120,0>}
    camera {
    location <8,3,4>
    look_at Y_spline_sustain(clock)
    angle 40
}
#end