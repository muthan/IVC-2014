//--- joke file for throwing in every shit found on the web we want to play with

#include "colors.inc"
#include "colors.inc"
#include "shapes.inc"
#include "shapes2.inc"
#include "consts.inc"
#include "glass.inc"
#include "textures.inc"

#declare Strength = 1.00;
// +/- strength of component's radiating density
#declare Radius  = 1.00;
//(0 < Radius) outer sphere of influence
// on other components

background { White }

camera {
  location <4, 10, -10>
  look_at <0, 0, 0> 
  angle 36
  rotate y*-360*clock
}

light_source {
    <1000, 1000, 0> White
}

blob{
  threshold 0.6
  // threshold (0.0 < threshold <= Strength)
  // surface falloff threshold number
  cylinder{<-1,0,0>,< 1,0,0>,Radius,Strength}
  sphere{  < 0,1.25,0>,Radius,Strength}
  sphere{  < 0,0,-1.25>,Radius,Strength}
  //  a negative component:
  sphere{  < 0,1.50,0>,Radius/2,-Strength}
  // sturm
  scale 1
  rotate<0,0,0>
  translate<0,0.5,0>
  texture{ pigment{ color rgb<0.7,1,0.0>}
           finish { phong 1}}
 } 