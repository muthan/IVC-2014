#include "colors.inc"
#include "shapes.inc"
#include "consts.inc"
#include "textures.inc"


#declare Camera_Location = < -10.00, 15.00, -30.50> ; 
#declare Camera_Look_At  = < 5.00, 5.00,  0.00> ;
#declare Camera_Angle    =  75 ;


#declare Inner_Color = rgb<0,0.1,0.28>;
#declare Outer_Color = rgb<0,0.7,0.28>;
 

#declare T_Map = // transparency map
pigment{
  // need to provide relative path from executing script, which is to be found under ../../scenes/world.pov
  image_map{ jpeg "../../objects/textures/gimp_texture5.jpeg"
             interpolate 2
           } //
  warp{ cylindrical
        orientation 1 dist_exp 1 }//
  scale 0.135
} // ----------------------------------
#declare Opaque_Texture   =
texture{ pigment{color rgb<0,1,0>*1.1}
         finish {phong 0.2 }
       } // ---------------------------
#declare Surface_Material  =
material{
   texture{
      pigment_pattern{ T_Map }
      texture_map{
        [0.0 pigment{Inner_Color}]
        [0.3 pigment{Outer_Color}]
        [1.0 Opaque_Texture ]
       } 
     }
  }

#declare Surface_Material2  =
material{
   texture{
      pigment_pattern{ T_Map }
      texture_map {
        [0.0 pigment{Inner_Color}]
        [0.3 pigment{Outer_Color}]
       } 
     }
  }

#macro Surface_Material_From(inner_color, outer_color) 
material {
   texture{
      pigment_pattern{ T_Map }
      texture_map {
        [0.0 pigment{inner_color}]
        [0.3 pigment{outer_color}]
       } 
     }
  }
#end


#declare Running_Loop = 
torus{ 5.0, 1.0
       translate<1,10,0>
       material{ Surface_Material2
          scale <100,100,100> 
          rotate<360*clock, 90, 90>}
        rotate<90, 0,0>
     } //------------------------------


#declare Running_Loop2 = 
torus{ 5.0, 1.0
       translate<-5,-1,0>
       material{ Surface_Material2
          scale <1,1,1> 
          rotate<360*clock, 90, 90>}
        rotate<90, 0,0>
     } //------------------------------

