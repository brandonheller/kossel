include <configuration.scad>;

slot_radius = 6.25; // half of the slot width
mount_radius = 12.5;
mount_width = 40;
mount_length = 28;
mount_thickness = 5.6;

$fn = 40;

difference() {
  cube([mount_width, mount_length, mount_thickness], center=true);
  translate([mount_radius,0,0]) cylinder(r=m3_wide_radius, h=mount_thickness, center=true);
  translate([-mount_radius,0,0]) cylinder(r=m3_wide_radius, h=mount_thickness, center=true);
  cylinder(r=slot_radius, h=mount_thickness, center=true);
  translate([0, -mount_length/4, 0]) cube([2*slot_radius, mount_length/2, mount_thickness], center=true);
};