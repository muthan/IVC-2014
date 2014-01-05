#version 3.6;
global_settings{assumed_gamma 1.0} 
#default{ finish{ ambient 0.1 diffuse 0.9 }} 

#include "colors.inc"
#include "textures.inc"
#include "glass.inc"
#include "metals.inc"
#include "golds.inc"
#include "stones.inc"
#include "woods.inc"
#include "shapes.inc"
#include "shapes2.inc"
#include "functions.inc"
#include "math.inc"
#include "transforms.inc"

#declare Tornado = cylinder{ <0,0,0>,<0,100,0>,1.5 
        pigment { rgbt 1 } 
        hollow   

       interior{ //---------------------
          media{ scattering{ 1, <1,1,1>  
                             extinction  2.5 } 
                 absorption rgb< 0.91, 0.85, 0.85>*2
                 // density 1
                 density{ spiral2 10
                          turbulence 0.20
                          color_map {
                                [0.00 rgb 0.00] // border 
                                [0.50 rgb 0.20] // 
                                [1.00 rgb 1.00] // center 
                              } // end color_map  
                          rotate<90,0,0>
                          scale<1,0.5,1>
                        } // end of density 1
                 // density 2 
                 density{ cylindrical 
                     turbulence 1.0
                     frequency 1
                       color_map {
                                [0.00 rgb 0.00] // border 
                                [0.50 rgb 0.20] // 
                                [0.80 rgb 1.00] // 
                                [1.00 rgb 0.50] // center 
                              } // end color_map  
                     scale<1,2,1>
                     } // end of density 2
                 
               } // end of media ----------------------------
            } // ------------------ end of interior
 
 scale <1,1,1> 
 //rotate<0,0,-20>
 rotate y*360*clock
 translate <   0.00, 0.10, 0.00> 
}