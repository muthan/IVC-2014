#include "colors.inc"
#include "textures.inc"

#macro Tornado(draft)
    #local bend_offset = (1 - abs(2*clock -1)) * 3;
    // declare rand = seed(235)
    sphere_sweep {
        cubic_spline
        7,
        <0, -1, 0>, 1
        <0, 0, 0>, 1
        <+1-bend_offset, 20, 0>, 2
        <-1+bend_offset, 30, 0>, 3
        <-1+bend_offset, 40, 0>, 5
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
       }
    }
#end

#declare Tornado_clean = cylinder{
  <0,0,0>,<0,0.5,0>,0.5 
  pigment { rgb 1 }  
  translate <0.00, 0.10, 0.00> 
}