#include "colors.inc"
#include "transforms.inc"
#include "../../objects/pencil.inc"
#include "../../objects/table.inc"
#include "../../objects/lamp.inc"
#include "../../objects/spline_macro.inc"
#include "../../objects/tornado.inc"
#include "../../objects/maenchen.inc"

#declare START = 1;
#declare END = 2;

#declare SCENE = END;

background { Black }

camera {
  location <1, 1.2, -1.2>
  look_at <0.6, 0.5, 0> 
  //angle 18
}

light_source {
  <-10, 200, -200> White
}

plane{ <0,0.1,0>, 0 
  texture{ pigment{ Black } }
}

union {
  object { Table
          rotate<0,0,0>
          translate<0.5,0,0>
  }

  box{ <0,0,0> <0.12,0.22,0>
    texture{ pigment{ White } }
    #if ((SCENE = START & clock <= 0.5) | (SCENE = END & clock > 0.3))
      texture{
        pigment{
          image_map{ png "sticky_texture.png"
            map_type 0
            once
          }
          translate <0.4,0.5,0>
          scale <0.6,1,1>*0.1
        }
      }
    #end
    rotate <90,0,0>
    translate <0.5,0.5001,-0.2>
  }


  object { red_pencil
          scale 0.001
          rotate <0, 225, 0>
          translate <0.65, 0.5+0.002, -0.15>
  }

  object { Lamp
          scale 0.01
          rotate<0,130,0>
          translate <0.8,0.5,0.1>
  }
  translate <-0.05,0,0>
}

#if(SCENE = START)
  #declare Tornado_spline = spline {TornadoSpline(1, 0.5, 3)}
  object { Tornado(0)
    scale 0.02
    translate Tornado_spline(clock)
  }

  #if (clock >= 0.5)
    #declare Test_spline = spline {TornadoUpwardsSpline(0.5, 0.5, 1.3, -0.15, 0.005)}//-0.05
    object {
      #if(clock < 0.6)
        manLooks(0)
      #else
        man_tornado
      #end
      rotate <90,0,0>
      scale 0.02
      #if (clock > 0.6)
        rotate y*clock*360*5
      #end
      translate Test_spline(clock)
    }
  #end
#end

// Falling Sticky
#if(SCENE = END & clock < 0.3)
  #local clock_individual = clock*(1/0.3);
  object {
    man_tornado
    scale 0.02
    rotate x*clock_individual*90
    translate <0.5,0.5 + (1-clock_individual),-0.15>    
  }
#end

#macro DiceSpline()
#local x_pos = 0.75;
#local z_pos = -0.05;
#local clock_offset = 0.4;
linear_spline
    clock_offset + 0.00 <x_pos, 2, z_pos>,
    clock_offset + 0.40 <x_pos, 0.51, z_pos>,
    clock_offset + 0.41 <x_pos - 0.025, 0.58, z_pos>,
    clock_offset + 0.43 <x_pos - 0.05, 0.6, z_pos>,
    clock_offset + 0.46 <x_pos - 0.075, 0.57, z_pos>,
    clock_offset + 0.50 <x_pos - 0.10, 0.51, z_pos>,
    clock_offset + 0.51 <x_pos - 0.12, 0.54, z_pos>,
    clock_offset + 0.52 <x_pos - 0.14, 0.54, z_pos>,
    clock_offset + 0.53 <x_pos - 0.15, 0.53, z_pos>,
    clock_offset + 0.55 <x_pos - 0.165, 0.51, z_pos>,
    clock_offset + 0.60 <x_pos - 0.18, 0.51, z_pos>,
#end

#declare Dice_Spline = spline {DiceSpline()}
  object{
    Icosahedron
    pigment { Green filter 0.8 }
    hollow
    interior{ media{
               emission <1.0,0.1,0.5>*7
            } } //Plexiglas_Ior
    finish { ambient rgb <0.4,0.2,0.5> }
    scale 0.01
    rotate z*clock*360*5
    //translate <0.8,0.5 + (1-double_clock),-0.15>
    translate Dice_Spline(clock)
  }


// visualize our spline, uncomment for usage:
/**union{
  #local i = 0;     // start
  #local end_index = 1;  // end
  #while (i <= end_index)
    sphere{ <0,0,0>, 0.003 //radius

      pigment{ color rgb<1,0.3,0>}
      translate Dice_Spline(i)
    } // end of sphere
    #local i = i + 0.01;
  #end // -------- end of loop
 }
**/