// Small bracket to hold an M8 or 5/16 screw to OpenBeam, to use a horizontal (flat) spool holder on top of a Kossel.

//include <configuration.scad>;

m3_cap_r = (5.5+0.3)/2;  // SHCS cap radius.
m3_cap_h = 3.0 + 0.1;  // SHCS cap height.

thickness = 4.0 + m3_cap_h;  // Go beefy.  Part will be under heavy load.
extrusion_width = 15;
hole_r = 3.0/2 + 0.1;
hole_spacing = 17.5;
num_holes = 3;
length_between_holes = hole_spacing * (num_holes - 1);

screw_edge_gap = 8;  // Space from center of main vertical screw to edge of OpenBeam.  Must clear head.  Half of M8 washer.
screw_hole_r = 8.1/2;  // M8 or 5/16 screw
screw_boss_r = 24.0/2;  // Whatever looks right.
screw_x_offset = extrusion_width/2 + screw_edge_gap;
screw_y_offset = screw_x_offset * 1/sqrt(3); // Not a screw offset, but a placement that yields an inner triangle.

big = 20;
delta = 0.2;

$fn = 64;

module bar() {
	difference() {
		translate([0, 0, thickness/2]) hull() {
			cylinder(r=extrusion_width/2, h=thickness, center=true);
			translate([0, hole_spacing * (num_holes - 1), 0]) cylinder(r=extrusion_width/2, h=thickness, center=true);
		}
		for (i = [0:num_holes-1]) {
			translate([0, i * hole_spacing, -delta]) cylinder(r = hole_r, h = big, $fn=32);
		}
	}
}

module spool_bracket() {
	difference() {
		union() {
			translate([0, 0, 0]) rotate([0, 0, 0])
				bar();
			hull() {
				translate([screw_x_offset, length_between_holes/2, thickness/2])
					cylinder(r=screw_boss_r, h=thickness, center=true);
				translate([0, length_between_holes/2 - screw_y_offset, thickness/2])
					cylinder(r=screw_boss_r, h=thickness, center=true);
				translate([0, length_between_holes/2 + screw_y_offset, thickness/2])
					cylinder(r=screw_boss_r, h=thickness, center=true);			
			}
		}
		for (i = [0:num_holes-1]) {
			translate([0, i * hole_spacing, -delta]) cylinder(r = hole_r, h = big, $fn=32);
			translate([0, i * hole_spacing, thickness - m3_cap_h]) cylinder(r = m3_cap_r, h = m3_cap_h + delta, $fn=32);
		}
		translate([screw_x_offset, length_between_holes/2, thickness/2 - delta])
			cylinder(r=screw_hole_r, h=thickness + 4 * delta, center=true, $fn=32);
		translate([-extrusion_width, 0, 0]) cube([extrusion_width, 100, big], center=true);
	}
}

spool_bracket();