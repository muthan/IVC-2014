#include "colors.inc"
#include "shapes.inc"
#include "shapes2.inc"
#include "consts.inc"
#include "glass.inc"
#include "textures.inc"
#include "/home/flx/workspace/povray/IVC/experimental/fancy_stick/fancy_pillar.inc"
#include "/home/flx/workspace/povray/IVC/experimental/checked_ball/checked_ball.inc"

background { Black }

/** declarations: */

#declare BOX_HEIGHT = 40;
#declare BOX_WIDTH = 40;
#declare BOX_LENGTH = 500;

#declare AMBIENT_BORDER_DISTANCE = 3;

#declare CONE_NEIGHBOUR_DISTANCE = 4;
#declare BALL_NEIGHBOUR_DISTANCE = 8;


#declare BOX_COLOR = color rgb< 0.1, 0.6, 0.4>;


camera {
  location <-200, 200, -200>
  look_at <0, 0, 0> 
  angle 36
}

light_source {
    <1000, 1000, 0> White
} 




box {
    <0, 0, 0> <BOX_WIDTH, BOX_HEIGHT, BOX_LENGTH>
    pigment { BOX_COLOR }
}

#declare Z_delay_cone = 0;     // start
#while (Z_delay_cone < BOX_LENGTH)
 object{Fancy_Pillar(AMBIENT_BORDER_DISTANCE, BOX_HEIGHT,0.5 + Z_delay_cone)}

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
#declare My_spline =
spline { natural_spline
    0.00, < (BOX_WIDTH / 2) + Street_x_Distortion, 0.0, 0.0>,
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
    1.00, < (BOX_WIDTH / 2) - Street_x_Distortion, 40.0, 400.0>

} 

union{
  #local Nr = 0;     // start
  #local EndNr = 1;  // end
  #while (Nr <= EndNr)
    sphere{ <0,0,0>, Wire_Radius

      pigment{ color rgb<1,0.3,0>}
      translate  My_spline


(Nr)
    } // end of sphere
    #local Nr = Nr + 0.001;
    #declare Street_x_Distortion = Street_x_Distortion + 5;
  #end // -------- end of loop
 }


