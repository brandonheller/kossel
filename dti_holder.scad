thickness = 4.5;
dti_holder_height = 20;
dti_dia = 9.54 + 0.1;
dti_holder_thickness = 3;
delta = 0.01;
arms = 3;
arm_height = 8;
spacing = 50;
arm_width = 12;
m3_dia = 3.1;
m3_nut_dia = 6.2 + 0.45; // for m3 screw - this is the dist across corners.
m3_clearance_dia = 7;
m3_nut_thickness = 2.4;
screw_dia_tighten = 0.01; // in inches
screw_dia = (.107 + screw_dia_tighten) * 25.4; // set to tap size.  Here: 6-32 tap drill size.  // Was: 2.4mm for m3.
main_cyl_dia = 21;

intersection() {
	difference() {
		union() {
			// main body
			cylinder(r=main_cyl_dia/2, h=arm_height, $fn=40);
			// boss for dti
			cylinder(r=dti_dia/2 + dti_holder_thickness, h=dti_holder_height, $fn=40);
			for (i =[0:360/arms:359]) {
				// Arms
				rotate([0, 0, i]) translate([-spacing/4, 0, arm_height/2]) cube([spacing/2, arm_width, arm_height], center=true);
				// Rounded ends of arms
				rotate([0, 0, i]) translate([-spacing/2, 0, 0]) cylinder(r=arm_width/2, h=thickness, $fn=12);
			}
		}
		for (i =[0:360/arms:359]) {
			// m3 holes
			rotate([0, 0, i]) translate([-spacing/2, 0, -delta]) cylinder(r=m3_dia/2, h=thickness + 2 * delta, $fn=12);
			// nut holes
			rotate([0, 0, i]) translate([-spacing/2, 0, thickness - m3_nut_thickness]) cylinder(r=m3_nut_dia/2, h=m3_nut_thickness + delta, $fn=6);
		}
		// Hole for DTI
		translate([0, 0, -delta]) cylinder(r=dti_dia/2, h=dti_holder_height + 2 * delta, $fn=40);
		// Hole for screw to secure DTI
		translate([0, 0, (arm_height + dti_holder_height)/2]) rotate([-90, 0, 90]) cylinder(r=screw_dia/2, h = spacing * 2, center=true, $fn=12);
	}
	// Bounding shape
	union() {
		// Cutout to get angled arms
		translate([0, 0, thickness]) cylinder(r1=spacing/2 - m3_clearance_dia/2, r2 = dti_dia/2 + dti_holder_thickness, h=arm_height - thickness);
		cylinder(r=dti_holder_thickness + dti_dia/2, h=dti_holder_height + delta);
		cylinder(r=spacing/2 + 10, h=thickness);
	}
}

