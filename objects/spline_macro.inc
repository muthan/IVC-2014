// Creates a spline located in the middle of max_X with distortions to left and right. 
// It rapidly grows up to max_Y and slowly grows up to max_Z
// provided parameters have to be: max_Y >= 40, max_Z >= 370 and x_Distotion < max_X
#macro CurvedSpline(max_X, max_Y, max_Z, x_Distortion)
natural_spline
    0.00, < (max_X / 2) + x_Distortion, 0.0, 0.0>,
    0.05, < (max_X / 2) - x_Distortion, 10.0, 0.0>,
    0.10, < (max_X / 2) - x_Distortion, 25.0, 0.0>,
    0.15, < (max_X / 2) + x_Distortion, 40.0, 0.0>,
    0.20, < (max_X / 2) + x_Distortion, max_Y, 12.0>,
    0.25, < (max_X / 2) + x_Distortion, max_Y, 28.0>,
    0.30, < (max_X / 2) - x_Distortion, max_Y, 50.0>,
    0.35, < (max_X / 2) - x_Distortion, max_Y, 70.0>,
    0.40, < (max_X / 2) + x_Distortion, max_Y, 92.0>,
    0.45, < (max_X / 2) - x_Distortion, max_Y, 120.0>,
    0.50, < (max_X / 2) - x_Distortion, max_Y, 142.0>, 
    0.55, < (max_X / 2) + x_Distortion, max_Y, 190.0>,
    0.60, < (max_X / 2) - x_Distortion, max_Y, 220.0>,
    0.65, < (max_X / 2) + x_Distortion, max_Y, 232.0>,
    0.70, < (max_X / 2) + x_Distortion, max_Y, 260.0>,
    0.75, < (max_X / 2) + x_Distortion, max_Y, 280.0>,
    0.80, < (max_X / 2) - x_Distortion, max_Y, 295.0>,
    0.85, < (max_X / 2) + x_Distortion, max_Y, 300.0>,
    0.90, < (max_X / 2) - x_Distortion, max_Y, 340.0>,
    0.95, < (max_X / 2) + x_Distortion, max_Y, 370.0>,
    1.00, < (max_X / 2) - x_Distortion, max_Y, max_Z>
#end

// mostly the same spline as CurvedSpline but with a small y distortion somewhere in the middle ("jump")
#macro CurvedSplineJump(max_X, max_Y, max_Z, x_Distortion)
natural_spline
    0.00, < (max_X / 2) + x_Distortion, 0.0, 0.0>,
    0.05, < (max_X / 2) - x_Distortion, 10.0, 0.0>,
    0.10, < (max_X / 2) - x_Distortion, 25.0, 0.0>,
    0.15, < (max_X / 2) + x_Distortion, 40.0, 0.0>,
    0.20, < (max_X / 2) + x_Distortion, max_Y, 12.0>,
    0.25, < (max_X / 2) + x_Distortion, max_Y, 28.0>,
    0.30, < (max_X / 2) - x_Distortion, max_Y, 50.0>,
    0.35, < (max_X / 2) - x_Distortion, max_Y, 70.0>,
    0.40, < (max_X / 2) + x_Distortion, max_Y, 92.0>,
    0.45, < (max_X / 2) - x_Distortion, max_Y, 120.0>,
    0.50, < (max_X / 2) - x_Distortion, max_Y, 142.0>, 
    0.55, < (max_X / 2) + x_Distortion, max_Y, 190.0>,
    0.60, < (max_X / 2) - x_Distortion, max_Y, 220.0>,
    0.65, < (max_X / 2) + x_Distortion, max_Y, 232.0>,
    0.70, < (max_X / 2) + x_Distortion, max_Y + 3, 260.0>, // jump!
    0.75, < (max_X / 2) + x_Distortion, max_Y, 280.0>,
    0.80, < (max_X / 2) - x_Distortion, max_Y, 295.0>,
    0.85, < (max_X / 2) + x_Distortion, max_Y, 300.0>,
    0.90, < (max_X / 2) - x_Distortion, max_Y, 340.0>,
    0.95, < (max_X / 2) + x_Distortion, max_Y, 370.0>,
    1.00, < (max_X / 2) - x_Distortion, max_Y, max_Z>
#end

// Creates a spline starting at <0,max_y,0>  and then slowly grows up to max_x/2
// but has z-axis distortions with multiplier distortion_grade
#macro TornadoSpline(max_X, max_Y, distortion_grade)
cubic_spline
    -0.05, < 0.0, max_Y, 0.0>,
    0.00, < 0.0, max_Y, 0.0 * distortion_grade>,
    0.05, < 0.05, max_Y, 0.05 * distortion_grade>,
    0.10, < 0.10, max_Y, 0.10 * distortion_grade>,
    0.15, < 0.150, max_Y, 0.12 * distortion_grade>,
    0.20, < 0.20, max_Y, 0.08 * distortion_grade>,
    0.25, < 0.250, max_Y, 0.025 * distortion_grade>,
    0.30, < 0.30, max_Y, -0.03 * distortion_grade>,
    0.35, < 0.350 max_Y, -0.07 * distortion_grade>,
    0.40, < 0.40, max_Y, -0.04 * distortion_grade>,
    0.45, < 0.45, max_Y, -0.01 * distortion_grade>,
    0.50, < max_X / 2, max_Y, 0.0>, 
    0.55, < max_X / 2, max_Y, 0.0>,
    0.60, < max_X / 2, max_Y, 0.0>,
    0.65, < max_X / 2, max_Y, 0.0>,
    0.70, < max_X / 2, max_Y, 0.0>,
    0.75, < max_X / 2, max_Y, 0.0>,
    0.80, < max_X / 2, max_Y, 0.0>,
    0.85, < max_X / 2, max_Y, 0.0>,
    0.90, < max_X / 2, max_Y, 0.0>,
    0.95, < max_X / 2, max_Y, 0.0>,
    1.00, < max_X / 2, max_Y, 0.0>,
    1.05, < max_X / 2, max_Y, 0.0>,
    1.10, < max_X / 2, max_Y, 0.0>,
    1.15, < max_X / 2, max_Y, 0.0>,
    1.20, < max_X / 2, max_Y, 0.0>,
    1.25, < max_X / 2, max_Y, 0.0>,
    1.30, < max_X / 2, max_Y, 0.0>,
    1.35, < max_X / 2, max_Y, 0.0>,
    1.40, < max_X / 2, max_Y, 0.0>,
    1.45, < max_X / 2, max_Y, 0.0>,
    1.50, < max_X / 2, max_Y, 0.0>,
    1.55, < max_X / 2, max_Y, 0.0>
#end

// only xpands in z-direction, plain straight spline
#macro RunawayStraight(x_loc, y_loc, max_Z)
natural_spline
    0.00, <x_loc, y_loc, (max_Z / 20) * 0>,
    0.05, <x_loc, y_loc, (max_Z / 20) * 1>,
    0.10, <x_loc, y_loc, (max_Z / 20) * 2>,
    0.15, <x_loc, y_loc, (max_Z / 20) * 3>,
    0.20, <x_loc, y_loc, (max_Z / 20) * 4>,
    0.25, <x_loc, y_loc, (max_Z / 20) * 5>,
    0.30, <x_loc, y_loc, (max_Z / 20) * 6>,
    0.35, <x_loc, y_loc, (max_Z / 20) * 7>,
    0.40, <x_loc, y_loc, (max_Z / 20) * 8>,
    0.45, <x_loc, y_loc, (max_Z / 20) * 9>,
    0.50, <x_loc, y_loc, (max_Z / 20) * 10>, 
    0.55, <x_loc, y_loc, (max_Z / 20) * 11>,
    0.60, <x_loc, y_loc, (max_Z / 20) * 12>,
    0.65, <x_loc, y_loc, (max_Z / 20) * 13>,
    0.70, <x_loc, y_loc, (max_Z / 20) * 14>, 
    0.75, <x_loc, y_loc, (max_Z / 20) * 15>,
    0.80, <x_loc, y_loc, (max_Z / 20) * 16>,
    0.85, <x_loc, y_loc, (max_Z / 20) * 17>,
    0.90, <x_loc, y_loc, (max_Z / 20) * 18>,
    0.95, <x_loc, y_loc, (max_Z / 20) * 19>,
    1.00, <x_loc, y_loc, (max_Z / 20) * 20>
#end

// this spline is like a spiral in y direction
#macro TornadoUpwardsSpline(x_loc, start_Y, max_Y, z_loc, spiral_radius)
natural_spline
    0.00, <x_loc, start_Y, z_loc>,
    0.05, <x_loc + spiral_radius, start_Y + (max_Y-start_Y) / 20 * 1, z_loc + spiral_radius>,
    0.10, <x_loc - spiral_radius, start_Y + (max_Y-start_Y) / 20 * 2, z_loc + spiral_radius>,
    0.15, <x_loc - spiral_radius, start_Y + (max_Y-start_Y) / 20 * 3, z_loc - spiral_radius>,
    0.20, <x_loc + spiral_radius, start_Y + (max_Y-start_Y) / 20 * 4, z_loc - spiral_radius>,
    0.25, <x_loc + spiral_radius, start_Y + (max_Y-start_Y) / 20 * 5, z_loc + spiral_radius>,
    0.30, <x_loc - spiral_radius, start_Y + (max_Y-start_Y) / 20 * 6, z_loc + spiral_radius>,
    0.35, <x_loc - spiral_radius, start_Y + (max_Y-start_Y) / 20 * 7, z_loc - spiral_radius>,
    0.40, <x_loc + spiral_radius, start_Y + (max_Y-start_Y) / 20 * 8, z_loc - spiral_radius>,
    0.45, <x_loc + spiral_radius, start_Y + (max_Y-start_Y) / 20 * 9, z_loc + spiral_radius>,
    0.50, <x_loc - spiral_radius, start_Y + (max_Y-start_Y) / 20 * 10, z_loc + spiral_radius>, 
    0.55, <x_loc - spiral_radius, start_Y + (max_Y-start_Y) / 20 * 11, z_loc - spiral_radius>,
    0.60, <x_loc + spiral_radius, start_Y + (max_Y-start_Y) / 20 * 12, z_loc - spiral_radius>,
    0.65, <x_loc + spiral_radius, start_Y + (max_Y-start_Y) / 20 * 13, z_loc + spiral_radius>,
    0.70, <x_loc - spiral_radius, start_Y + (max_Y-start_Y) / 20 * 14, z_loc + spiral_radius>, 
    0.75, <x_loc - spiral_radius, start_Y + (max_Y-start_Y) / 20 * 15, z_loc - spiral_radius>,
    0.80, <x_loc + spiral_radius, start_Y + (max_Y-start_Y) / 20 * 16, z_loc - spiral_radius>,
    0.85, <x_loc + spiral_radius, start_Y + (max_Y-start_Y) / 20 * 17, z_loc + spiral_radius>,
    0.90, <x_loc - spiral_radius, start_Y + (max_Y-start_Y) / 20 * 18, z_loc + spiral_radius>,
    0.95, <x_loc - spiral_radius, start_Y + (max_Y-start_Y) / 20 * 19, z_loc - spiral_radius>,
    1.00, <x_loc + spiral_radius, start_Y + (max_Y-start_Y) / 20 * 20, z_loc + spiral_radius> //in the middle again
#end