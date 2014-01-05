#include "colors.inc"
#include "../objects/pencil.inc"
#include "../objects/table.inc"
#include "../objects/desklamp.inc"

background { Black }

camera {
  location <1, 2, -5>
  look_at <0, 0.3, 0> 
  angle 18
  rotate y*-360*clock
}

light_source {
  <-1000, 200, -200> White
} 

object { Table
        rotate<0,0,0>
        translate<0,0,0>
}

box {
  <0, 0.5+0.001, -0.2> <0.15, 0.5+0.001, 0.2>
  translate <0,0,-0.1>
  pigment { White }
}

object { red_pencil
        scale 0.001
        rotate <0, 225, 0>
        translate <0.15, 0.5+0.002, -0.1>
}

object { desk_lamp
        scale 0.01
        rotate<0,-50,0>
        translate <0.3,0.5,0.3>
}