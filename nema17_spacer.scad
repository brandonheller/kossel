// Spacer for a NEMA17 stepper.
// On Kossel, enables original Grabercars spools, which would otherwise be too long, to fit.

height = 10.0;
width = 42.3;
hole_spacing = 31.0;
hole_diameter = 3.0;
hole_radius = hole_diameter/2;
edge_diameter = 50.0; // Measured size of turned corner of NEMA17.
edge_radius = edge_diameter/2;
center_cutout_diameter = 32;
center_cutout_radius = center_cutout_diameter/2;
cutout_width = 10;

difference() {
	intersection() {
		cube([width, width, height], center=true);
		rotate(0, 90, 0) cylinder(r=edge_radius, h=height*2, center=true, $fn=64);
	}
	for(i = [-1, 1]) {
		for(j = [-1, 1]) {
			translate([i*hole_spacing/2, j*hole_spacing/2, 0]) cylinder(r=hole_radius, h=height*2, center=true, $fn=12);
		}
	}
	rotate(0, 90, 0) cylinder(r=center_cutout_radius, h=height*2, center=true, $fn=64);
	translate([0, 0, height/2]) rotate([0, 90, 0]) cylinder(r=height/2, h=width * 2, $fn=64, center=true);
}
