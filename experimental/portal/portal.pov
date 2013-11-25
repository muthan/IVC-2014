#include "colors.inc"
#include "shapes.inc"
#include "consts.inc"
#include "glass.inc"
#include "textures.inc"

//---------------------------------------------------------
#include "rand.inc" // random functions include file
#include "transforms.inc" // for Reorientate_Trans
#declare Random_1 = seed (23528);
#declare Random_2 = seed (23);
#declare Random_3 = seed (40);

//---------------------------------------------------------

//---------------------------------------------------------------------------------
//---------------------------------------------------------------------------------
#declare Camera_Number = 0 ;
//---------------------------------------------------------------------------------
// camera -------------------------------------------------------------------------
#switch ( Camera_Number )
#case (0)
  #declare Camera_Location = < 0.00, 1.00, -3.00> ;  // front view
  #declare Camera_Look_At  = < 0.00, 1.20,  0.00> ;
  #declare Camera_Angle    =  65 ;
#break
#case (1)
  #declare Camera_Location =  < 2.0 , 2.5 ,-3.0> ;  // diagonal view
  #declare Camera_Look_At  =  < 0.0 , 1.0 , 0.0> ;
  #declare Camera_Angle    =  90 ;
#break
#case (2)
  #declare Camera_Location = < 3.0, 1.0 , 0.0> ;  // right side view
  #declare Camera_Look_At  = < 0.0, 1.0,  0.0> ;
  #declare Camera_Angle    =  90 ;
#break
#case (3)
  #declare Camera_Location = < 0.00, 5.00,  0+0.000> ;  // top view
  #declare Camera_Look_At  = < 0.00, 0.00,  0+0.001> ;
  #declare Camera_Angle    = 90 ;
#break
#else
  #declare Camera_Location = < 0.00, 1.00, -3.50> ;  // front view
  #declare Camera_Look_At  = < 0.00, 1.00,  0.00> ;
  #declare Camera_Angle    =  75 ;
#break
#break
#end // of "#switch ( Camera_Number )"  

//--------------------------------------------------------------------------
camera{ // ultra_wide_angle // orthographic 
        location Camera_Location
        right    x*image_width/image_height
        angle    Camera_Angle
        look_at  Camera_Look_At
      }

// sun ---------------------------------------------------------------------
light_source{< 3000,3000,-3000> color rgb<1,1,1>*0.9}                // sun 
light_source{ Camera_Location   color rgb<0.9,0.9,1>*0.1 shadowless}// flash
// sky --------------------------------------------------------------------


union{
 #local Nr = 0;     // start
 #local EndNr = 150; // end
 #while (Nr< EndNr)
   // differ a little bit form spherical position:
   #local RandScale = (1+0.1*rand(Random_1)); 
   #local Position  = RandScale * VRand_On_Sphere(Random_1);
   union{ // inner union 

   cone{ <0,0,0>, 0.02, Position, 0.01 
         texture { pigment{ color rgb< 0.75*rand(Random_3), 0.5*rand(Random_3), 0.30> }  
                   normal { bumps 0.5 scale 0.05 }
                   finish { phong 1 }
                 } // end of texture 
       } //---------------

   sphere{ <0,0,0>, 0.1  //, 1.5
           scale <1,0.5,1>// y orientated
           // turn it in direction zero to Position:
           Reorient_Trans( <0,1,0>, Position )
           translate Position // move it to position
           texture{ pigment{ color rgb< 1.0*rand(Random_2), 0.15, 0.1*rand(Random_3)> }
                    normal { bumps 0.5 scale 0.05 }
                    finish { phong 1 }
                  } // end of texture
         } //---------------
   } // end inner union
 #local Nr = Nr + 1;  // next Nr
 #end // --------------- end of loop
 rotate<180*clock,360*clock,-180*clock>

 translate<0,1.25,0>
 rotate<0,0,0>
} // end of union