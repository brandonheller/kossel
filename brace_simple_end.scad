// Simple end for a Kossel brace using OpenBeam parts in an X shape
brace_circle_dia = 21; // mm
brace_circle_r = brace_circle_dia / 2;
hole_dia = 3.0 + 0.2; //mm
hole_r = hole_dia / 2;
thickness = 3;
centerhole_to_ob_edge = 16.5; // calculated from (diagonal - gap) / 2
rect_len = centerhole_to_ob_edge + 30;
ob_edge_hole_offset = 7.5;  //mm, offset from edge of OpenBeam to first hole
rect_width = 15; //mm
delta = 10; //mm
rect_fillet_r = 3;

$fn=64;

difference() {
	union() {
		// Main circle
		cylinder(r=brace_circle_r, h=thickness);
		// Extension
		//translate([0, -rect_width/2, 0]) cube([rect_len, rect_width, thickness]);
		translate([rect_fillet_r, -rect_width/2 + rect_fillet_r, 0]) minkowski()
		{
			cube([rect_len - 2 * rect_fillet_r,rect_width - 2 * rect_fillet_r, thickness/2]);
			cylinder(r=rect_fillet_r,h=thickness/2);
		}
	}
	// Holes
	// Center hole
	cylinder(r=hole_r, h=thickness + delta * 2, center=true);
	// Holes for attaching brace to OpenBeam
	for (i = [0, 15]) {
		translate([centerhole_to_ob_edge + i + ob_edge_hole_offset, 0, 0]) cylinder(r=hole_r, h=thickness + 2 * delta, center=true);	
	}
}