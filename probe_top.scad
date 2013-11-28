// Effector Cup
// This part shares dimensions with effector.scad in Johann's Kossel repo:
// git://github.com/jcrocholl/kossel.git

include <config.scad>;

hotend_radius = 8.1;  // Hole for the hotend (J-Head diameter is 16mm).
push_fit_height = 4;  // Length of brass threaded into printed plastic.
height = 8;

hinge_width = 12-0.5;
hinge_len = 13;
hinge_len_upper = 6;
hinge_radius = 20; // XY Dist from center to hinge center
hinge_extent = hinge_radius + hinge_len_upper/2; // Dist from center to edge of hinge 
hinge_height = 17 + height/2;

countersink_l = 1.5;
countersink_h = 30;

module probe_top() {
	intersection() {
		// Round top edge
		translate([0, 0, -height/2 - delta]) cylinder(r=effector_body_r - countersink_l, r2=effector_body_r - countersink_l + countersink_h, h = countersink_h, $fn=64);
		difference() {
			union() {
				// Main body
				cylinder(r=effector_body_r, h=height, center=true, $fn=64);
				// Hinge attachment
				translate([0, hinge_extent - hinge_len_upper/2, hinge_height/2 - height/2]) cube([hinge_width, hinge_len_upper, hinge_height], center=true);
				translate([0, 16, 5]) rotate([-45, 0, 0]) cube([hinge_width, hinge_len_upper, 13], center=true);
			}
			// Cutout for hotend
			translate([0, 0, push_fit_height-height/2]) cylinder(r=hotend_radius, h=height, $fn=64);
			// Screw cutout
			translate([0, 0, -6]) import("m5_internal.stl");
			// Mounting holes
			for (a = [0:60:359]) rotate([0, 0, a]) {
		 		translate([0, mount_radius, 0]) cylinder(r=m3_r, h=3*height, center=true, $fn=24);
		  	}
			// Hole for hinge
			translate([-25, hinge_extent - hinge_len_upper/2, hinge_height - hinge_len_upper/2 - height/2]) rotate([0, 90, 0]) cylinder(r=1.5, h=50, $fn=16);
			// Trim edge
			translate([0, 32, 5]) rotate([-45, 0, 0]) cube([hinge_width + 2 * delta, hinge_len_upper + 2 * delta, 50], center=true);
		}
	}
}

probe_top();