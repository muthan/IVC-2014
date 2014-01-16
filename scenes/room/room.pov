#include "colors.inc"
#include "transforms.inc"
#include "../../objects/pencil.inc"
#include "../../objects/table.inc"
#include "../../objects/lamp.inc"
#include "../../objects/spline_macro.inc"
#include "../../objects/tornado.inc"
#include "../../objects/maenchen.inc"

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

  //paper 
  box {
    <0, 0.5+0.001, 0> <0.12, 0.5+0.001, 0.22>
    translate <0.5,0,-0.2>
    pigment { White }
  }

  object { red_pencil
          scale 0.001
          rotate <0, 225, 0>
          translate <0.65, 0.5+0.002, -0.1>
  }

  object { Lamp
          scale 0.01
          rotate<0,130,0>
          translate <0.8,0.5,0.1>
  }
  translate <-0.05,0,0>
}

#declare Tornado_spline = spline {TornadoSpline(1, 0.5, 3)}
object { Tornado(0)
  scale 0.02
  translate Tornado_spline(clock)
}


#if (clock >= 0.5)
  #declare Test_spline = spline {TornadoUpwardsSpline(0.5, 0.5, 1.3, -0.15, 0.005)}//-0.05
  object { man_tornado
    rotate <90,0,0>
    scale 0.02
    

    #if (clock > 0.6)
      rotate y*clock*360*5
    #end
    
    translate Test_spline(clock)
  }
#end

// visualize our spline, uncomment for usage:
/**union{
  #local i = 0;     // start
  #local end_index = 1;  // end
  #while (i <= end_index)
    sphere{ <0,0,0>, 0.003 //radius

      pigment{ color rgb<1,0.3,0>}
      translate  Test_spline // or any spline name to test.


(i)
    } // end of sphere
    #local i = i + 0.01;
  #end // -------- end of loop
 }
**/
 
