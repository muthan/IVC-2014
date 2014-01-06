#include "colors.inc"
#include "textures.inc"
#include "rand.inc"
background { Green }

#declare Camera_Position = < 0.00, 10,100>;  // front view
#declare Camera_look_at = < 0.00, 20, 0.00>; 
#declare Camera_Angle = 50 ; // in degrees
//--------------------------------------------------------------------------------------------------------<<<<
camera{ /*ultra_wide_angle*/   
        location  Camera_Position
        right     x*image_width/image_height
        angle Camera_Angle   
        look_at   Camera_look_at
      }

light_source{<1500,2500,-2500> color White*0.85}           // sun light
light_source{ Camera_Position  color rgb<0.9,0.9,1>*0.1}  // flash light

// ground ------------------------------------------------------------------
plane{ <0,1,0>, 0 
       texture{ pigment{ White } }
       //         normal { bumps 0.75 scale 0.025  }
       //         finish { phong 0.1 } 
       //       } // end of texture
     } // end of plane





#macro Tornado1(draft)
    #local offset_x = (1 - abs(2*clock -1)) * 3;
    // declare rand = seed(235)
    sphere_sweep {
        cubic_spline
        7,
        <0, -1, 0>, 1
        <0, 0, 0>, 1
        <+1-offset_x, 20, 0>, 2
        <-1+offset_x, 30, 0>, 3
        <-1+offset_x, 40, 0>, 5
        <0, 50, 0>, 8
        <0, 60, 0>, 13
        tolerance 0.1
        hollow

        #if(draft = 1)
            pigment{ rgbt 0.9 }
        #else
            pigment{ rgbt 1 }
        #end

        interior{ //-----------
            media{
                #if(draft = 1)
                    absorption<1,1,1>
                #else
                    scattering{ 1, <1,1,1> }
                #end
                
                intervals 3
                samples 1,1 //min,max

                density {
                    spiral2 2 //scale <10,2,2> // HIER
                    scale 1.5
                    turbulence 0.2
                    color_map {
                        [0.00 rgb 0.00] // border 
                        [0.50 rgb 0.20] // 
                        [1.00 rgb 1.00] // center 
                    }
                }

                density {
                    cylindrical
                    turbulence 1
                    scale 5
                    color_map {
                        [0.00 rgb 0.00] // border 
                        [0.50 rgb 0.20] // 
                        [0.80 rgb 1.00] // 
                        [1.00 rgb 0.50] // center 
                    }
                }
                rotate y*clock*360*4

            }
        //scale 0.1
       }
       
    }
#end

object{
    Tornado1(0)
    translate<0,0.5,0>
}