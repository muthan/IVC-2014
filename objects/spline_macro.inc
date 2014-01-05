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

// Creates a spline starting at <0,max_y,0>  and then slowly grows up to max_x/2
// but has z-axis distortions with multiplier distortion_grade
#macro TornadoSpline(max_X, max_Y, distortion_grade)
natural_spline
    0.00, < 0.0, max_Y, 0.0 * distortion_grade>,
    0.05, < 0.05, max_Y, 0.05 * distortion_grade>,
    0.10, < 0.10, max_Y, 0.10 * distortion_grade>,
    0.15, < 0.150, max_Y, 0.03 * distortion_grade>,
    0.20, < 0.20, max_Y, 0.04 * distortion_grade>,
    0.25, < 0.250, max_Y, -0.02 * distortion_grade>,
    0.30, < 0.30, max_Y, -0.03 * distortion_grade>,
    0.35, < 0.350 max_Y, -0.05 * distortion_grade>,
    0.40, < 0.40, max_Y, 0.0 * distortion_grade>,
    0.45, < 0.45, max_Y, 0.05 * distortion_grade>,
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
    1.00, < max_X / 2, max_Y, 0.0>
#end