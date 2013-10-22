// Holds two spools in a vertical position.  Meant to be a tight slip or mild press fit into 608 bearings.

bearing_ir = (22 + 0.15)/2;
bearing_h = 7;

spacer_height = 15;

flange_r = 70/2;
// Spool diameters:
spool_dia_matterhackers = 31.75 - 0.18;
spool_dia_protoparadigm = 52 - 0.18;
spool_r_big = spool_dia_protoparadigm/2;
spool_r_small = spool_dia_matterhackers/2;

inner_h = (2 * bearing_h) + spacer_height - 1.5;  // Height at which taper begins.
inner_r = bearing_ir - 2;

lip_thickness = 4;
step_thickness = 2;

overhang = bearing_ir - inner_r;
overhang_height = 4;

$fn = 64;

echo("inner_h", inner_h);

difference() {
	rotate_extrude() {
		polygon( [   [bearing_ir, 0],
			    		[bearing_ir, inner_h],
					[inner_r, inner_h + overhang],
					[inner_r, inner_h + overhang + overhang_height],
					[bearing_ir + 1.5, inner_h + overhang + overhang_height],
					[spool_r_small, inner_h + overhang - 4],
					[spool_r_small, step_thickness + lip_thickness],
					[spool_r_big, step_thickness + lip_thickness],
					[spool_r_big, lip_thickness],
					[flange_r, lip_thickness],
					[flange_r, 0]
				 ] );
	}
	// uncomment below to generate a cutaway view
	//translate([0, 0, -1]) cube([50, 50, 100]);
}