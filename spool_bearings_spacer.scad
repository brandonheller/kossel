// Insert between two bearings in the vertical spool holder to provide spacing.

height = 10;
or = 11.5/2;
ir = (8.0 + 0.2)/2;

$fn = 32;

delta = 0.1;

module bearing_spacer() {
	difference() {
		cylinder(r = or, h = height);
		cylinder(r = ir, h = height + 2 * delta);
	}
}

bearing_spacer();