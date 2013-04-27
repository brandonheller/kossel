// Center of cross-brace for Kossel using OpenBeam.


ob_width = 15; //mm
ob_len = 30;
ob_gap = 11;
ext_len = ob_gap + ob_len;
thickness = 3;
hole_dia = 3.0 + 0.2; //mm
hole_r = hole_dia / 2;
delta = 0.1;
cyl_dia = 32; // mm
cyl_r = cyl_dia / 2;
rect_fillet_r = 3;

cross_angle = 56.59;

$fn=64;

difference() {
	union() {
		// Main X
		for (i = [-1, 1]) {
			for (j = [-1, 1]) {
				scale([j, 1, 1]) rotate([0, 0, i * cross_angle]) 
					translate([rect_fillet_r, -ob_width/2 + rect_fillet_r, 0]) minkowski()
					{
						cube([ext_len - 2 * rect_fillet_r,ob_width - 2 * rect_fillet_r, thickness/2]);
						cylinder(r=rect_fillet_r,h=thickness/2);
					}
					// Simple rect:
//					translate([0, -ob_width / 2, 0])
//					cube([ext_len, ob_width, thickness]);
			}
		}
		// Added center material for strength
		cylinder(r=cyl_r, h=thickness);
	}
	union() {
		// Holes
		for (i = [-1, 1]) {
			for (j = [-1, 1]) {
				for (k = [0, 1]) {
					scale([j, 1, 1]) rotate([0, 0, i * cross_angle])
						translate([ob_gap + 7.5 + 15 * k,0,-thickness /2]) 
							cylinder(r=hole_r, h=thickness * 2 + delta);
				}
			}
		}
		
	}
}