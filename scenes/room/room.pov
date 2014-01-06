#include "colors.inc"
#include "transforms.inc"
#include "../../objects/pencil.inc"
#include "../../objects/table.inc"
#include "../../objects/desklamp.inc"
#include "../../experimental/spline/spline_macro.inc"
#include "../../objects/tornado.inc"

background { Black }

camera {
  location <1, 2, -5>
  look_at <0.6, 0.3, 0> 
  angle 18
}

light_source {
  <-1000, 200, -200> White
} 

object { Table
        rotate<0,0,0>
        translate<0.5,0,0>
}

//paper 
box {
  <0, 0.5+0.001, -0.2> <0.15, 0.5+0.001, 0.2>
  translate <0.45,0,-0.1>
  pigment { White }
}

object { red_pencil
        scale 0.001
        rotate <0, 225, 0>
        translate <0.60, 0.5+0.002, -0.1>
}

object { desk_lamp
        scale 0.01
        rotate<0,-50,0>
        translate <0.8,0.5,0.3>
}

#declare Tornado_spline = spline {TornadoSpline(1, 0.5, 4)}
object { Tornado(1)
  scale 0.03
  Spline_Trans(Tornado_spline, clock, y, 0.1, 0.5)
}
