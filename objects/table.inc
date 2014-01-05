#local H = 0.5;	// height
#local W = 1.0;	// width in x and z
#local R = 0.015;// thickness

#declare Table =
union{
  box{<-R,0,-R>,<R,H,R>
           translate< W/2-R,0,-W/2+R>}
  box{<-R,0,-R>,<R,H,R>
           translate< W/2-R,0, W/2-R>}
  box{<-R,0,-R>,<R,H,R>
           translate<-W/2+R,0, W/2-R>}
  box{<-R,0,-R>,<R,H,R>
           translate<-W/2+R,0,-W/2+R>}

  box{ <-W/2,-0.025,-W/2>,<W/2,0,W/2>
       translate<0,H,0> }

  pigment{ color rgb<0.75,0.5,0.3>*0.3}
}