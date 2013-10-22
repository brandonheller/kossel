// Simple triangular bracket for attaching bars to Kossel triangles ... or anything else, really.

include <configuration.scad>;

thickness = 4.0;

extrusion_width = 15;
hole_r = m3_radius;
hole_spacing = 17.5;
num_holes = 3;

big = 20;
delta = 0.1;

module bar() {
	difference() {
		translate([0, 0, thickness/2]) hull() {
			cylinder(r=extrusion_width/2, h=thickness, center=true);
			translate([0, hole_spacing * (num_holes - 1), 0]) cylinder(r=extrusion_width/2, h=thickness, center=true);
		}
		for (i = [0:num_holes-1])
			translate([0, i * hole_spacing, -delta]) cylinder(r = hole_r, h = big, $fn=32);
	}
}

module triangle_bracket() {
	union() {
		translate([0, 0, 0]) rotate([0, 0, 0])
			bar();
		translate([0, 0, 0]) rotate([0, 0, -60])
			bar();
		translate([0, hole_spacing * (num_holes - 1), 0]) rotate([0, 0, -120])
			bar();
	}
}

triangle_bracket();