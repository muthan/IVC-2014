#include "colors.inc"
#include "pencil.inc"

background { White }

camera {
  location <1, 2, -5>
  look_at <0, 0, 0> 
  angle 18
  rotate y*-360*clock
}

light_source {
  <1000, 1000, 0> White
} 

//////////// object definition ///////
// table dimensions
#local H = 0.45; // height,
#local W = 0.9; // width in x and z
#local R = 0.02; // thickness
//------------------------
#declare Table_01 =
union{
   // feet
  cylinder{<0,0,0>,<0,H,0>, R
           translate< W/2-R,0,-W/2+R>}
  cylinder{<0,0,0>,<0,H,0>, R
           translate< W/2-R,0, W/2-R>}
  cylinder{<0,0,0>,<0,H,0>, R
           translate<-W/2+R,0, W/2-R>}
  cylinder{<0,0,0>,<0,H,0>, R
           translate<-W/2+R,0,-W/2+R>}
  // seat
  box{ <-W/2,-0.025,-W/2>,<W/2,0,W/2>
       translate<0,H,0> }

  pigment{ color rgb<0.75,0.5,0.3>*0.3}
}// end of union 'Table_01'
//////////////////////////////////////
// using the object:
object{ Table_01
        rotate<0,0,0>
        translate<0,0,0>
}

box {
  <0, H+0.001, -0.2> <0.15, H+0.001, 0.2>
  pigment { White }
}

object
{
        red_pencil
        scale 0.001 // to get in cms
        rotate <0, 225, 0>
        translate <0.1, H+0.005, 0>
}