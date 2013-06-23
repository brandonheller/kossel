include <configuration.scad>;

belt_width = 6;
belt_thickness = 1.0;
belt_pitch = 2.0;
tooth_radius = 0.6;
path_height = belt_width + 2;

clamp_width = 15;
clamp_length = 15;
clamp_base = 4;
clamp_thickness = path_height+clamp_base;

$fn = 40;

clamp_inside_radius = clamp_width/2;
clamp_outside_radius = clamp_inside_radius+belt_thickness;
dTheta_inside = belt_pitch/clamp_inside_radius;
dTheta_outside = belt_pitch/clamp_outside_radius;
pi = 3.14159;

difference() {
  cube([clamp_width, clamp_length, clamp_thickness]);

  // Belt paths
  difference() {
    translate([0,0,clamp_base]) cylinder(h=path_height,r=clamp_outside_radius);
    translate([0,0,clamp_base]) cylinder(h=path_height,r=clamp_inside_radius);
  }
  difference() {
    translate([clamp_width,clamp_length,clamp_base]) cylinder(h=path_height,r=clamp_outside_radius);
    translate([clamp_width,clamp_length,clamp_base]) cylinder(h=path_height,r=clamp_inside_radius);
  }

  // Belt teeth
  for (theta = [0:dTheta_inside:pi/2]) {
    translate([clamp_inside_radius*cos(theta*180/pi),clamp_inside_radius*sin(theta*180/pi),clamp_base]) cylinder(r=tooth_radius, h=path_height);
  }
  for (theta = [0:dTheta_outside:pi/2]) {
    translate([clamp_width-clamp_outside_radius*cos(theta*180/pi),clamp_length-clamp_outside_radius*sin(theta*180/pi),clamp_base]) cylinder(r=tooth_radius, h=path_height);
  }


};