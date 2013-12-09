use <effector_open.scad>
use <groove_mount.scad>
use <probe_top.scad>
use <microswitch.scad>;

height = 8;

groove_mount_thickness = 6;
hotend_len = 50;
height = 8;

module hotend() {
	cylinder(r=8, h=hotend_len);
}

red = [1.0, 0, 0];
trans_red = [1.0, 0, 0, 0.5];
trans_white = [1, 1, 1, 0.5];
trans_black = [0, 0, 0, 0.9];

color(trans_white) translate([0, 0, height/2]) effector_open();
color(trans_red) translate([0, 0, height/2 + groove_mount_thickness + 1]) groove_mount();
color(red) translate([0, 0, height/2 + groove_mount_thickness + 1 + height - 1]) rotate([180,0,0]) probe_top();

translate([0, 0, -hotend_len + height + height + 3]) color([0,0,0,0.5]) translate([0,0,0]) hotend();

%translate([0, 19, 16]) rotate([180, 0, 0]) microswitch();