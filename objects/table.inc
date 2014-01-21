#include "woods.inc"
#local HEIGHT = 0.5;
#local WIDTH = 1.0;
#local DEPTH = 0.6;
#local THICKNESS = 0.015;

#declare table_leg = box{<-THICKNESS,0,-THICKNESS>,<THICKNESS,HEIGHT,THICKNESS>}

#declare Table = union{
  object{ table_leg
    translate< WIDTH/2-THICKNESS,0,-DEPTH/2+THICKNESS>
  }
  object{ table_leg
    translate< WIDTH/2-THICKNESS,0, DEPTH/2-THICKNESS>
  }
  object{ table_leg
    translate<-WIDTH/2+THICKNESS,0, DEPTH/2-THICKNESS>
  }
  object{ table_leg
    translate<-WIDTH/2+THICKNESS,0,-DEPTH/2+THICKNESS>
  }

  box{ <-WIDTH/2,-0.025,-DEPTH/2>,<WIDTH/2,0,DEPTH/2>
       translate<0,HEIGHT,0> }

  pigment{ DMFWood5 scale 0.1 translate <0,90,0> } //color rgb<0.75,0.5,0.3>*0.3}
  //DMFWood5
  //DarkWood
  //Rosewood

}