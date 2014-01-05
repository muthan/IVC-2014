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
#include "/home/flx/workspace/povray/IVC/experimental/maenchen/maenchen-Panik.inc"

/** declarations: */

// The ground. 
plane {
  y,
  0 
  pigment { White }
}

// one box serves as relative offset for all other boxes / objects
#declare BOX_HEIGHT = 40;
#declare BOX_WIDTH = 40;
#declare BOX_LENGTH = 500;

#declare AMBIENT_BORDER_DISTANCE = 3;

#declare CONE_NEIGHBOUR_DISTANCE = 4;
#declare BALL_NEIGHBOUR_DISTANCE = 8;


#declare BOX_COLOR = color rgb< 0.1, 0.2, 0.4>;



//camery spline has no distortion
#declare cam_spline = spline{CurvedSpline(BOX_WIDTH, BOX_HEIGHT + 10, BOX_LENGTH -20, 0)}
camera {
  location cam_spline(clock * 0.8)
  look_at cam_spline(clock * 0.8 + 0.2)
  angle 50
}

light_source {
    <1000, 1000, 0> White
} 

//the main box
box {
    <0, 0, 0> <BOX_WIDTH, BOX_HEIGHT, BOX_LENGTH>
    pigment { BOX_COLOR }
}

box {
    <0, 0, -BOX_WIDTH> <BOX_WIDTH / 2, BOX_HEIGHT - 15, BOX_LENGTH - 0.3* BOX_LENGTH>
    pigment { BOX_COLOR }
    rotate<0,90,0>
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
#declare primary_street = spline{CurvedSpline(BOX_WIDTH, BOX_HEIGHT, BOX_LENGTH, Street_x_Distortion)}

// move the object "ball" along the spline 
object {man Spline_Trans(primary_street, clock, y, 0.1, 0.5)}

// visualize our street (spline)
union{
  #local i = 0;     // start
  #local end_index = 1;  // end
  #while (i <= end_index)
    sphere{ <0,0,0>, Wire_Radius

      pigment{ color rgb<1,0.3,0>}
      translate  primary_street


(i)
    } // end of sphere
    #local i = i + 0.001;
  #end // -------- end of loop
 }




