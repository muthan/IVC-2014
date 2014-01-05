#include "colors.inc"
#include "textures.inc"
#include "metals.inc"

#declare Area_Light = false;

#declare metal_lamp_base = union
{
        cylinder
        {
                <0, 0.2, 0>, <0, 1.9, 0>, 5
        }
        cylinder
        {
                <0, 0.2, 0>, <0, 2, 0>, 4.9
        }
        torus
        {
                4.9, 0.1
                translate <0, 1.9, 0>
        }
        cone
        {
                <0, 1.9, 0>, 5, <0, 3, 0>, 0
        }
        pigment
        {
                colour Red
        }
        finish
        {
                Shiny
        }
}

#declare plastic_lamp_base = union
{
        cone
        {
                <0,0,0>, 4.4, <0,0.1,0>, 4.5
        }
        difference
        {
                cylinder
                {
                        <0, 0.1, 0>, <0, 0.5, 0>, 5.2
                }
                cylinder
                {
                        <0, 0.2, 0>, <0, 1, 0>, 4.99
                }
        }
        pigment
        {
                colour rgb <253 / 255, 243 / 255, 223 / 255> // was Gray90
        }
        finish
        {
                Dull
        }
}

#declare lamp_base = union
{
        object
        {
                plastic_lamp_base
        }
        object
        {
                metal_lamp_base
        }
}

#declare base_pipe = cylinder
{
        <0, 0, 0>, <0, 6, 0>, 0.6
        pigment
        {
                colour Red
        }
        finish
        {
                Shiny
        }
} 

#declare metal_bit1 = union
{
        cylinder
        {
                <0, 0, 0>, <0, 1.5, 0>, 0.6
        }
        difference
        {
                sphere
                {
                        <0, 1.5, 0>, 0.6
                }
                box
                {
                        <-10, 1.8, -10>, <10, 5, 10>
                }
        }
        pigment
        {
                P_Chrome3
        }
        finish
        {
                F_MetalC
        }
}

#declare metal_flex = union
{
        #declare current_angle = 0;
        #declare final_angle = 65;
        #declare angle_step = 1;
        #declare angle_centre = 15;
        #declare x_offset = -(angle_centre);
        #declare y_offset = 7.8;
        
        #while (current_angle <= final_angle)
                #declare xloc = x_offset + (angle_centre * cos (radians (current_angle)));
                #declare yloc = y_offset + (angle_centre * sin (radians (current_angle)));
                          
                sphere
                {
                        <xloc, yloc, 0>, 0.5
                }

                #declare current_angle = current_angle + angle_step;
        #end

        pigment
        {
                P_Chrome3
        }
        finish
        {
                F_MetalC
        }
}

#declare metal_bit2 = union
{
        cylinder
        {
                <0, 0.3, 0>, <0, 1.8, 0>, 0.6
        }
        difference
        {
                sphere
                {
                        <0, 0.3, 0>, 0.6
                }
                box
                {
                        <-10, -10, -10>, <10, 0, 10>
                }
        }
        cone
        {
                <0, 1.8, 0>, 0.6, <0, 2, 0>,1.2
        }
        cylinder
        {
                <0, 2, 0>, <0, 2.1, 0>, 1.2
        }
        pigment
        {
                P_Chrome3
        }
        finish
        {
                F_MetalC
        }
}

#declare from_base_to_lamp = union
{
        object
        {
                base_pipe
        }
        object
        {
                metal_bit1
                translate <0, 6, 0>
        }
        object
        {
                metal_flex
        }
        object
        {
                metal_bit2
                rotate z*45
                translate <xloc, yloc, 0>
        }
}

#declare base_lamp_head = union
{
        cylinder
        {
                <0, 0, 0>, <0, 6, 0>, 2.5
        }
        cone
        {
                <0, 6, 0>, 2.5, <0, 9.5, 0>, 5
        }
        cylinder
        {
                <0, 9.5, 0>, <0, 12, 0>, 5
        }
        cylinder
        {
                <0, 11.5, 0>, <0, 12, 0>, 5.2
        }
        pigment
        {
                colour Red
        }
        finish
        {
                Shiny
        }
}

#declare not_base_lamp_head = union
{
        cylinder
        {
                <0, 0.1, 0>, <0, 20, 0>, 2.4
        }
        cone
        {
                <0, 6, 0>, 2.4, <0, 9.6, 0>, 4.95
        }
        cylinder
        {
                <0, 9.5, 0>, <0, 20, 0>, 4.9
        }
        pigment
        {
                colour White
        }
        finish
        {
                Glossy
        }
}

#declare simple_bulb = difference
{
        sphere
        {
                <0, 0, 0>, 3
        }
        sphere
        {
                <0, 0, 0>, 2.9
        }
        texture
        {
                pigment
                {
                        colour rgb <255 / 255, 253 / 255, 187 / 255> // should be pearl
                }
                finish
                {
                        ambient 1.2
                        diffuse .6
                }
        }
}

#declare lamp_head = union
{
        difference
        {
                object
                {
                        base_lamp_head
                }
                object
                {
                        not_base_lamp_head
                }
                translate <0, -3, 0>
        }
        sphere
        {
                <0, -3, 0>, 0.6
                pigment
                {
                        P_Chrome3
                }
                finish
                {
                        F_MetalC
                }
        }
        light_source
        {
                <0, 6.5, 0>
                colour rgb < 255 / 255, 253 / 255, 187 / 255> // was White
                //parallel
                //point_at<0, 0.5, 0>
                #if (Area_Light = true)
                        area_light <5, 0, 0>, <0, 0, 5>, 5, 5
                        jitter
                #end
                looks_like
                {
                        simple_bulb
                }
        }
}

#declare flex_cable = cylinder
{
        <5.5, 0.1, 0>, <20, 0.1, 6>, 0.3
        pigment
        {
                colour rgb <253 / 255, 243 / 255, 223 / 255> // was Gray90
        }
        finish
        {
                Dull
        }
}

#declare flex_fitting = cone
{
        <5, 1, 0>, 0.75, <6, 1, 0>, 0.6
        pigment
        {
                colour Black
        }
        finish
        {
                Dull
        }
}

#declare base_flex = union
{
        object
        {
                flex_cable
        }
        object
        {
                flex_fitting
        }
}

#declare lamp_switch = union
{
        difference
        {
                union
                {
                        cylinder {<0,0,0>, <0,1,0>, 0.7}
                        difference
                        {
                                sphere {<0,1,0> 0.7}
                                box {<-10, 1.3, -10>, <10,10,10>}
                        }
                
                }
                cylinder {<0, 0.5, 0>, <0, 5, 0>, 0.51}
        }
        union
        {
                cylinder {<0, 0.5, 0>, <0, 1.4, 0>, 0.25}
                sphere {<0, 1.4, 0>, 0.25}
                scale <2, 1, 2>
        }
        pigment
        {
                colour rgb <253 / 255, 243 / 255, 223 / 255> // was Gray90
        }
        finish
        {
                Dull
        }
}

#declare desk_lamp = union
{
        object
        {
                lamp_base
        }
        object
        {
                lamp_switch
                rotate <0, 0, 12.4>
                translate <-3, 1.5, 0>
        }
        object
        {
                base_flex
        }
        union
        {
                object
                {
                        from_base_to_lamp
                }
                object
                {
                        lamp_head
                        rotate z*135
                        translate <xloc - 3, (yloc + 3 + 1.8) - 1.5, 0>   
                }
                rotate <0, 0, 0>
                translate <3, 2, 0>
        }
}
