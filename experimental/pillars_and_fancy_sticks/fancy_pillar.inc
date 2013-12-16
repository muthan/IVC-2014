#include "colors.inc"
#include "shapes.inc"
#include "shapes2.inc"
#include "consts.inc"
#include "glass.inc"
#include "textures.inc"




//------ Object declarations ---------
#declare Fancy_Pillar_basic = 
cone { 0, 0.3, <0, 5, 0>, 0.15
        texture {
          pigment { color rgb< 0.5, 0.5, 0>*1.2 }
        } 
     }

#declare Fancy_Pillar_basic_top = object{
  Icosahedron
  pigment { Green filter 0.8 }
  hollow
  interior{ media{
             emission <1.0,0.1,0.5>*7
          } } //Plexiglas_Ior
  finish { ambient rgb <0.4,0.2,0.5> }
  rotate <0,-360*clock, 0>
  translate <0,7,0>
}

