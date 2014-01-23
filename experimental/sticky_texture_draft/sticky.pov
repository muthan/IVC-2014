//#include "colors.inc"
//#include "transforms.inc"
//#include "../../objects/pencil.inc"
//#include "../../objects/table.inc"
//#include "../../objects/lamp.inc"
//#include "../../objects/spline_macro.inc"
//#include "../../objects/tornado.inc"
#include "../../objects/maenchen.inc"

background { White }

camera {
  location <0, 4, -6>
  look_at <0, 2.5, 0> 
  //angle 18
}

light_source {
  <0, 5, -100> Black
}

object { manLooks(0)
  texture{ pigment{ Black } }
}