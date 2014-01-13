#include "transforms.inc"
#include "colors.inc"
#include "../../objects/spline_macro.inc"
#include "../../objects/checked_ball.inc"
#include "../../objects/fancy_pillar.inc"
#include "../../util/positioning_utils.inc"
#include "../../objects/maenchen.inc"
#include "../../objects/drone.inc"
#include "../../objects/wobbel.inc"

light_source {
  <-1000, 200, -200> White
}

// edit all constants here

#declare START_POINT = <0,0,0>;
#declare WOBBEL_1_LOCATION = <-27, 0, 117>;
#declare FIRST_RUN_LENGTH = 40;
#declare SECOND_RUN_LENGTH = 80;
#declare SECOND_RUN_CURVE = -20;
#declare BOX_COLOR = color rgb< 0, 0.8, 0.3>;
#declare GENERAL_SCALE = 2;
#declare RUNWAY_ALIGN_DIST = 5;

//Select the camera here:

#declare CAMERA_1 = 1; // View of the drone (moving cam)
#declare CAMERA_2 = 2; // View in front of the man (moving cam)
#declare CAMERA_3 = 3; // view behind the drone (moving cam)
#declare CAMERA_4 = 4; // view whole world (static cam)
#declare CAMERA_5 = 5; // view the startpoint (static cam)
#declare CAMERA_6 = 6; // view the wobbel (static cam)


#declare CAMERA = 3;

#declare clock_spline = spline {
  //only makes sense to use moving cams here!
  //else wise set the clock number manually, no need to animate things
  linear_spline
    0, 3,
    1, 3,
    1.999999999, 3,
    2, 1,
    2.999999999, 1,
    3, 2, 
    4, 2,
    5, 2

}

//this kinda rapes the intention of splines, but hey..!
// takes the spline val calculated with the clock as parameter, which will then return a vector containing the wanted camera number.
#declare CAMERA = clock_spline(clock).x;

#declare Runway_1 = spline {RunawayStraight(START_POINT.x, START_POINT.y, START_POINT.z, FIRST_RUN_LENGTH)}
#declare Runway_2 = spline {RunawayXCurve(START_POINT.x, SECOND_RUN_CURVE,  START_POINT.y, FIRST_RUN_LENGTH, SECOND_RUN_LENGTH)}

#declare Cam_Drone_View = spline {RunawayLongEven(START_POINT.x, START_POINT.y + 2, START_POINT.z, GENERAL_SCALE)}
#declare Cam_Behind_Drone_View = spline {RunawayLongEven(START_POINT.x, START_POINT.y + 4, START_POINT.z, GENERAL_SCALE)}
#declare Cam_In_Front_Of_Man = spline {RunawayLongEven(START_POINT.x, START_POINT.y + 1, START_POINT.z, GENERAL_SCALE)}
#declare Drone_View_Offset = 0;
#declare Behind_Drone_View_Offset = -2;
#declare In_Front_Of_Man_View_Offset = 0.5;
#declare Look_at_Offset = 2;


#declare Runway_max = spline {RunawayLongEven(START_POINT.x, START_POINT.y, START_POINT.z, GENERAL_SCALE)}
#declare Runway_right_align = spline {RunawayLongEven(START_POINT.x + RUNWAY_ALIGN_DIST, START_POINT.y, START_POINT.z, GENERAL_SCALE)}

// use this  offset if rendered with Final_Clock=5, else wise use 100 when normal clock (==1) is used.
#declare Cam_spline_movespeed = 20;

//take the camera which has been declared above:
#switch(CAMERA)
#case(CAMERA_1)
  camera {
      location Cam_Drone_View(clock*Cam_spline_movespeed + Drone_View_Offset)
      look_at Runway_max(clock*Cam_spline_movespeed + Look_at_Offset)
      angle 40
  }
  #break
#case(CAMERA_2)
  camera {
      location Cam_In_Front_Of_Man(clock*Cam_spline_movespeed + In_Front_Of_Man_View_Offset)
      look_at Runway_max(clock*Cam_spline_movespeed + Look_at_Offset)
      angle 40
  }
  #break
#case(CAMERA_3)
  camera {
      location Cam_Behind_Drone_View(clock*Cam_spline_movespeed + Behind_Drone_View_Offset)
      look_at Runway_max(clock*Cam_spline_movespeed + Look_at_Offset)
      angle 40
  }
  #break
#case(CAMERA_4)
  //for viewing the whole "world" from above.
  camera {
      location <-10, 350, -10>
      look_at <-40, 3, 160>
      angle 60
  }
  #break
#case(CAMERA_5)
  //view the startpoint 
  camera {
      location <0, 4, 10>
      look_at START_POINT
      angle 60
  }
  #break
#case(CAMERA_6)
  //view the wobbel 
  camera {
      location <-27, 30, 115>
      look_at WOBBEL_1_LOCATION
      angle 60
  }
  #break

#end


// The ground. 
background {Grey}


// declare the drone and the main character (the stick man) which will be chased by the drone through our world.
object{drone rotate<0, 180,0> translate<0, 5, 0> scale 0.5 Spline_Trans(Runway_max, clock*Cam_spline_movespeed, y, 0.1, 0.5)}


#declare Character = man_panic;
object{Character rotate<0, 180, 0> scale 0.3 Spline_Trans(Runway_max, clock*Cam_spline_movespeed + 2, y, 0.1, 0.5)}


// insert any other objects here:


// describes a box - the weed-plane - in the first "corner" of the runwaymax
box {
  START_POINT * GENERAL_SCALE, <3,0,9> * GENERAL_SCALE
  pigment {BOX_COLOR}
  rotate<0,37,0>
  translate <2,0,13> * GENERAL_SCALE
}



#declare Pillar_1 = object {Fancy_Pillar(0,0,0) scale GENERAL_SCALE}
//in the first curve
PositionAsTriangle_2D(Pillar_1, 13, 0, 43, 5)

//outisde the first curve
object {Fancy_Pillar(12, 0, 18) scale GENERAL_SCALE}
object {Fancy_Pillar(14, 0, 20) scale GENERAL_SCALE}
object {Fancy_Pillar(15, 0, 22) scale GENERAL_SCALE}
object {Fancy_Pillar(14, 0, 25) scale GENERAL_SCALE}
object {Fancy_Pillar(10, 0, 29) scale GENERAL_SCALE}

//in the first "loop" in the runway:
object{Wobbel(Cam_spline_movespeed, 5) scale 6 translate WOBBEL_1_LOCATION}



/**union{
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
 

