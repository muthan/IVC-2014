#include "colors.inc"
#include "rand.inc" // random functions include file
#include "transforms.inc" // for Reorientate_Trans
#declare Random_1 = seed (23528);
#declare Random_2 = seed (23);
#declare Random_3 = seed (40);

#macro Wobbel(Clock_speed, Final_Clock)
union {
 #local i = 0; 
 #local end_index = 150;
 #while (i < end_index)
   
   #local LowOffset = 0.4;
   #local RandScale = (1+0.1*rand(Random_1)); 
   #local Position  = RandScale * VRand_On_Sphere(Random_1);
   #local RandDirection = LowOffset + ((1*Clock_speed*Final_Clock - abs(2 * Clock_speed* clock -1*Clock_speed*Final_Clock) )/(Clock_speed*Final_Clock)) * 0.7;
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
           
           Reorient_Trans( <0,1,0>, Position )
           translate Position*RandDirection 
           texture{ pigment{ color rgb< rand(Random_2), 0.85, 1.0> }
                    normal { bumps 0.5 scale 0.05 }
                    finish { phong 1 }
                  } 
         } 
   }
 #local i = i + 1; 
 #end 
 rotate<180*clock*Clock_speed*Final_Clock,360*clock*Clock_speed*Final_Clock,-180*clock*Clock_speed*Final_Clock>

 translate<0,1.25,0>
 rotate<0,0,0>
}
#end




