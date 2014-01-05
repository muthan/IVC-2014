#include "colors.inc"
#include "shapes.inc"
#include "shapes2.inc"
#include "consts.inc"
#include "glass.inc"
#include "textures.inc"
#include "fancy_pillar.inc"

//------ Randoms ---------------------
#declare Random_1 = seed (2432);
#declare Random_2 = seed (6242);
#declare Random_3 = seed (8912);

background { White }
camera {
  location <800, 800, 10>
  look_at <0, 0, 0> 
  angle 36
}

light_source {
    <1000, 1000, 0> White
} 

#declare Fancy_pillar = union{
  object{Fancy_Pillar_basic}
  object{Fancy_Pillar_basic_top pigment{color rgb< rand(Random_1), rand(Random_2), rand(Random_3)>}  }
}

object{Fancy_pillar scale 12}