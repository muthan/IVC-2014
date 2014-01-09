#include "colors.inc"
#include "shapes.inc"
#include "shapes2.inc"
#include "consts.inc"
#include "glass.inc"
#include "textures.inc"

background { White }

camera {
  location <4, 5, -20>
  look_at <0, 0, 0> 
  angle 36
}

light_source {
  <1000, 1000, 0> White
}



#declare headR = 0.75;
#declare bodyR = 0.25;
#declare limbR = 0.23;
#declare ampleg = 70;
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
      linear_spline 
      2, 
      <0.0, 0.00,0.0>, bodyR
      < 0.00, 2.0, 0>, bodyR
      texture{
            pigment{ color Grey}
            finish { phong 1}
            } 
      scale<1,1,1>
      }

//glied
#declare limb =
  sphere_sweep {
        linear_spline // spline type
        3, //7 number of <x,y,z> points, radius
        <0.0, 0.0,0.0>, limbR
        < 1, 0.0, 0>, limbR
        <2,0.5,0>,limbR
        texture{
            pigment{ color Grey}
            finish { phong 1}
            } // end of texture
        scale<1,1,1>
        } // end of sphere sweep


#declare man =
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

  object{man translate<0.0,0.0,0.0>}
