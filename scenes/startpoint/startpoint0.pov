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
object{manLooks(1) scale 0.5 rotate<0,-120,0>}

object{drone scale 0.5 translate<0, 5, 0> rotate<0,-120,0>}