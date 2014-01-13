/**
 * Positions a given object Obj in a quader in 2D space (means x and y offsetting). 
 * The first object will be located at the given position <x, y, z> 
 * and then will be brought into shape with the given size as offset.
 */
#macro PositionAsQuad_2D(Obj,X,Y,Z,Size) 
  union {
    object{Obj translate<X, Y, Z>}
    object{Obj translate<X + Size, Y, Z>}
    object{Obj translate<X + Size, Y + Size, Z>}
    object{Obj translate<X, Y + Size, Z>}
  }
#end


/**
 * Positions a given object Obj in a quader in 3D space .
 * The first object will be located at the given position <x, y, z> 
 * and then will be brought into shape with the given size as offset.
 */
#macro PositionAsQuad_3D(Obj,X,Y,Z,Size) 
  union {
    object{Obj translate<X, Y, Z>}
    object{Obj translate<X + Size, Y, Z>}
    object{Obj translate<X, Y + Size, Z>}
    object{Obj translate<X, Y, Z + Size>}
    object{Obj translate<X + Size, Y + Size, Z>}
    object{Obj translate<X + Size, Y, Z + Size>}
    object{Obj translate<X, Y + Size, Z + Size>}
    object{Obj translate<X + Size, Y + Size, Z + Size>}
  }
#end

/**
 * Positions a given object Obj in a triangle in 2D space (means x and z offsetting). 
 * The first object will be located at the given position <x, y, z> 
 * and then will be brought into shape with the given size as offset.
 */
#macro PositionAsTriangle_2D(Obj,X,Y,Z,Size) 
  union {
    object{Obj translate<X, Y, Z>}
    object{Obj translate<X + Size, Y, Z>}
    object{Obj translate<X + Size/2, Y, Z + Size>}
  }
#end

/**
 * Positions a given object Obj in a triangle in 3D space 
 * The first object will be located at the given position <x, y, z> 
 * and then will be brought into shape with the given size as offset.
 */
#macro PositionAsTriangle_3D(Obj,X,Y,Z,Size) 
  union {
    object{Obj translate<X, Y, Z>}
    object{Obj translate<X + Size, Y, Z>}
    object{Obj translate<X + Size/2, Y + Size, Z + Size/2>}
    object{Obj translate<X + Size/2, Y, Z + Size>}
  }
#end