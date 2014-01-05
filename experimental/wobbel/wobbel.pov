#include "colors.inc"
#include "shapes.inc"
#include "consts.inc"
#include "glass.inc"
#include "textures.inc"

//include for positioning utils 
#include "/home/flx/workspace/povray/IVC/experimental/util/positioning_utils.inc"

#include "rand.inc" // random functions include file
#include "transforms.inc" // for Reorientate_Trans
#declare Random_1 = seed (23528);
#declare Random_2 = seed (23);
#declare Random_3 = seed (40);

#declare Camera_Location = < -10.00, 10.00, -30.50> ; 
#declare Camera_Look_At  = < 5.00, 5.00,  0.00> ;
#declare Camera_Angle    =  75 ;
 
background {White}

camera{ // wide angle 
        location Camera_Location
        right    x*image_width/image_height
        angle    Camera_Angle
        look_at  Camera_Look_At
      }

light_source{< 3000,3000,-3000> color rgb<1,1,1>*0.9}
light_source{ Camera_Location   color rgb<0.9,0.9,1>*0.1 shadowless}

#declare Wobbel = 
union {
 #local i = 0; 
 #local end_index = 150;
 #while (i < end_index)
   // differ a little bit form spherical position:
   #local LowOffset = 0.4;
   #local RandScale = (1+0.1*rand(Random_1)); 
   #local Position  = RandScale * VRand_On_Sphere(Random_1);
   #local RandDirection = LowOffset + (1 - abs(2 * clock -1)) * 0.7;
   #local Random = rand(Random_1);
   
   union{

   cone{ <0,0,0>, 0.02, Position, 0.01 
        scale<RandDirection, RandDirection, RandDirection>
         texture { pigment{ color rgb< 0.1, 0.85, 0.5> }  
                   normal { bumps 0.5 scale 0.05 }
                   finish { phong 1 }
                 } 
        }

   sphere{ <0,0,0>, 0.1 
           scale <1,0.5,1>*1.2*RandDirection 
           // turn it in direction zero to Position:
           Reorient_Trans( <0,1,0>, Position )
           translate Position*RandDirection // move it to position
           texture{ pigment{ color rgb< rand(Random_2), 0.85, 1.0> }
                    normal { bumps 0.5 scale 0.05 }
                    finish { phong 1 }
                  } 
         } 
   }
 #local i = i + 1; 
 #end 
 rotate<180*clock,360*clock,-180*clock>

 translate<0,1.25,0>
 rotate<0,0,0>
} // end of union


//object{PositionAsTriangle_3D(Wobbel, 0, 0, 0, 10) }
object{Wobbel scale 10}


