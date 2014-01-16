#local H = 0.5;	// height
#local W = 1.0;	// width
#local D = 0.6; // depth
#local R = 0.015;// thickness

#declare table_leg = box{<-R,0,-R>,<R,H,R>}

#declare Table = union{
  object{ table_leg
    translate< W/2-R,0,-D/2+R>
  }
  object{ table_leg
    translate< W/2-R,0, D/2-R>
  }
  object{ table_leg
    translate<-W/2+R,0, D/2-R>
  }
  object{ table_leg
    translate<-W/2+R,0,-D/2+R>
  }

  box{ <-W/2,-0.025,-D/2>,<W/2,0,D/2>
       translate<0,H,0> }

  pigment{ color rgb<0.75,0.5,0.3>*0.3}
}