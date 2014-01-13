#include "transforms.inc"
#include "colors.inc"
#include "../../objects/spline_macro.inc"
#include "../../objects/checked_ball.inc"
#include "../../objects/fancy_pillar.inc"
#include "../../util/positioning_utils.inc"
#include "../../objects/maenchen.inc"



// edit all constants here

#declare START_POINT = <0,0,0>;
#declare FIRST_RUN_LENGTH = 40;
#declare SECOND_RUN_LENGTH = 80;
#declare SECOND_RUN_CURVE = -20;
#declare BOX_COLOR = color rgb< 0.9, 0.2, 0.1>;
#declare GENERAL_SCALE = 2;
#declare RUNWAY_ALIGN_DIST = 5;

// The ground. 
background {Grey}

#declare Runway_1 = spline {RunawayStraight(START_POINT.x, START_POINT.y, START_POINT.z, FIRST_RUN_LENGTH)}
#declare Runway_2 = spline {RunawayXCurve(START_POINT.x, SECOND_RUN_CURVE,  START_POINT.y, FIRST_RUN_LENGTH, SECOND_RUN_LENGTH)}
#declare Cam_1 = spline {RunawayLongEven(START_POINT.x, START_POINT.y + 2, START_POINT.z, GENERAL_SCALE)}
#declare Runway_max = spline {RunawayLongEven(START_POINT.x, START_POINT.y, START_POINT.z, GENERAL_SCALE)}
#declare Runway_right_align = spline {RunawayLongEven(START_POINT.x + RUNWAY_ALIGN_DIST, START_POINT.y, START_POINT.z, GENERAL_SCALE)}

// use this  offset if rendered with Final_Clock=5, else wise use 100 when normal clock (==1) is used.
#declare Cam_spline_movespeed = 20;
/**camera {
    location Cam_1(clock*Cam_spline_movespeed)
    look_at Runway_max(clock*Cam_spline_movespeed + 2)
    angle 40
}
#declare Character = man_runsNormal(Cam_spline_movespeed)
object{Character scale 0.3 Spline_Trans(Runway_max, clock*Cam_spline_movespeed + 2, y, 0.1, 0.5)}
**/
camera {
    location <-10, 350, -10>
    look_at <-40, 3, 160>
    angle 60
}



// describes a box in the first "corner" of the runwaymax
box {
  START_POINT * GENERAL_SCALE, <3,0,9> * GENERAL_SCALE
  pigment {BOX_COLOR}
  rotate<0,37,0>
  translate <2,0,13> * GENERAL_SCALE
}



#declare Pillar_1 = object {Fancy_Pillar(0,0,0) scale GENERAL_SCALE}
//in the curve
PositionAsTriangle_2D(Pillar_1, 13, 0, 43, 5)

//outisde the curve
object {Fancy_Pillar(12, 0, 18) scale GENERAL_SCALE}
object {Fancy_Pillar(14, 0, 20) scale GENERAL_SCALE}
object {Fancy_Pillar(15, 0, 22) scale GENERAL_SCALE}
object {Fancy_Pillar(14, 0, 25) scale GENERAL_SCALE}
object {Fancy_Pillar(10, 0, 29) scale GENERAL_SCALE}





// visualize our spline, uncomment for usage:
/**camera {
    location <5, 2.5, -5>
    look_at <0, 0, 5>
    angle 60
}
union{
  #local i = 0;     // start
  #local end_index = 100;  // end
  #while (i <= end_index)
    sphere{ <0,0,0>, 0.2
      pigment{ color rgb<1,0.3,0>}
      translate Runway_right_align(i)
    } 
    #local i = i + 0.005;
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
 

