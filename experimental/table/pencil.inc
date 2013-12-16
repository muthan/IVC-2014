#include "colors.inc"
#include "textures.inc"
#include "woods.inc"
#include "metals.inc"

#declare pencil_wood_texture = texture
{
    T_Wood35
    finish
    {
        specular 0.15
        roughness 0.025
        ambient 0.25
        reflection 0
    }

    rotate y*90
    rotate <10, 0, 15>
    scale <2,1,1>
    translate -3*x
}

#declare pencil_clipping_box = box
{
    <-100,0,0>, <100, 10, 10>
}

#declare pencil_hexagon = difference
{
    box
    {
        <-80, -(sqrt (12)), -4>, <80, sqrt (12), 4>
    }
    object
    {
        pencil_clipping_box
        translate <0,0,-10>
        rotate <30,0,0>
        translate <0,0,-4>
    }
    object
    {
        pencil_clipping_box
        rotate <-30,0,0>
        translate <0,0,4>
    }
    object
    {
        pencil_clipping_box
        translate <0,-10,-10>
        rotate <-30,0,0>
        translate <0,0,-4>
    }
    object
    {
        pencil_clipping_box
        translate <0,-10,0>
        rotate <30,0,0>
        translate <0,0,4>
    }
}

#declare pencil_sharpener = difference
{
    box
    {
        <50,-20,-20>, <100,20,20>
    }
    cone
    {
        <50,0,0>, 6, <79.9,0,0>, 0.01
    }
    sphere
    {
        <79.99,0,0>, 0.01
    }
}

#declare pencil_lead_base = cylinder
{
    <-80,0,0>, <80,0,0>, 1.5
}

#declare pencil_text = text
{
    ttf "arial.ttf"
    "OA98 graphite pencil   HB"
    1, 0
    pigment
    {
        BrightGold
    }
    finish
    {
        reflection .25
        specular 1
    }
}

#declare pencil_lead = difference
{
    object
    {
        pencil_lead_base
    }
    object
    {
        pencil_sharpener
    }
    pigment
    {
        rgb <0.1, 0.1, 0.1>
    }
    finish
    {
        Dull
    }
}

#declare pencil_wood = difference
{
    object
    {
        pencil_hexagon
        scale <1, 0.99, 0.99>
    }
    object
    {
        pencil_lead_base
        scale <1.1,1,1>
    }
    object
    {
        pencil_sharpener
    }
    texture
    {
        pencil_wood_texture
    }
}

#declare pencil_paint_red = difference
{
    object
    {
        pencil_hexagon
    }
    object
    {
        pencil_hexagon
        scale <1.1,0.99,0.99>
    }
    object
    {
        pencil_sharpener
    }
    pigment
    {
        Red
    }
    finish
    {
        specular 0.15
        roughness 0.025
        ambient 0.25
        reflection 0.01
    }
}

#declare pencil_paint_orange = difference
{
    object
    {
        pencil_hexagon
    }
    object
    {
        pencil_hexagon
        scale <1.1,0.99,0.99>
    }
    object
    {
        pencil_sharpener
    }
    pigment
    {
        colour rgb <0.984, 0.457, 0.141>
    }
    finish
    {
        specular 0.15
        roughness 0.025
        ambient 0.25
        reflection 0.01
    }
}
#declare pencil_paint_white = difference
{
    object
    {
        pencil_hexagon
    }
    object
    {
        pencil_hexagon
        scale <1.1,0.99,0.99>
    }
    object
    {
        pencil_sharpener
    }
    pigment
    {
        colour White
    }
    finish
    {
        specular 0.15
        roughness 0.025
        ambient 0.25
        reflection 0.01
    }
}

#declare pencil_sleeve_red = difference
{
    object
    {
        pencil_paint_red
    }
    object
    {
        pencil_text
        scale 3
        rotate <90,0,0>
        translate <-74, 2.99 + sqrt(12), -1.06>
    }
}

#declare pencil_sleeve_orange = difference
{
    object
    {
        pencil_paint_orange
    }
    object
    {
        pencil_text
        scale 3
        rotate <90,0,0>
        translate <-74, 2.99 + sqrt(12), -1.06>
    }
}

#declare pencil_sleeve_white = difference
{
    object
    {
        pencil_paint_white
    }
    object
    {
        pencil_text
        scale 3
        rotate <90,0,0>
        translate <-74, 2.99 + sqrt(12), -1.06>
    }
}

#declare red_pencil = union
{
    object {pencil_lead}
    object {pencil_wood}
    object {pencil_sleeve_red}
}

#declare orange_pencil = union
{
    object {pencil_lead}
    object {pencil_wood}
    object {pencil_sleeve_orange}
}

#declare white_pencil = union
{
    object {pencil_lead}
    object {pencil_wood}
    object {pencil_sleeve_white}
}