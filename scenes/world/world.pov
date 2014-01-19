#include "colors.inc"
#include "shapes.inc"
#include "shapes2.inc"
#include "consts.inc"
#include "glass.inc"
#include "textures.inc"
#include "transforms.inc"
#include "../../objects/fancy_pillar.inc"
#include "../../objects/checked_ball.inc"
#include "../../objects/spline_macro.inc"
#include "../../objects/loop.inc"
#include "../../objects/maenchen.inc"


/** declarations: */

// The ground. 
/**plane {
  y,
  0 
  pigment { White }
}**/

// one box serves as relative offset for all other boxes / objects
#declare BOX_HEIGHT = 40;
#declare BOX_WIDTH = 40;
#declare BOX_LENGTH = 500;

#declare AMBIENT_BORDER_DISTANCE = 3;

#declare CONE_NEIGHBOUR_DISTANCE = 4;
#declare BALL_NEIGHBOUR_DISTANCE = 8;


#declare BOX_COLOR = color rgb< 0.1, 0.2, 0.4>;

//its actually two boxes in order to get the break /whole in the middle, where the man needs to jump :)

//camery spline has no distortion (makes it follow the running man without taking the curved path)
#declare cam_spline = spline{CurvedSpline(BOX_WIDTH, BOX_HEIGHT + 10, BOX_LENGTH -20, 0)}
// camera for following the running man :)
/**camera {
  location cam_spline(clock * 0.8)
  look_at cam_spline(clock * 0.8 + 0.2)
  angle 50
}**/

// camera for seeing the jumppoint, uncomment for usage
/** camera {
  location <-50, 80, 300>
  look_at <0, 20, BOX_LENGTH / 2>
  angle 50
}
**/


/**light_source {
    <1000, 1000, 0> White
}**/ 

#declare On_The_Big_Box = union {
//the first box
box {
    <0, 0, 0> <BOX_WIDTH, BOX_HEIGHT, BOX_LENGTH / 2>
    pigment { BOX_COLOR }
}
//the second box
box {
    <0, 0, BOX_LENGTH / 2 + 15> <BOX_WIDTH, BOX_HEIGHT, BOX_LENGTH>
    pigment { BOX_COLOR }
}
//results in a gap between the boxes with a width of 10 in the z-axis.


#declare Z_delay_cone = 0;     // start
#while (Z_delay_cone < BOX_LENGTH)
 object{Fancy_Pillar(AMBIENT_BORDER_DISTANCE, BOX_HEIGHT,0.5 + Z_delay_cone)}
 #if (Z_delay_cone >= BOX_LENGTH / 2 & Z_delay_cone <= BOX_LENGTH / 2 + 15)
  #declare Z_delay_cone = Z_delay_cone + 15;
 #end
 #declare Z_delay_cone = Z_delay_cone + CONE_NEIGHBOUR_DISTANCE; 

#end //

#declare Z_delay_ball = 0;     // start
#while (Z_delay_ball < BOX_LENGTH)
  object{Ball translate  <BOX_WIDTH - AMBIENT_BORDER_DISTANCE, BOX_HEIGHT + 5, 2 + Z_delay_ball> pigment{hexagon color rgb< rand(Random_1
), rand(Random_2), rand(Random_3)>, color rgb< rand(Random_1), rand(Random_2), rand(Random_3)>,
 color rgb< rand(Random_1), rand(Random_2), rand(Random_3)>}} 
 #if (Z_delay_ball >= BOX_LENGTH / 2 - BALL_NEIGHBOUR_DISTANCE & Z_delay_ball <= BOX_LENGTH / 2 + 15)
  #declare Z_delay_ball = Z_delay_ball + 15;
 #end
 #declare Z_delay_ball = Z_delay_ball + BALL_NEIGHBOUR_DISTANCE;  

#end //


#declare Wire_Radius = 0.4;// radius
#declare Street_x_Distortion = 3;
// spline:
#declare primary_street = spline{CurvedSpline(BOX_WIDTH, BOX_HEIGHT, BOX_LENGTH, Street_x_Distortion)}
#declare run_way = spline{CurvedSplineJump(BOX_WIDTH, BOX_HEIGHT, BOX_LENGTH, Street_x_Distortion)}

// move the object "ball" along the spline 
object {man_panic Spline_Trans(run_way, clock, y, 0.1, 0.5)}

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
    #local i = i + 0.0001;
  #end // -------- end of loop
 }
object{Running_Loop2 translate<BOX_WIDTH / 2 + 8, BOX_HEIGHT +5, BOX_LENGTH/2 + 10>}

};


