#include "transforms.inc"
#include "colors.inc"
#include "../../objects/spline_macro.inc"
#include "../../objects/fancy_pillar.inc"
#include "../../util/positioning_utils.inc"
#include "../../objects/maenchen.inc"
#include "../../objects/drone.inc"
#include "../../objects/wobbel.inc"
#include "../../objects/checked_ball.inc"
#include "../../objects/loop.inc"


light_source {
  <-1000, 200, -200> White
}

// edit all constants here, this are mainly the object locations.
// so if specific objects shall be seated somewhere else, edit that here!

#declare START_POINT = <0,0.1,0>;
#declare BOX_1_END = <3,0.1,9>;
#declare BOX_2_START = <-28,0.1,56>;
#declare BOX_2_END = <-45,0.1,59>;
#declare BOX_3_START = <-3,0.1,45>;
#declare BOX_3_END = <-10,0.1,50>;

#declare WOBBEL_1_LOCATION = <-27, 0, 117>;
#declare WOBBEL_2_LOCATION = <40,0,260>;
#declare WOBBEL_3_LOCATION = <40,15,260>;
#declare WOBBEL_4_LOCATION = <0,15,190>;
#declare WOBBEL_5_LOCATION = <10,10,190>;
#declare WOBBEL_6_LOCATION = <10,0,190>;
#declare WOBBEL_7_LOCATION = <-10,0,190>;
#declare WOBBEL_8_LOCATION = <-10,10,190>;
#declare WOBBEL_9_LOCATION = <0,15,180>;
#declare WOBBEL_10_LOCATION = <10,10,180>;
#declare WOBBEL_11_LOCATION = <10,0,180>;
#declare WOBBEL_12_LOCATION = <-10,0,180>;
#declare WOBBEL_13_LOCATION = <-10,10,180>;
#declare WOBBEL_14_LOCATION = <50,0,290>;
#declare WOBBEL_15_LOCATION = <40,5,260>;
#declare WOBBEL_16_LOCATION = <40,5,260>;

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
#declare CAMERA_7 = 7; // view the first curve in the runway


#declare CAMERA = 4;

#declare clock_spline = spline {
  //only makes sense to use moving cams here!
  //else wise set the clock number manually, no need to animate things
  linear_spline
    0, 2,
    1, 2,
    1.999999999, 2,
    2, 3,
    2.999999999, 3,
    3, 2, 
    4, 2,
    5, 2

}

//this kinda rapes the intention of splines, but hey..!
// takes the spline val calculated with the clock as parameter, which will then return a vector containing the wanted camera number.
//#declare CAMERA = clock_spline(clock).x;

#declare Runway_1 = spline {RunawayStraight(START_POINT.x, START_POINT.y, START_POINT.z, FIRST_RUN_LENGTH)}
#declare Runway_2 = spline {RunawayXCurve(START_POINT.x, SECOND_RUN_CURVE,  START_POINT.y, FIRST_RUN_LENGTH, SECOND_RUN_LENGTH)}

#declare Cam_Drone_View = spline {RunawayLongEven(START_POINT.x, START_POINT.y + 2, START_POINT.z, GENERAL_SCALE)}
#declare Cam_Behind_Drone_View = spline {RunawayLongEven(START_POINT.x, START_POINT.y + 4, START_POINT.z, GENERAL_SCALE)}
#declare Cam_In_Front_Of_Man = spline {RunawayLongEven(START_POINT.x, START_POINT.y + 1, START_POINT.z + 5, GENERAL_SCALE)}
#declare Drone_View_Offset = 0;
#declare Behind_Drone_View_Offset = -2;
#declare In_Front_Of_Man_View_Offset = 5;
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
#case(CAMERA_7)
  //for viewing the first curve.
  camera {
      location <-10, 35, 100>
      look_at <-10, 3, 10>
      angle 60
  }
  #break

#end


// The ground. 
plane { y, 0 
  pigment{color<0.6,0.3,0.9>}
}

#declare Wall_mat = material{ Surface_Material2
          scale <1,1,1> 
          rotate<360*clock, 90, 90>};
//The wall

box { 
  <-95,0,105>, <-105,25,113>
  material{Wall_mat}
}
box { 
  <-105,0,110>, <-115,15,130>
  material{Wall_mat}
}
box { 
  <-115,0,120>, <-125,20,150>
  material{Wall_mat}
}


box { 
  <-103,0,150>, <-120,20,160>
  material{Wall_mat}
}




// declare the drone and the main character (the stick man) which will be chased by the drone through our world.
object{drone rotate<0, 180,0> translate<0, 5, 0> scale 0.5 Spline_Trans(Runway_max, clock*Cam_spline_movespeed, y, 0.1, 0.5)}


#declare Character = man_panic;
object{Character rotate<0, 180, 0> scale 0.3 Spline_Trans(Runway_max, clock*Cam_spline_movespeed + 2, y, 0.1, 0.5)}


// insert any other objects here:


// describes a box - the weed-plane
box {
  START_POINT * GENERAL_SCALE, BOX_1_END * GENERAL_SCALE
  pigment {BOX_COLOR}
  rotate<0,37,0>
  translate <2,0,13> * GENERAL_SCALE
}

box {
  BOX_2_START * GENERAL_SCALE, BOX_2_END * GENERAL_SCALE
  pigment {BOX_COLOR}
}

box {
  BOX_3_START * GENERAL_SCALE, BOX_3_END * GENERAL_SCALE
  pigment {BOX_COLOR}
  rotate<0,10,0>
}

box {
  BOX_3_START * GENERAL_SCALE, BOX_3_END * GENERAL_SCALE
  pigment {BOX_COLOR}
}




// declare loops:

object{Running_Loop scale 0.5 * GENERAL_SCALE translate<0,0,0> Spline_Trans(Runway_max, 20, y, 0.1, 0.5)}
object{Running_Loop scale 0.5 * GENERAL_SCALE translate<0,0,0> Spline_Trans(Runway_max, 23, y, 0.1, 0.5) translate<2,0,0>}
object{Running_Loop scale 0.5 * GENERAL_SCALE translate<0,0,0> rotate<0,-80,0> Spline_Trans(Runway_max, 25, y, 0.1, 0.5)}
object{Running_Loop scale 0.5 * GENERAL_SCALE translate<0,0,0> rotate<0,-80,0> Spline_Trans(Runway_max, 28, y, 0.1, 0.5) translate<0,0,5>}

#declare Pillar_tri = object {Fancy_Pillar(0,0,0) scale GENERAL_SCALE}
//in the first curve
PositionAsTriangle_2D(Pillar_tri, 13, 0, 43, 5)

//outisde the first curve
object {Fancy_Pillar(12, 0, 18) scale GENERAL_SCALE}
object {Fancy_Pillar(14, 0, 20) scale GENERAL_SCALE}
object {Fancy_Pillar(15, 0, 22) scale GENERAL_SCALE}
object {Fancy_Pillar(14, 0, 25) scale GENERAL_SCALE}
object {Fancy_Pillar(10, 0, 29) scale GENERAL_SCALE}

//in the first "loop" in the runway:
object{Wobbel(Cam_spline_movespeed, 5) scale 3*GENERAL_SCALE translate WOBBEL_1_LOCATION}

//arrange balls on the first box, BOX_1
#declare Z_delay_ball = 0;   
#while (Z_delay_ball < BOX_1_END.z)
  object{Ball translate  <START_POINT.x - 5, BOX_1_END.y +2 , 2 + Z_delay_ball + 11.5> * GENERAL_SCALE pigment{hexagon color rgb< rand(1
), rand(1), rand(3)>, color rgb< rand(2), rand(1), rand(3)>,
 color rgb< rand(2), rand(1), rand(3)>} scale 0.5 * GENERAL_SCALE rotate <0,37,0>} 

 #declare Z_delay_ball = Z_delay_ball + 3; 
 #end 

//arrange balls on the second box, BOX_2
#declare X_Delay_Ball = 0;    
#while (X_Delay_Ball > (BOX_2_END.x - BOX_2_START.x))
  object{Ball translate  <BOX_2_START.x -1.5 + X_Delay_Ball, BOX_2_START.y +2 , BOX_2_START.z + (BOX_2_END.z - BOX_2_START.z) /2 > * GENERAL_SCALE pigment{hexagon color rgb< rand(1
), rand(1), rand(3)>, color rgb< rand(2), rand(1), rand(3)>,
 color rgb< rand(2), rand(1), rand(3)>} scale 0.5 * GENERAL_SCALE} 

 #declare X_Delay_Ball = X_Delay_Ball - 3; 
 #end 


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
 
// Thorben's Section

object{Wobbel(Cam_spline_movespeed, 5) scale 3*GENERAL_SCALE translate WOBBEL_2_LOCATION}
object{Wobbel(Cam_spline_movespeed, 5) scale 3*GENERAL_SCALE translate WOBBEL_3_LOCATION}
object{Wobbel(Cam_spline_movespeed, 5) scale 3*GENERAL_SCALE translate WOBBEL_4_LOCATION}
object{Wobbel(Cam_spline_movespeed, 5) scale 3*GENERAL_SCALE translate WOBBEL_5_LOCATION}
object{Wobbel(Cam_spline_movespeed, 5) scale 3*GENERAL_SCALE translate WOBBEL_6_LOCATION}
object{Wobbel(Cam_spline_movespeed, 5) scale 3*GENERAL_SCALE translate WOBBEL_7_LOCATION}
object{Wobbel(Cam_spline_movespeed, 5) scale 3*GENERAL_SCALE translate WOBBEL_8_LOCATION}
object{Wobbel(Cam_spline_movespeed, 5) scale 3*GENERAL_SCALE translate WOBBEL_9_LOCATION}
object{Wobbel(Cam_spline_movespeed, 5) scale 3*GENERAL_SCALE translate WOBBEL_10_LOCATION}
object{Wobbel(Cam_spline_movespeed, 5) scale 3*GENERAL_SCALE translate WOBBEL_11_LOCATION}
object{Wobbel(Cam_spline_movespeed, 5) scale 3*GENERAL_SCALE translate WOBBEL_12_LOCATION}
object{Wobbel(Cam_spline_movespeed, 5) scale 3*GENERAL_SCALE translate WOBBEL_13_LOCATION}
object{Wobbel(Cam_spline_movespeed, 5) scale 3*GENERAL_SCALE translate WOBBEL_14_LOCATION}
object{Wobbel(Cam_spline_movespeed, 5) scale 3*GENERAL_SCALE translate WOBBEL_15_LOCATION}
object{Wobbel(Cam_spline_movespeed, 5) scale 3*GENERAL_SCALE translate WOBBEL_16_LOCATION}


object {Fancy_Pillar(20, 0, 115) scale GENERAL_SCALE}
object {Fancy_Pillar(20, 0, 110) scale GENERAL_SCALE}
object {Fancy_Pillar(25, 0, 115) scale GENERAL_SCALE}
object {Fancy_Pillar(25, 0, 110) scale GENERAL_SCALE}
object {Fancy_Pillar(15, 0, 110) scale GENERAL_SCALE}
object {Fancy_Pillar(15, 0, 115) scale GENERAL_SCALE}
object {Fancy_Pillar(5, 0, 110) scale GENERAL_SCALE}
object {Fancy_Pillar(5, 0, 115) scale GENERAL_SCALE}
object {Fancy_Pillar(10, 0, 110) scale GENERAL_SCALE}
object {Fancy_Pillar(10, 0, 115) scale GENERAL_SCALE}
object {Fancy_Pillar(-1, 0, 110) scale GENERAL_SCALE}
object {Fancy_Pillar(0, 0, 115) scale GENERAL_SCALE}
object {Fancy_Pillar(-5, 0, 110) scale GENERAL_SCALE}
object {Fancy_Pillar(-5, 0, 115) scale GENERAL_SCALE}
object {Fancy_Pillar(-10, 0, 110) scale GENERAL_SCALE}
object {Fancy_Pillar(-10, 0, 115) scale GENERAL_SCALE}
object {Fancy_Pillar(-25, 0, 110) scale GENERAL_SCALE}
object {Fancy_Pillar(-25, 0, 115) scale GENERAL_SCALE}
object {Fancy_Pillar(-15, 0, 115) scale GENERAL_SCALE}
object {Fancy_Pillar(-15, 0, 110) scale GENERAL_SCALE}
object {Fancy_Pillar(-20, 0, 110) scale GENERAL_SCALE}
object {Fancy_Pillar(-20, 0, 115) scale GENERAL_SCALE}

