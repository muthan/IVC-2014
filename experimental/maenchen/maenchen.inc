#include "colors.inc"
#include "shapes.inc"
#include "shapes2.inc"
#include "consts.inc"
#include "glass.inc"
#include "textures.inc"

#declare headR = 0.75;
#declare bodyR = 0.25;
#declare limbR = 0.23;
#declare ampleg = 40;
#declare amparm = 20;


//kopf
#declare halfhead =
      intersection { 
          sphere{< 0,0,0>,headR}
          box{<-headR,-headR,-headR>,<headR,headR,0>}
        }

#declare head =
union{
  object{halfhead
    texture{
            pigment{color Grey}
            finish{phong 1}
    }
    texture{
            pigment{
              image_map{png "eyes.png"
                        once
                        map_type 0
              }
              translate<-0.5,-0.5,0>
              scale<0.75,1,1>*1.5
            }
    }
  }
  object{halfhead
    texture{
            pigment{color Grey}
            finish{phong 1}
    }
  rotate<0,180,0>
  }
}



//koerper
#declare  body =  
  sphere_sweep {
      linear_spline // spline type
      2, //7 number of <x,y,z> points, radius
      <0.0, 0.00,0.0>, bodyR
      < 0.00, 2.0, 0>, bodyR
      texture{
            pigment{ color Grey}
            finish { phong 1}
            } // end of texture
      scale<1,1,1>
      } // end of sphere sweep

//glied
#declare limb =
  sphere_sweep {
        linear_spline // spline type
        2, //7 number of <x,y,z> points, radius
        <0.0, 0.0,0.0>, limbR
        < 1, 0.0, 0>, limbR
        texture{
            pigment{ color Grey}
            finish { phong 1}
            } // end of texture
        scale<1,1,1>
        } // end of sphere sweep


#declare manLooks-LR =
  union {
      object {head 
              rotate <0,70*sin(2*pi*clock),0>
              translate <0.0, 4.0, 0.0>
              }
      object {body translate <0.0, 2.0, 0.0>}
      
      //left arm
      object {limb
        rotate <0,0,-50>
        translate <0.0, 3.2, 0.0>
      }
      object {limb
        rotate <0,70,-40>
        translate <0.7,2.4, 0.0>
      }
       
            
      //right arm
      object {limb
        rotate <0,180,50>
        translate <0.0, 3.2, 0.0>
      }
      object {limb
        rotate <0,110,40>
        translate <-0.7,2.4, 0.0>
      }
      
      //left leg

      object{body
        rotate <0,0,-195>
        translate <0,2,0>
      }

      // right leg
      object{body
        rotate <0,0,195>
        translate <0,2,0>
      }
}

#declare man-lookup =
  union {
      object {head 
              rotate <70*sin(0.5*pi*clock),0,0>
              translate <0.0, 4.0, 0.0>
              }
      object {body translate <0.0, 2.0, 0.0>}
      
      //left arm
      object {limb
        rotate <0,0,-50>
        translate <0.0, 3.2, 0.0>
      }
      object {limb
        rotate <0,70,-40>
        translate <0.7,2.4, 0.0>
      }
       
            
      //right arm
      object {limb
        rotate <0,180,50>
        translate <0.0, 3.2, 0.0>
      }
      object {limb
        rotate <0,110,40>
        translate <-0.7,2.4, 0.0>
      }
      
      //left leg

      object{body
        rotate <0,0,-195>
        translate <0,2,0>
      }

      // right leg
      object{body
        rotate <0,0,195>
        translate <0,2,0>
      }
}

#declare man-runsNormal =
  union {
      object {head translate <0.0, 4.0, 0.0>}
      object {body translate <0.0, 2.0, 0.0>}
      
      //left arm
      object {limb
        rotate <0,0,-50>
        translate <0.0, 3.2, 0.0>
      }
      object {limb
        rotate <0,70,-40>
        translate <0.7,2.4, 0.0>
      }
       
            
      //right arm
      object {limb
        rotate <0,180,50>
        translate <0.0, 3.2, 0.0>
      }
      object {limb
        rotate <0,110,40>
        translate <-0.7,2.4, 0.0>
      }
      
      //left leg

      object{body
        rotate <ampleg*-sin(2*clock*2*pi),0,-195>
        translate <0,2,0>
      }

      // right leg
      object{body
        rotate <ampleg*sin(2*clock*2*pi),0,195>
        translate <0,2,0>
      }
}

#declare man-panic =
  union {
      object {head translate <0.0, 4.0, 0.0>}
      object {body translate <0.0, 2.0, 0.0>}
      
      //left arm
      object {limb
        rotate <0,0,20>
        translate <0.0, 2.8, 0.0>
      }
      object {limb
        rotate <0,0,(amparm*sin(25*clock*2*pi))+70>
        translate <1,3.2, 0.0>
      }
       
            
      //right arm
      object {limb
        rotate <0,180,-20>
        translate <0.0, 2.8, 0.0>
      }
      object {limb
        rotate <0,180,(amparm*sin(25*clock*2*pi))-70>
        translate <-1,3.2, 0.0>
      }
      
      //left leg
      object{body
        rotate <ampleg*-sin(45*clock*2*pi),0,-195>
        translate <0,2,0>
      }

      // right leg
      object{body
        rotate <ampleg*sin(45*clock*2*pi),0,195>
        translate <0,2,0>
      }
}

#declare man-tornado =
  union {
      object {head translate <0.0, 4.0, 0.0>}
      object {body translate <0.0, 2.0, 0.0>}
      
      //left arm
      object {limb
        rotate <0,0,20>
        translate <0.0, 2.8, 0.0>
      }
       
            
      //right arm
      object {limb
        rotate <0,180,-20>
        translate <0.0, 2.8, 0.0>
      }
      
      //left leg
      object{body
        rotate <0,0,-195>
        translate <0,2,0>
      }

      // right leg
      object{body
        rotate <0,0,195>
        translate <0,2,0>
      }

    }
