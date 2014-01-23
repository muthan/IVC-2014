#include "colors.inc"
#include "shapes.inc"
#include "shapes2.inc"
#include "consts.inc"
#include "glass.inc"
#include "textures.inc"

// Objekt Drone


#declare rawdronehead =
      intersection { 
          sphere{< 0,0,0>,1}
          box{<-1,-1,-1>,<1,0.4,1>}
        }



#declare Wing =
union{
 cone  { <0,0,0>, 2.40,<0,9.50,0>, 1.00}
	sphere{ <0,0,0>, 0.80  scale<1,0.15,1> translate<0,3.50,0>}
 scale <1,1,0.15>
}

#declare Wings =
union{ object{ Wing  rotate< 83,-90,0>}
       object{ Wing  rotate<-83,-90,0>}
     } 

#declare DroneCam =
union{
object{
 				Disk_Z 
						scale <0.5,0.5,0.5>
				 		texture{
                Chrome_Metal
                pigment{color Grey}
								finish {phong 1 }
						} 
						rotate<0,0,0>
						translate<0,0,-1>
		}
    object{
        Disk_Z
          scale<0.5,0.5,0.1>
          texture{
								pigment{color Red}
								finish {phong 1 
                        reflection 0.5}
						} 
						rotate<0,0,0>
						translate<0,0,-1.5>
		}

		object{ Supertorus(
  			1.00, 0.1,// R_Major, R_Minor,
  			1.00, 0.25,// Maj_Control, Min_Control,
  			0.001,1	)// Accuracy, Max_Gradient)

        texture{
          pigment{ color Black}
          finish { phong 1}
        }

        scale<0.5,3,0.5>
        rotate<90,0,0>
        translate<0,0,-1.6>
		}
}



#macro Drone(blink)
union{	 
		object{rawdronehead
  	  	texture{Brass_Metal
            pigment{color Blue}
            finish{phong 40}
  	  	}
		}
	
	object{DroneCam
		rotate<-20,0,0>
		translate<0,0,0>
	}

	#if(mod(clock*blink,2) <= 1 & mod(clock*blink,2) > 0.5 )
    light_source{<0,-1,0> color Red*1
      looks_like{
            sphere{ <0,0,0>,0.1
                   texture{
                   pigment{color Red}
                   finish {ambient 0.9
                            diffuse 0.1
														phong 250}
                   } 
           } 
     } 
    }
    #end
    object{Wings
                texture{
                Chrome_Metal
                pigment{color Grey}
                finish {phong 1 }
            } 
    scale<0.5,0.5,0.3>
    translate<0,0,0>
  }
}
#end

#declare drone = object{Drone(1)}
#declare drone_fast = object{Drone(20)}

 
