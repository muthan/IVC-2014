//redesigned for our camera drive:
// runs from 0 to 1 and start in max_x/2, max_y and start_z. 
//then the spline expands from start_z to start_z + steps_z in 10 steps, in the direction dir.
//use 1 and -1 for positive or negative step direction
// the x_distortion will be "randomly" applied to the spline, making it curved but still startight in z-direction.
#macro CurvedSplineJump(max_X, max_Y, start_Z, steps_Z, dir, x_Distortion)
natural_spline
    -0.10, < (max_X / 2), max_Y, start_Z - 10*dir>,
    -0.05, < (max_X / 2), max_Y, start_Z - 5*dir>,
    0.00, < (max_X / 2), max_Y, start_Z>,
    0.05, < (max_X / 2) + x_Distortion, max_Y, start_Z + ( 3/100 * steps_Z) * dir>,//start at 0.00
    0.10, < (max_X / 2) - x_Distortion, max_Y, start_Z + ( 7/100 * steps_Z) * dir>,
    0.15, < (max_X / 2) + x_Distortion, max_Y, start_Z + ( 12/100 * steps_Z) * dir>,
    0.20, < (max_X / 2) + x_Distortion, max_Y, start_Z + ( 20/100 * steps_Z) * dir>,
    0.25, < (max_X / 2) - x_Distortion, max_Y, start_Z + ( 28/100 * steps_Z) * dir>,
    0.30, < (max_X / 2) - x_Distortion, max_Y, start_Z + ( 30/100 * steps_Z) * dir>,
    0.35, < (max_X / 2) + x_Distortion, max_Y, start_Z + ( 35/100 * steps_Z) * dir>,
    0.40, < (max_X / 2) + x_Distortion, max_Y, start_Z + ( 38/100 * steps_Z) * dir>,
    0.45, < (max_X / 2), max_Y, start_Z + ( 48/100 * steps_Z) * dir>,
    0.50, < (max_X / 2), max_Y +2, start_Z + ( 50/100 * steps_Z) * dir>, 
    0.55, < (max_X / 2), max_Y, start_Z + ( 53/100 * steps_Z) * dir>,// jump!
    0.60, < (max_X / 2) + x_Distortion, max_Y, start_Z + ( 57/100 * steps_Z) * dir>,
    0.65, < (max_X / 2) + x_Distortion, max_Y, start_Z + ( 60/100 * steps_Z) * dir>,
    0.70, < (max_X / 2) - x_Distortion, max_Y, start_Z + ( 68/100 * steps_Z) * dir>, 
    0.75, < (max_X / 2) - x_Distortion, max_Y, start_Z + ( 75/100 * steps_Z) * dir>,
    0.80, < (max_X / 2) - x_Distortion, max_Y, start_Z + ( 80/100 * steps_Z) * dir>,
    0.85, < (max_X / 2) + x_Distortion, max_Y, start_Z + ( 86/100 * steps_Z) * dir>,
    0.90, < (max_X / 2) + x_Distortion, max_Y, start_Z + ( 93/100 * steps_Z) * dir>,
    0.95, < (max_X / 2) + 1/2 * x_Distortion, max_Y, start_Z + ( 98/100 * steps_Z) * dir>,
    1.00, < (max_X / 2), max_Y, start_Z + ( steps_Z) * dir>,// end
    1.05, < (max_X / 2), max_Y, start_Z + ( steps_Z + 1/11 * steps_Z) * dir> 
    1.10, < (max_X / 2), max_Y - 5, start_Z + ( steps_Z + 1/12 * steps_Z) * dir> 
#end

// Creates a spline starting at <0,max_y,0>  and then slowly grows up to max_x/2
// but has z-axis distortions with multiplier distortion_grade
#macro TornadoSpline(max_X, max_Y, distortion_grade)
cubic_spline
    #local z_end = -0.1;//0.1
    -0.05, < 0.0, max_Y, 0.0>,
    0.00, < 0.0, max_Y, z_end + 0.0 * distortion_grade>,
    0.05, < 0.05, max_Y, z_end +  0.05 * distortion_grade>,
    0.10, < 0.10, max_Y, z_end +  0.10 * distortion_grade>,
    0.15, < 0.150, max_Y, z_end +  0.12 * distortion_grade>,
    0.20, < 0.20, max_Y, z_end +  0.08 * distortion_grade>,
    0.25, < 0.250, max_Y, z_end +  0.025 * distortion_grade>,
    0.30, < 0.30, max_Y, z_end +  -0.03 * distortion_grade>,
    0.35, < 0.350 max_Y, z_end +  -0.05 * distortion_grade>,
    0.40, < 0.40, max_Y, z_end +  -0.04 * distortion_grade>,
    0.45, < 0.45, max_Y, z_end +  -0.01 * distortion_grade>,
    0.50, < max_X / 2, max_Y, z_end>,
    1.55, < max_X / 2, max_Y, z_end>
#end


// this spline is like a spiral in y direction
#macro TornadoUpwardsSpline(x_loc, start_Y, max_Y, z_loc, spiral_radius)
natural_spline
    0.500, <x_loc, start_Y, z_loc>,
    0.525, <x_loc + spiral_radius, start_Y + (max_Y-start_Y) / 20 * 0.1, z_loc + spiral_radius>,
    0.550, <x_loc - spiral_radius, start_Y + (max_Y-start_Y) / 20 * 0.2, z_loc + spiral_radius>,
    0.575, <x_loc - spiral_radius, start_Y + (max_Y-start_Y) / 20 * 0.3, z_loc - spiral_radius>,
    0.600, <x_loc + spiral_radius, start_Y + (max_Y-start_Y) / 20 * 0.5, z_loc - spiral_radius>,
    0.625, <x_loc + spiral_radius, start_Y + (max_Y-start_Y) / 20 * 0.8, z_loc + spiral_radius>,
    0.650, <x_loc - spiral_radius, start_Y + (max_Y-start_Y) / 20 * 1.2, z_loc + spiral_radius>,
    0.675, <x_loc - spiral_radius, start_Y + (max_Y-start_Y) / 20 * 1.8, z_loc - spiral_radius>,
    0.700, <x_loc + spiral_radius, start_Y + (max_Y-start_Y) / 20 * 2.5, z_loc - spiral_radius>,
    0.725, <x_loc + spiral_radius, start_Y + (max_Y-start_Y) / 20 * 3.5, z_loc + spiral_radius>,
    0.750, <x_loc - spiral_radius, start_Y + (max_Y-start_Y) / 20 * 4.5, z_loc + spiral_radius>, 
    0.775, <x_loc - spiral_radius, start_Y + (max_Y-start_Y) / 20 * 5.5, z_loc - spiral_radius>,
    0.800, <x_loc + spiral_radius, start_Y + (max_Y-start_Y) / 20 * 7, z_loc - spiral_radius>,
    0.825, <x_loc + spiral_radius, start_Y + (max_Y-start_Y) / 20 * 8.5, z_loc + spiral_radius>,
    0.850, <x_loc - spiral_radius, start_Y + (max_Y-start_Y) / 20 * 10, z_loc + spiral_radius>, 
    0.875, <x_loc - spiral_radius, start_Y + (max_Y-start_Y) / 20 * 12, z_loc - spiral_radius>,
    0.900, <x_loc + spiral_radius, start_Y + (max_Y-start_Y) / 20 * 15, z_loc - spiral_radius>,
    0.925, <x_loc + spiral_radius, start_Y + (max_Y-start_Y) / 20 * 19, z_loc + spiral_radius>,
    0.950, <x_loc - spiral_radius, start_Y + (max_Y-start_Y) / 20 * 24, z_loc + spiral_radius>,
    0.975, <x_loc - spiral_radius, start_Y + (max_Y-start_Y) / 20 * 30, z_loc - spiral_radius>,
    1.00, <x_loc + spiral_radius, start_Y + (max_Y-start_Y) / 20 * 35, z_loc + spiral_radius> //in the middle again
#end

/**
 * This Spline goes from 0 to 100 in ints accepted keys.
 **/
#macro RunawayLongEven(x_loc, y_loc, z_loc, my_scale)
natural_spline
    00, <x_loc, y_loc, z_loc> * my_scale,
    02, <x_loc - 1, y_loc, z_loc + 2> * my_scale,
    04, <x_loc - 1.5, y_loc, z_loc + 5> * my_scale,
    06, <x_loc - 0.5, y_loc, z_loc + 7> * my_scale,
    8, <x_loc + 1, y_loc, z_loc + 10> * my_scale,
    10, <x_loc + 1.5, y_loc, z_loc + 12> * my_scale,
    12, <x_loc + 2, y_loc, z_loc + 14> * my_scale,
    14, <x_loc + 7, y_loc, z_loc + 20> * my_scale,
    16, <x_loc + 9, y_loc, z_loc + 20> * my_scale,
    18, <x_loc + 13, y_loc, z_loc + 23> * my_scale,
    20, <x_loc + 6, y_loc, z_loc + 30> * my_scale,
    22, <x_loc + 4, y_loc, z_loc + 32> * my_scale,
    24, <x_loc, y_loc, z_loc + 40> * my_scale,
    26, <x_loc + 2, y_loc, z_loc + 44> * my_scale,
    28, <x_loc - 4, y_loc, z_loc + 50> * my_scale,
    30, <x_loc - 8, y_loc, z_loc + 50> * my_scale,
    32, <x_loc - 16, y_loc, z_loc + 50> * my_scale,
    34, <x_loc - 15, y_loc, z_loc + 63> * my_scale, //here is a 'loop'
    36, <x_loc - 10, y_loc, z_loc + 57> * my_scale, //go back a little
    38, <x_loc - 15, y_loc, z_loc + 57> * my_scale,
    40, <x_loc - 20, y_loc, z_loc + 60> * my_scale,
    42, <x_loc - 26, y_loc, z_loc + 60> * my_scale,
    44, <x_loc - 30, y_loc, z_loc + 60> * my_scale,
    46, <x_loc - 50, y_loc, z_loc + 60> * my_scale, //long turn to left
    48, <x_loc - 50, y_loc, z_loc + 65> * my_scale,
    50, <x_loc - 55, y_loc, z_loc + 70> * my_scale, //my part!
    52, <x_loc - 50, y_loc, z_loc + 75> * my_scale, 
    54, <x_loc - 40, y_loc, z_loc + 77> * my_scale, 
    56, <x_loc - 35, y_loc, z_loc + 70> * my_scale, 
    58, <x_loc - 25, y_loc, z_loc + 65> * my_scale, 
    60, <x_loc - 20, y_loc, z_loc + 65> * my_scale, 
    62, <x_loc - 15, y_loc, z_loc + 65> * my_scale, 
    64, <x_loc - 10, y_loc, z_loc + 80> * my_scale, 
    66, <x_loc - 5, y_loc, z_loc + 85> * my_scale, 
    68, <x_loc - 0, y_loc, z_loc + 90> * my_scale, 
    70, <x_loc - 0, y_loc, z_loc + 100> * my_scale, 
    72, <x_loc - 0, y_loc, z_loc + 110> * my_scale, 
    74, <x_loc + 10, y_loc, z_loc + 130> * my_scale, 
    76, <x_loc + 20, y_loc, z_loc + 150> * my_scale, 
    78, <x_loc + 25, y_loc, z_loc + 122> * my_scale, 
    80, <x_loc + 17, y_loc, z_loc + 115> * my_scale, 
    82, <x_loc + 20, y_loc, z_loc + 140> * my_scale, 
    84, <x_loc + 55, y_loc, z_loc + 160> * my_scale, 
    86, <x_loc + 60, y_loc, z_loc + 170> * my_scale, 
    88, <x_loc + 65, y_loc, z_loc + 175> * my_scale, 
    90, <x_loc + 70, y_loc, z_loc + 180> * my_scale, 
    92, <x_loc + 75, y_loc, z_loc + 170> * my_scale, 
    94 <x_loc + 70, y_loc, z_loc + 160> * my_scale, 
    96, <x_loc + 63, y_loc, z_loc + 150> * my_scale, 
    98, <x_loc + 52, y_loc, z_loc + 130> * my_scale, 
    100, <x_loc + 40, y_loc, z_loc + 108> * my_scale,//end
    102, <x_loc + 39, y_loc, z_loc + 10> * my_scale //control point for camera
#end