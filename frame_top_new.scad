include <configuration.scad>;
include <tensioner_configuration.scad>;

use <vertex.scad>;
use <tensioner.scad>;
use <endstop.scad>;

$fn = 24;

// Width of bar used to hold tensioning screw.
bar_width = 15;
bar_thickness = thickness;

// Kossel Pro and Mini ball rails equivalent to HIWIN Model MGN 12H:
// http://hiwin.com/html/extras/mgn-c_mgn-h.html
// Distance from ball rail attachment plane to outer face of slider, marked H.
ball_rail_H = 13;

// Thickness of the printed carriage.
carriage_thickness = 6;

belt_width = 6; // GT2

// By moving the belt out, we can get a bit more space to clear the endstop screws.
extra_gap = 0.0;

// TODO: remove this
// Distance from center of vertical extrusion to center of tensioning screw.
//hole_offset = extrusion/2+thickness+tensioner_gap+length/2;
hole_offset = extrusion/2+ball_rail_H+carriage_thickness+belt_width/2+extra_gap;

echo("hole offset past extrusion", hole_offset - extrusion/2);

module frame_top() {
  difference() {
    union() {
        vertex(extrusion, idler_offset=0, idler_space=100);
        // Bar to hold tensioning screw.
	    translate([-bar_width/2, extrusion/2+1, -extrusion/2]) cube([bar_width, 34, bar_thickness]);
    }
    // Hole for tensioner.
    translate([0, hole_offset, -extrusion]) cylinder(r=m3_radius, h=extrusion*3);
    // Slot for tensioner bearing screw.
    hull() {
      translate([0, 50, 9]) rotate([90, 0, 0]) cylinder(r=m3_screw_head_r+1, h=20);
      translate([0, 50, 9+gap+2]) rotate([90, 0, 0]) cylinder(r=m3_screw_head_r+1, h=20);
    }
  }
}

translate([0, 0, extrusion/2]) frame_top();

%translate([0, 4.3+extrusion/2, 23]) rotate([180, 0, 0]) endstop();

%translate([0, hole_offset, above_screw_height+thickness]) rotate([0, 180, 0]) tensioner();