#include "colors.inc"
#include "shapes.inc"
#include "shapes2.inc"
#include "consts.inc"
#include "glass.inc"
#include "textures.inc"
#include "transforms.inc"
#include "/home/flx/workspace/povray/IVC/experimental/fancy_stick/fancy_pillar.inc"
#include "/home/flx/workspace/povray/IVC/experimental/checked_ball/checked_ball.inc"
#include "/home/flx/workspace/povray/IVC/experimental/spline/spline_macro.inc"

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
#declare My_spline = spline{CurvedSpline(BOX_WIDTH, BOX_HEIGHT, BOX_LENGTH, Street_x_Distortion)}

object {Ball Spline_Trans(My_spline, clock, y, 0.1, 0.5)}

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




