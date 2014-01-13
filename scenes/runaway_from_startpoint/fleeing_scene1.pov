#include "transforms.inc"
#include "colors.inc"
#include "../../objects/spline_macro.inc"
#include "../../objects/checked_ball.inc"



// edit all constants here

#declare START_POINT = <0,0,0>;
#declare FIRST_RUN_LENGTH = 40;
#declare SECOND_RUN_LENGTH = 80;
#declare SECOND_RUN_CURVE = -20;
#declare BOX_COLOR = color rgb< 0.9, 0.2, 0.1>;

// The ground. 
background {Grey}

#declare Runway_1 = spline {RunawayStraight(START_POINT.x, START_POINT.y, START_POINT.z, FIRST_RUN_LENGTH)}
#declare Runway_2 = spline {RunawayXCurve(START_POINT.x, SECOND_RUN_CURVE,  START_POINT.y, FIRST_RUN_LENGTH, SECOND_RUN_LENGTH)}
#declare Cam_1 = spline {RunawayStraight(START_POINT.x + 0.3, START_POINT.y + 2, START_POINT.z - 2, FIRST_RUN_LENGTH - 2)}
#declare Runway_max = spline {RunawayLongEven(START_POINT.x, START_POINT.y, START_POINT.z, 2)}

camera {
    location <-10, 350, -10>
    look_at <-40, 3, 160>
    angle 60
}


box{ <START_POINT.x - 0.5, START_POINT.y -0.5, START_POINT.z>, <START_POINT.x + 0.5, START_POINT.y -0.4, START_POINT.z + FIRST_RUN_LENGTH> //radius
        pigment { BOX_COLOR }
    } 




/**camera {
    location Cam_1(clock)
    look_at Runway_1(2*clock-1) Runway_2(clock)
    angle 40
}**/
// visualize our spline, uncomment for usage:
/**camera {
    location <5, 2.5, -5>
    look_at <0, 0, 5>
    angle 60
}
union{
  #local i = 0;     // start
  #local end_index = 1;  // end
  #while (i <= end_index)
    sphere{ <0,0,0>, 0.3
      pigment{ color rgb<1,0.3,0>}
      translate Runway_1 (i)
    } 
    #local i = i + 0.01;
  #end // -------- end of loop
 }
**/

union{
  #local i = 0;     // start
  #local end_index = 100;  // end
  #while (i <= end_index)
    sphere{ <0,0,0>, 0.2
      pigment{ color rgb<1,0.3,0>}
      translate Runway_max(i)
    } 
    #local i = i + 0.005;
    #end // -------- end of loop
 }
 

