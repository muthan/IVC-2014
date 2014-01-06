#include "colors.inc"
#include "shapes.inc"
#include "shapes2.inc"
#include "consts.inc"
#include "glass.inc"
#include "textures.inc"



#declare Ball =
sphere{<0,0,0>,2
       texture{pigment{checker Blue, Orange}
              finish {ambient 0.15
                       diffuse 0.85
                       phong 1}
              }
        rotate<0, 36000*clock, 0>
       }