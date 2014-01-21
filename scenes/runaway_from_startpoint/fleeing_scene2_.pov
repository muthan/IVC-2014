#version 3.7;
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
#include "../world/world.pov"
#include "../../objects/elevator.inc"


light_source {
  <-100, 300, -500> White
}

#declare START_SCENE = 0;
#declare ELEVATOR_SCENE = 1;
#declare END_SCENE = 0;
#declare FALL_SCENE = 0;

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
#declare WOBBEL_14_LOCATION = <50,0,300>;
#declare WOBBEL_15_LOCATION = <60,0,310>;
#declare WOBBEL_16_LOCATION = <70,0,320>;

#declare FIRST_RUN_LENGTH = 40;
#declare SECOND_RUN_LENGTH = 80;
#declare SECOND_RUN_CURVE = -20;
#declare BOX_COLOR = color rgb< 0, 0.8, 0.3>;
#declare GENERAL_SCALE = 2;
#declare RUNWAY_ALIGN_DIST = 5;
#declare ELEVATOR_LOC = <76,0,210>;
#declare HEIGHT = 19/50;
#declare BIG_BOX_LOCATION = <90,0,210>;

//Select the camera here:

#declare CAMERA_1 = 1; // View of the drone (moving cam)
#declare CAMERA_2 = 2; // View in front of the man (moving cam)
#declare CAMERA_3 = 3; // view behind the drone (moving cam)
#declare CAMERA_4 = 4; // view whole world (static cam)
#declare CAMERA_5 = 5; // view the startpoint (static cam)
#declare CAMERA_6 = 6; // view the elevator (moving cam)
#declare CAMERA_7 = 7; // view the first curve in the runway
#declare CAMERA_8 = 8; // on the big box


#declare CAMERA =  CAMERA_6; // if you use this, dont forget to comment out the moving cam below

#declare clock_spline = spline {
  //only makes sense to use moving cams here!
  //else wise set the clock number manually, no need to animate things
  linear_spline // linear, since we dont want higher function abstraction - we only need a discrete return val
    0, 2,
    10, 2,
    19.99999999, 2,
    20, 3,
    30, 3, 
    39.99999999, 3,
    40, 1,
    50, 1,
    60, 1,
    69.99999999, 1,
    70, 3,
    80, 3,
    90, 3,
    100, 3
}

// use this  offset if rendered with Final_Clock=XXX, to always get a match of clock*Cam_spline_movespeed = 100!!!
// calculate and set it here _before_ u render.
// else wise use 100 when normal clock (==1) is used.
#declare Cam_spline_movespeed = 2; // render with final clock = 50

//this kinda rapes the intention of splines, but hey..!
// takes the spline val calculated with the clock as parameter, which will then return a vector containing the wanted camera number.
/*
 * here is the moving cam declaration | | |
 *                                    v v v
 */
//#declare CAMERA = clock_spline(clock*Cam_spline_movespeed).x;


#declare Cam_Drone_View = spline {RunawayLongEven(START_POINT.x, START_POINT.y + 2, START_POINT.z, GENERAL_SCALE)}
#declare Cam_Behind_Drone_View = spline {RunawayLongEven(START_POINT.x, START_POINT.y + 4, START_POINT.z, GENERAL_SCALE)}
#declare Cam_In_Front_Of_Man = spline {RunawayLongEven(START_POINT.x, START_POINT.y + 1, START_POINT.z + 5, GENERAL_SCALE)}
#declare Drone_View_Offset = 0;
#declare Behind_Drone_View_Offset = -4;
#declare In_Front_Of_Man_View_Offset = 5;
#declare Look_at_Offset = 2;


#declare Runway_max = spline {RunawayLongEven(START_POINT.x, START_POINT.y, START_POINT.z, GENERAL_SCALE)}
#declare Runway_on_the_big_box = spline {CurvedSplineJump(ELEVATOR_LOC.x * 2 + 6, ELEVATOR_LOC.y + HEIGHT * 50 + 1, ELEVATOR_LOC.z, ELEVATOR_LOC.z + 40, -1,  3)}
#declare Cam_on_the_big_box_Behind_Drone =spline {CurvedSplineJump(ELEVATOR_LOC.x * 2 + 6, ELEVATOR_LOC.y + HEIGHT * 50 + 10, ELEVATOR_LOC.z, ELEVATOR_LOC.z + 40, -1, 0)}

//take the camera which has been declared above:
#switch(CAMERA)
#case(CAMERA_1)
  camera {
      location Cam_Drone_View(clock*Cam_spline_movespeed + Drone_View_Offset)
      look_at Runway_max(clock*Cam_spline_movespeed + Look_at_Offset)
      angle 60 // the drone cam has a wide angle :)
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
  }
  #break
#case(CAMERA_4)
  //for viewing the whole "world" from above.
  camera {
      location <-10, 350, -10>
      look_at <-40, 3, 160>
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
  //view the elevator on the big box
  camera {
      //assuming we render till Final_Clock=50
      location <60 + 0.5 * clock, 10 + 2/5 * clock, 250>
      look_at <ELEVATOR_LOC.x, ELEVATOR_LOC.y + HEIGHT * clock, ELEVATOR_LOC.z>
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
#case(CAMERA_8)
  //for viewing the first curve.
  camera {
      location Cam_on_the_big_box_Behind_Drone(clock -0.05)
      //look_at <76, 20, 100>
      look_at Runway_on_the_big_box(clock + 0.05)
  }
  #break

#end


// The ground. 
plane { y, 0 
  pigment{color<0.6,0.3,0.9>}
}

//here it is decided whether to have a running man and a chasing drone or not.

#if(START_SCENE = 1) 
  // declare the drone and the main character (the stick man) which will be chased by the drone through our world.
  object{drone rotate<0, 180,0> translate<0, 5, 0> scale 0.5 Spline_Trans(Runway_max, clock*Cam_spline_movespeed, y, 0.1, 0.5)}


  #declare Character = man_panic;
  object{Character rotate<0, 180, 0> scale 0.3 Spline_Trans(Runway_max, clock*Cam_spline_movespeed + 2, y, 0.1, 0.5)}
#end

#if (ELEVATOR_SCENE = 1)
  //declare the man on the elevator and the waiting drone
  object{drone rotate<0, 10,0> translate<0, 5, 0> scale 0.5 translate Runway_max(99.8)}


  #declare Character = man_lookup_no_movement;
  object{Character rotate<0, 10, 0> scale 0.3 translate <ELEVATOR_LOC.x + 5, ELEVATOR_LOC.y + HEIGHT * clock, ELEVATOR_LOC.z>}
#end

#if (END_SCENE = 1)
  //declare the man on big box
  object{drone rotate<0, 180,0> translate<0, 3, 0> scale 0.5 Spline_Trans(Runway_on_the_big_box, clock, y, 0.1, 0.5)}


  #declare Character = man_panic;
  object{Character rotate<0, 180, 0> scale 0.3 Spline_Trans(Runway_on_the_big_box, clock +0.05, y, 0.1, 0.5)}
#end

// insert any other objects here:


//build a great sphere which is just there and fills room
#declare Sphere_mat = Surface_Material_From(color<1,0,0.4>, color<0,1,0.2>) //from the loop.inc
          
sphere {
  <-90,0,15>, 80
  material{Sphere_mat
     scale <25,25,25> 
    rotate<360*clock, 90, 90>}
}


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


//arrange balls on the first box, BOX_1
#declare Z_delay_ball = 0;   
#while (Z_delay_ball < BOX_1_END.z)
  object{Ball translate  <START_POINT.x - 5, BOX_1_END.y +2 , 2 + Z_delay_ball + 11.5> * GENERAL_SCALE pigment{hexagon color rgb< rand(1
), rand(1), rand(3)>, color rgb< rand(2), rand(1), rand(3)>,
 color rgb< rand(2), rand(1), rand(3)>} scale 0.5 * GENERAL_SCALE rotate <0,37,0>} 

 #declare Z_delay_ball = Z_delay_ball + 3; 
 #end 

#declare Pillar_tri = object {Fancy_Pillar(0,0,0) scale GENERAL_SCALE}
//in the first curve
PositionAsTriangle_2D(Pillar_tri, 13, 0, 43, 5)

//outisde the first curve
object {Fancy_Pillar(12, 0, 18) scale GENERAL_SCALE}
object {Fancy_Pillar(14, 0, 20) scale GENERAL_SCALE}
object {Fancy_Pillar(15, 0, 22) scale GENERAL_SCALE}
object {Fancy_Pillar(14, 0, 25) scale GENERAL_SCALE}
object {Fancy_Pillar(10, 0, 29) scale GENERAL_SCALE}

// declare loops between the first curve and the loop:

object{Running_Loop scale 0.5 * GENERAL_SCALE translate<0,0,0> Spline_Trans(Runway_max, 20, y, 0.1, 0.5)}
object{Running_Loop scale 0.5 * GENERAL_SCALE translate<0,0,0> Spline_Trans(Runway_max, 23, y, 0.1, 0.5) translate<2,0,0>}
object{Running_Loop scale 0.5 * GENERAL_SCALE translate<0,0,0> rotate<0,-80,0> Spline_Trans(Runway_max, 25, y, 0.1, 0.5)}
object{Running_Loop scale 0.5 * GENERAL_SCALE translate<0,0,0> rotate<0,-80,0> Spline_Trans(Runway_max, 28, y, 0.1, 0.5) translate<0,0,5>}

//in the first "loop" in the runway:
object{Wobbel(Cam_spline_movespeed, 5) scale 3*GENERAL_SCALE translate WOBBEL_1_LOCATION}


//meanwhile we are behind the first loop, in the second "curve"
//arrange balls on the second box, BOX_2
#declare X_Delay_Ball = 0;    
#while (X_Delay_Ball > (BOX_2_END.x - BOX_2_START.x))
  object{Ball translate  <BOX_2_START.x -1.5 + X_Delay_Ball, BOX_2_START.y +2 , BOX_2_START.z + (BOX_2_END.z - BOX_2_START.z) /2 > * GENERAL_SCALE pigment{hexagon color rgb< rand(1
), rand(1), rand(3)>, color rgb< rand(2), rand(1), rand(3)>,
 color rgb< rand(2), rand(1), rand(3)>} scale 0.5 * GENERAL_SCALE} 

 #declare X_Delay_Ball = X_Delay_Ball - 3; 
 #end 

//The wall
#declare Wall_mat = material{ Surface_Material2
          scale <10,10,10> 
          rotate<360*clock, 90, 90>};

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

//inside the curve
box { 
  <-80,0,130>, <-90,25,145>
  material{Wall_mat scale 2 }
}

//the addition of 0.001 to the divisor clock avoids devision by zero:
object { Fancy_Pillar_basic_top scale 1*GENERAL_SCALE translate<0,0,0> translate<-65,-7*clock/(clock+0.001),125>}
object { Fancy_Pillar_basic_top scale 1*GENERAL_SCALE translate<0,0,0> translate<-72,-7*clock/(clock+0.001),135>}
object { Fancy_Pillar_basic_top scale 1*GENERAL_SCALE translate<0,0,0> translate<-76,-7*clock/(clock+0.001),124>}
object { Fancy_Pillar_basic_top scale 1*GENERAL_SCALE translate<0,0,0> translate<-85,-7*clock/(clock+0.001),151>}
object { Fancy_Pillar_basic_top scale 1*GENERAL_SCALE translate<0,0,0> translate<-85,-7*clock/(clock+0.001),122>}
object { Fancy_Pillar_basic_top scale 1*GENERAL_SCALE translate<0,0,0> translate<-95,-7*clock/(clock+0.001),122>}
object { Fancy_Pillar_basic_top scale 1*GENERAL_SCALE translate<0,0,0> translate<-95,-7*clock/(clock+0.001),137>}

// lights on the runway
#macro light_blob(position, col)
light_source {<0,2,0> color col Spline_Trans(Runway_max, position, y, 0.1, 0.5)
  /**looks_like { 
    sphere { <0,0,0>,0.1
      texture {
        pigment {color col}
        finish { ambient 0.9
           diffuse 0.1
           phong 250
        }
      } 
    } 
  }**/ 
}
#end

object{light_blob(44, Red)}
object{light_blob(47, Blue)}
object{light_blob(50, Yellow)}
object{light_blob(52, Blue)}
object{light_blob(54, White)}

 
//visualize the runway

union{
  #local i = 0;     // start
  #local end_index = 100;  // end
  #while (i <= end_index)
    sphere{ <0,0,0>, 0.2
      pigment{ color rgb<1,0.3,0>}
      translate Runway_max(i)
    } 
    #local i = i + 0.0005;
    #end // -------- end of loop
 }

#if(START_SCENE = 1)
  //place the elevator without y-increase
  object{Elevator(ELEVATOR_LOC, 0)}
#end 


#if(ELEVATOR_SCENE = 1)
  //place the elevator with height 
  object{Elevator(ELEVATOR_LOC, HEIGHT)}
#end 

//rotate the big box, to make the start on that box come nearer to the end of the other spline.
object{On_The_Big_Box scale 0.5 translate<0,0,0> rotate<0,180,0> translate BIG_BOX_LOCATION }

// Thorben's Section

// Wobbels in the North
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

// The Great Pillar Line in The North
object {Fancy_Pillar(80, 0, 115) scale GENERAL_SCALE}
object {Fancy_Pillar(80, 0, 110) scale GENERAL_SCALE}
object {Fancy_Pillar(75, 0, 115) scale GENERAL_SCALE}
object {Fancy_Pillar(75, 0, 110) scale GENERAL_SCALE}
object {Fancy_Pillar(70, 0, 115) scale GENERAL_SCALE}
object {Fancy_Pillar(70, 0, 110) scale GENERAL_SCALE}
object {Fancy_Pillar(65, 0, 115) scale GENERAL_SCALE}
object {Fancy_Pillar(65, 0, 110) scale GENERAL_SCALE}
object {Fancy_Pillar(60, 0, 115) scale GENERAL_SCALE}
object {Fancy_Pillar(60, 0, 110) scale GENERAL_SCALE}
object {Fancy_Pillar(55, 0, 115) scale GENERAL_SCALE}
object {Fancy_Pillar(55, 0, 110) scale GENERAL_SCALE}
object {Fancy_Pillar(50, 0, 110) scale GENERAL_SCALE}
object {Fancy_Pillar(50, 0, 115) scale GENERAL_SCALE}
object {Fancy_Pillar(45, 0, 115) scale GENERAL_SCALE}
object {Fancy_Pillar(45, 0, 110) scale GENERAL_SCALE}
//object {Fancy_Pillar(40, 0, 115) scale GENERAL_SCALE}
//object {Fancy_Pillar(40, 0, 110) scale GENERAL_SCALE}
object {Fancy_Pillar(35, 0, 115) scale GENERAL_SCALE}
object {Fancy_Pillar(35, 0, 110) scale GENERAL_SCALE}
object {Fancy_Pillar(30, 0, 115) scale GENERAL_SCALE}
object {Fancy_Pillar(30, 0, 110) scale GENERAL_SCALE}
object {Fancy_Pillar(25, 0, 115) scale GENERAL_SCALE}
object {Fancy_Pillar(25, 0, 110) scale GENERAL_SCALE}
object {Fancy_Pillar(20, 0, 115) scale GENERAL_SCALE}
object {Fancy_Pillar(20, 0, 110) scale GENERAL_SCALE}
object {Fancy_Pillar(25, 0, 115) scale GENERAL_SCALE}
object {Fancy_Pillar(25, 0, 110) scale GENERAL_SCALE}
object {Fancy_Pillar(15, 0, 110) scale GENERAL_SCALE}
object {Fancy_Pillar(15, 0, 115) scale GENERAL_SCALE}
object {Fancy_Pillar(10, 0, 110) scale GENERAL_SCALE}
object {Fancy_Pillar(10, 0, 115) scale GENERAL_SCALE}
object {Fancy_Pillar(5, 0, 110) scale GENERAL_SCALE}
object {Fancy_Pillar(5, 0, 115) scale GENERAL_SCALE}
object {Fancy_Pillar(2, 0, 110) scale GENERAL_SCALE}
object {Fancy_Pillar(0, 0, 115) scale GENERAL_SCALE}
object {Fancy_Pillar(-2, 0, 110) scale GENERAL_SCALE}
object {Fancy_Pillar(-5, 0, 110) scale GENERAL_SCALE}
object {Fancy_Pillar(-5, 0, 115) scale GENERAL_SCALE}
object {Fancy_Pillar(-10, 0, 110) scale GENERAL_SCALE}
object {Fancy_Pillar(-10, 0, 115) scale GENERAL_SCALE}
object {Fancy_Pillar(-15, 0, 115) scale GENERAL_SCALE}
object {Fancy_Pillar(-15, 0, 110) scale GENERAL_SCALE}
object {Fancy_Pillar(-20, 0, 110) scale GENERAL_SCALE}
object {Fancy_Pillar(-20, 0, 115) scale GENERAL_SCALE}
object {Fancy_Pillar(-25, 0, 110) scale GENERAL_SCALE}
object {Fancy_Pillar(-25, 0, 115) scale GENERAL_SCALE}
object {Fancy_Pillar(-30, 0, 110) scale GENERAL_SCALE}
object {Fancy_Pillar(-30, 0, 115) scale GENERAL_SCALE}
object {Fancy_Pillar(-35, 0, 110) scale GENERAL_SCALE}
object {Fancy_Pillar(-35, 0, 115) scale GENERAL_SCALE}
object {Fancy_Pillar(-40, 0, 110) scale GENERAL_SCALE}
object {Fancy_Pillar(-40, 0, 115) scale GENERAL_SCALE}
object {Fancy_Pillar(-45, 0, 110) scale GENERAL_SCALE}
object {Fancy_Pillar(-45, 0, 115) scale GENERAL_SCALE}
object {Fancy_Pillar(-50, 0, 110) scale GENERAL_SCALE}
object {Fancy_Pillar(-50, 0, 115) scale GENERAL_SCALE}
object {Fancy_Pillar(-55, 0, 110) scale GENERAL_SCALE}
object {Fancy_Pillar(-55, 0, 115) scale GENERAL_SCALE}
object {Fancy_Pillar(-60, 0, 110) scale GENERAL_SCALE}
object {Fancy_Pillar(-60, 0, 115) scale GENERAL_SCALE}
object {Fancy_Pillar(-65, 0, 110) scale GENERAL_SCALE}
object {Fancy_Pillar(-65, 0, 115) scale GENERAL_SCALE}
// Im berg Objektüberlagerung :
//object {Fancy_Pillar(-70, 0, 110) scale GENERAL_SCALE}
//object {Fancy_Pillar(-70, 0, 115) scale GENERAL_SCALE}
//object {Fancy_Pillar(-75, 0, 110) scale GENERAL_SCALE}
//object {Fancy_Pillar(-75, 0, 115) scale GENERAL_SCALE}
//object {Fancy_Pillar(-80, 0, 110) scale GENERAL_SCALE}
//object {Fancy_Pillar(-80, 0, 115) scale GENERAL_SCALE}
//object {Fancy_Pillar(-85, 0, 110) scale GENERAL_SCALE}
//object {Fancy_Pillar(-85, 0, 115) scale GENERAL_SCALE}
//object {Fancy_Pillar(-90, 0, 110) scale GENERAL_SCALE}
//object {Fancy_Pillar(-90, 0, 115) scale GENERAL_SCALE}


//Northern Spere Mountains
#declare Sphere_mat_North1 = Surface_Material_From(color<30/255,144/255,255/255>, color<255/255,255/255,0>) //from the loop.inc
#declare Sphere_mat_North2 = Surface_Material_From(
  color<255/255,255/255,0>,color<30/255,144/255,255/255>) //from the loop.inc
         

sphere {
  <-250,0,320>, 150
  material{Sphere_mat_North1
     scale <25,25,25> 
    rotate<90, 360*clock, 360*clock>}
}



sphere {
  <-40,0,400>, 90
  material{Sphere_mat_North2
     scale <25,25,25> 
    rotate<90, 360*clock, 90>}
 }


sphere {
  <50,0,400>, 50
  material{Sphere_mat_North1
     scale <25,25,25> 
    rotate<90, 90, 360*clock>}
}

sphere {
  <120,0,450>, 70
  material{Sphere_mat_North2
     scale <25,25,25> 
    rotate<360*clock, 180, 90>}
}
sphere {
  <200,0,422>, 60
  material{Sphere_mat_North1
     scale <25,25,25> 
    rotate<90, 360*clock, 90>}

  }

sphere {
  <220,0,350>, 40
  material{Sphere_mat_North2
     scale <25,25,25> 
    rotate<90, 180*clock, 180>}

  }
sphere {
  <200,0,300>, 20
  material{Sphere_mat_North1
     scale <25,25,25> 
    rotate<90, 90, 180*clock>}
}
