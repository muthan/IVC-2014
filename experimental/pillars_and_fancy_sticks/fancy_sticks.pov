#include "colors.inc"
#include "shapes.inc"
#include "shapes2.inc"
#include "consts.inc"
#include "glass.inc"
#include "textures.inc"

background { Black }

/** declarations: */

#declare BOX_HEIGHT = 40;
#declare BOX_WIDTH = 40;
#declare BOX_LENGTH = 500;

#declare STREET_WIDTH = 15;

#declare CONE_DISTANCE_TO_FLOOR = 1;
#declare CONE_HEIGHT = 4;

#declare AMBIENT_BORDER_DISTANCE = 3;

#declare CONE_NEIGHBOUR_DISTANCE = 4;
#declare BALL_NEIGHBOUR_DISTANCE = 8;


#declare BOX_COLOR = color rgb< 0.1, 0.6, 0.4>;


#declare CONE_1_LOC_START = <AMBIENT_BORDER_DISTANCE,BOX_HEIGHT + CONE_DISTANCE_TO_FLOOR,0.5>;
#declare CONE_1_LOC_END = <AMBIENT_BORDER_DISTANCE,BOX_HEIGHT + CONE_DISTANCE_TO_FLOOR + CONE_HEIGHT,0.5>;
#declare CONE_1_TOPPING_LOC_CENTER = <AMBIENT_BORDER_DISTANCE,46,0.5>;

//------ Randoms ---------------------
#declare Random_1 = seed (1432);
#declare Random_2 = seed (7242);
#declare Random_3 = seed (9912);
//------------------------------------

//------ Object declarations ---------
#declare Fancy_pillar = 
cone { CONE_1_LOC_START, 0.2, CONE_1_LOC_END, 0.15
        texture {
          pigment { color rgb< 0.5, 0.5, 0>*1.2 }
        } 
     }

#declare Fancy_pillar_top = object{
  Icosahedron
  pigment { Blue filter 0.8 }
  hollow
  interior{ ior Diamond_Ior } //Plexiglas_Ior
  finish { ambient rgb <0.4,0.2,0.5> }
  rotate <0,-90*clock, 0>
  translate CONE_1_TOPPING_LOC_CENTER
}

#declare Ball =
sphere{<0,0,0>,2
       texture{pigment{checker Blue, Orange}
              finish {ambient 0.15
                       diffuse 0.85
                       phong 1}
              }
        rotate<0, 30*clock, 0>
       }
//------------------------------------



camera {
  location <-200, 200, -200>
  look_at <0, 0, 0> 
  angle 36
}

light_source {
    <1000, 1000, 0> White
} 


plane { y , 0
    pigment {
        White
        //checker colour Black colour White
        //scale 5
    }
    finish {
        ambient 0.2
        diffuse 0.8
    }
}

box {
    <0, 0, 0> <BOX_WIDTH, BOX_HEIGHT, BOX_LENGTH>
    pigment { BOX_COLOR }
}

#declare Z_delay_cone = 0;     // start
#while (Z_delay_cone < BOX_LENGTH)
 object{Fancy_pillar translate <AMBIENT_BORDER_DISTANCE,0,0.5 + Z_delay_cone>}

 object{Fancy_pillar_top translate <AMBIENT_BORDER_DISTANCE,0,0.5 + Z_delay_cone>pigment{color rgb< rand(Random_1
), rand(Random_2), rand(Random_3)> }}

 #declare Z_delay_cone = Z_delay_cone + CONE_NEIGHBOUR_DISTANCE;  //next Nr

#end //

#declare Z_delay_ball = 0;     // start
#while (Z_delay_ball < BOX_LENGTH)
  object{Ball translate  <BOX_WIDTH - AMBIENT_BORDER_DISTANCE, BOX_HEIGHT + 5, 2 + Z_delay_ball> pigment{hexagon color rgb< rand(Random_1
), rand(Random_2), rand(Random_3)>, color rgb< rand(Random_1), rand(Random_2), rand(Random_3)>,
 color rgb< rand(Random_1), rand(Random_2), rand(Random_3)>}} 

 #declare Z_delay_ball = Z_delay_ball + BALL_NEIGHBOUR_DISTANCE;  //next Nr

#end //


#declare Wire_Radius = 0.4;// radius
#declare Street_x_Distortion = 3;
// spline:
#declare Ribbon_Spline =
spline { natural_spline
   -0.05, < (BOX_WIDTH / 2) + Street_x_Distortion,-5.0, 0.0>,
    0.00, < (BOX_WIDTH / 2) + Street_x_Distortion, 0.0, 0.0>, //start
    0.05, < (BOX_WIDTH / 2) - Street_x_Distortion, 10.0, 0.0>,
    0.10, < (BOX_WIDTH / 2) - Street_x_Distortion, 25.0, 0.0>,
    0.15, < (BOX_WIDTH / 2) + Street_x_Distortion, 40.0, 0.0>,
    0.20, < (BOX_WIDTH / 2) + Street_x_Distortion, 40.0, 12.0>,
    0.25, < (BOX_WIDTH / 2) + Street_x_Distortion, 40.0, 28.0>,
    0.30, < (BOX_WIDTH / 2) - Street_x_Distortion, 40.0, 50.0>,
    0.35, < (BOX_WIDTH / 2) - Street_x_Distortion, 40.0, 70.0>,
    0.40, < (BOX_WIDTH / 2) + Street_x_Distortion, 40.0, 92.0>,
    0.45, < (BOX_WIDTH / 2) - Street_x_Distortion, 40.0, 120.0>,
    0.50, < (BOX_WIDTH / 2) - Street_x_Distortion, 40.0, 142.0>, 
    0.55, < (BOX_WIDTH / 2) + Street_x_Distortion, 40.0, 190.0>,
    0.60, < (BOX_WIDTH / 2) - Street_x_Distortion, 40.0, 220.0>,
    0.65, < (BOX_WIDTH / 2) + Street_x_Distortion, 40.0, 232.0>,
    0.70, < (BOX_WIDTH / 2) + Street_x_Distortion, 40.0, 260.0>,
    0.75, < (BOX_WIDTH / 2) + Street_x_Distortion, 40.0, 280.0>,
    0.80, < (BOX_WIDTH / 2) - Street_x_Distortion, 40.0, 295.0>,
    0.85, < (BOX_WIDTH / 2) + Street_x_Distortion, 40.0, 300.0>,
    0.90, < (BOX_WIDTH / 2) - Street_x_Distortion, 40.0, 340.0>,
    0.95, < (BOX_WIDTH / 2) + Street_x_Distortion, 40.0, 370.0>,
    1.00, < (BOX_WIDTH / 2) - Street_x_Distortion, 40.0, 400.0> //end

} //-------------------------------
union{
  #local Nr = 0;     // start
  #local EndNr = 1;  // end
  #while (Nr <= EndNr)
    sphere{ <0,0,0>, Wire_Radius

      pigment{ color rgb<1,0.3,0>}
      translate  Ribbon_Spline(Nr)
    } // end of sphere
    #local Nr = Nr + 0.001;
    #declare Street_x_Distortion = Street_x_Distortion + 5;
  #end // -------- end of loop
 }





