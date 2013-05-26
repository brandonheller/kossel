include <configuration.scad>;
include <tensioner_configuration.scad>;

$fn = 24;

echo("height: ", height);
echo("length: ", length);

big = 100;  // Arbitrary large value, mostly for difference'ing shapes.

// Module is centered to bearing axis and tensioner screw axis.
module tensioner() {
  difference() {
    // Tensioner body
    translate([0, -(vertical_wall_thickness_nut-vertical_wall_thickness_nonut)/2, height/2 - below_screw_height])
      cube([width, length, height], center = true);
    // Cutout for bearings
    translate([0, 0, -big/2 + above_screw_gap])
      cube([width+2*delta, cutout_length, big], center=true);
    // Tensioner screw
    cylinder(r=m3_radius, h=big);
	// Nut trap for tensioner screw
    translate([0, 0, -delta + above_screw_gap]) cylinder(r=m3_nut_radius, h=m3_nut_trap_depth+delta, $fn=6);
    // Bearing screw
    rotate([90, 0, 0]) cylinder(r=m3_radius, h=big, center=true);
	// Nut trap for bearing screw
    translate([0, -cutout_length/2-vertical_wall_thickness_nut+m3_nut_trap_depth]) rotate([90, 0, 0]) cylinder(r=m3_nut_radius, h=m3_nut_trap_depth+delta, $fn=6);
  }
  tensioner();
  %translate([0, cutout_length/2+vertical_wall_thickness_nonut-bearing_screw_len+bearing_screw_offset, 0])
    rotate([-90, 0, 0]) m3_screw(bearing_screw_len);
  %for (i = [1,-1]) {
    translate([0, 0, 0]) rotate([0, 0, 180]) rotate([i*90, 0, 0]) bearing();
  }
}

module m3_screw(thread_len = 16) {
  difference() {
    union() {
      cylinder(r=m3_radius, h=thread_len);
      translate([0, 0, thread_len]) cylinder(r=m3_screw_head_r, h=m3_screw_head_len);
    }
    // Screw hex
    translate([0, 0, thread_len+m3_screw_head_len-m3_screw_head_hex_len]) cylinder(r=m3_screw_head_hex_r, h=big, $fn=6);
  }
}

// f608zz
module bearing() {
  difference() {
    union() {
      cylinder(r=bearing_r, h=bearing_thickness);
      translate([0, 0, bearing_thickness-bearing_flange_thickness]) cylinder(r=bearing_flange_r, h=bearing_flange_thickness);
    }
    cylinder(r=m3_radius, big, center=true);
  }
}

module washer() {
  
}

rotate([0, 0, 90]) rotate([0, 180, 0]) translate([0, 0, -above_screw_height])
    translate([0, 0, 0]) tensioner();