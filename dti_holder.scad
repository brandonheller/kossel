// Effector Cup
// This part shares dimensions with effector.scad in Johann's Kossel repo:
// git://github.com/jcrocholl/kossel.git

include <config.scad>;

hotend_radius = 8.1;  // Hole for the hotend (J-Head diameter is 16mm).
push_fit_height = 4;  // Length of brass threaded into printed plastic.
height = 8;

delta = 0.1;

dti_center_to_body_edge = 9.6;
dti_gauge_edge_to_body = 2.55; // offset; gauge sticks out

main_width = 20; // width of mount when looking at the dti body
main_thickness = 16; // depth of mount when looking at the dti body
main_length = 10;  // doesn't matter; gets chopped by body cutout

dti_body_to_flange_edge = 17.8; //
dti_flange_len = 17.5; // 

dti_flange_thickness = 5.2 + 0.0;

dti_body_r = 53.45 / 2;
dti_gauge_face_r = 58.00 / 2;
dti_plunger_r = (8.0 + 2.0)/2;

dti_gauge_edge_to_plunger_center = 6.2;  
dti_plunger_center_to_body_cyl_edge = 10.3;  // in x
dti_gauge_front_to_plunger_center = 12.7;

dti_gauge_top_to_body_cyl = 3.0; // in z
dti_body_cyl_len = 15.5;

m3_r = (3.0 + 0.1)/2; // size of mount hole in flange
m3_thread_form_r = (2.7) / 2;

plunger_to_mount_rear = main_thickness + dti_plunger_center_to_body_cyl_edge;

// Length below top flange, to bottom of mount
bottom_length = dti_gauge_top_to_body_cyl + dti_body_r + (dti_flange_len/2);

module effector_cup() {
	difference() {
		union() {
			// Main body flange
			cylinder(r=effector_body_r, h=height, $fn=64);
			// Main front body
			// front side
			translate([0, -main_width/2, -main_length])
				cube([dti_gauge_front_to_plunger_center, main_width, main_length]);
			// back side
			translate([-plunger_to_mount_rear, -main_width/2, -bottom_length])
				cube([plunger_to_mount_rear, main_width, bottom_length]);
			// back side upper
			translate([-plunger_to_mount_rear, -main_width/2, 0])
				cube([plunger_to_mount_rear, main_width, height]);				
		}
		// Cutout for plunger
		translate([0, 0, -delta]) cylinder(r=dti_plunger_r, h=height + delta*2, $fn=64);
		translate([0, 0, -100]) cylinder(r=dti_plunger_r, h=100, $fn=64);

		// Cutout for dti flange
		translate([dti_gauge_edge_to_plunger_center, 0, -(dti_gauge_face_r) -delta])
			rotate([0, 90, 0])
				cylinder(r=dti_gauge_face_r, h = dti_body_cyl_len, $fn=128);

		// Cutout for main dti body	
		translate([-dti_plunger_center_to_body_cyl_edge, 0, -(dti_gauge_top_to_body_cyl + dti_body_r)])
			rotate([0, 90, 0])
				cylinder(r=dti_body_r, h = dti_body_cyl_len + 2, $fn=128);

		// Slit for dti flange
		translate([-delta-dti_body_to_flange_edge-dti_plunger_center_to_body_cyl_edge, -dti_flange_thickness/2, -dti_flange_len-(dti_gauge_top_to_body_cyl + dti_body_r - (dti_flange_len/2)) - delta]) cube([2*delta + dti_body_to_flange_edge, dti_flange_thickness, dti_flange_len + delta]);

		// DTI mounting hole
		// open hole on one side
		translate([-(dti_plunger_center_to_body_cyl_edge + (dti_flange_len / 2)), 0, -(dti_body_r + dti_gauge_top_to_body_cyl)]) rotate([90, 0, 0]) cylinder(r=m3_r, h = 25, $fn=32);
		// hole for forming an m3 hole on other side
		translate([-(dti_plunger_center_to_body_cyl_edge + (dti_flange_len / 2)), 25, -(dti_body_r + dti_gauge_top_to_body_cyl)]) rotate([90, 0, 0]) cylinder(r=m3_thread_form_r, h = 25, $fn=32);

		// Clearance for flange fillets (position/size fudged)
		translate([-dti_plunger_center_to_body_cyl_edge, 0, -(dti_gauge_top_to_body_cyl + dti_body_r - (dti_flange_len/2))]) rotate([0, 180, 0])
			cylinder(r=5, h = 100, $fn=32);
		translate([-dti_plunger_center_to_body_cyl_edge, 0, -(dti_gauge_top_to_body_cyl + dti_body_r - (dti_flange_len/2))]) rotate([90, 0, 0])
			sphere(r=5, fn=32, center=true, $fn=32);

		// Mounting holes
		for (a = [0:60:359]) rotate([0, 0, a]) {
	 		translate([0, mount_radius, -delta - 2]) cylinder(r=m3_thread_form_r, h=height+2*delta + 2, $fn=24);
	  	}
	}
}

effector_cup();