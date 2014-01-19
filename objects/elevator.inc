#include "transforms.inc"
#include "colors.inc"
#include "glass.inc"
#include "textures.inc"
#include "../../objects/spline_macro.inc"

#macro Elevator(ELEVATOR_LOC, height)
    box {
        <0,0,0> <10, 1, 10>
        translate <ELEVATOR_LOC.x, ELEVATOR_LOC.y + clock * (ELEVATOR_LOC.y + height), ELEVATOR_LOC.z>
        texture { Chrome_Metal }
        hollow
    }
#end