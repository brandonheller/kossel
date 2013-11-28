use <effector_open.scad>
use <groove_mount.scad>
use <probe_top.scad>

height = 8;

groove_mount_thickness = 6;
hotend_len = 50;
height = 8;

module hotend() {
	cylinder(r=8, h=hotend_len);
}

translate([0, 0, height/2]) effector_open();
translate([0, 0, height/2 + groove_mount_thickness + 1]) groove_mount();
translate([0, 0, height/2 + groove_mount_thickness + 1 + height - 1]) rotate([180,0,0]) probe_top();

translate([0, 0, -hotend_len + height + height + 3]) color([0,0,0,0.5]) translate([0,0,0]) hotend();