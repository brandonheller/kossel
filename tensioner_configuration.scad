include <configuration.scad>;

m3_nut_trap_depth = 2.4;  // Measured nut height is 2.35
// The below were measured on a SHCS
m3_screw_head_r = 5.50/2;
m3_screw_head_len = 3.00; 
m3_screw_head_hex_r = 2.60/2;
m3_screw_head_hex_len = 1.65;  // Allen head cutout.

// Wall thicknesses
below_screw_thickness = 4;  // Thickness below bearing screw
vertical_wall_thickness_nut = m3_nut_trap_depth+0.25+1.5;
vertical_wall_thickness_nonut = 5.5;
top_wall_thickness = m3_nut_trap_depth+2.0;

// 608zz/f608zz
bearing_thickness = 4;
bearing_r = 5;
bearing_screw_len = 16;
bearing_screw_offset = 0;  // Set this manually to match a real screw size and clear the end microswitch.
bearing_flange_r = 11.5/2;
bearing_flange_thickness = 1;

washer_thickness = 0.4;  // measured
belt_thickness = 1.5;  // GT2 ?

cutout_extra = 0.3;  // Extra space to make it easier to get the washers in.
cutout_length = bearing_thickness*2+washer_thickness*2+cutout_extra;

delta = 0.1;  // Small amount to prevent visual artifacts.

// Amount by which belt/pulley can be tensioned.
// Maybe want to leave extra to handle varying discrete screw lengths.
// In theory, since tightening doubles the pull, and GT2 is 2mm, only 1mm
// should be necessary here to handle open-belt discreteness, plus
// whatever amount a GT2 belt stretches.
gap = 3;

length = cutout_length+vertical_wall_thickness_nut+vertical_wall_thickness_nonut;
width = 12;
below_screw_height = m3_radius/2 + below_screw_thickness;
above_screw_gap = bearing_r + belt_thickness + gap;
above_screw_height = above_screw_gap + top_wall_thickness;
height = above_screw_height + below_screw_height;