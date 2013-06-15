include <configuration.scad>;

height = 14;
wall_thickness = 2;


difference() {
  cylinder(r=m3_wide_radius+wall_thickness, h=height, $fn=24);
  cylinder(r=m3_wide_radius, h=height, $fn=24);
};