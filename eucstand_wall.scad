use <MCAD/fasteners/nuts_and_bolts.scad>
use <MCAD/array/mirror.scad>
use <MCAD/array/rectangular.scad>
use <MCAD/shapes/2Dshapes.scad>
include <eucstand_rest.scad>
include <MCAD/units/metric.scad>

wall_wid = 160; //don't play wif this
wall_hei = 100;
wall_thi = 22.5;

cut_rad = 45;
cut_len_sm = 45;
cut_len_lg = wall_wid - (cut_rad * 0.5);

module cut ()
{
	translate (Y * cut_rad) {
		hull () {
			mcad_array_rectangular ([2, 1],
									[cut_len_sm, 0],
									center = true) {
				circle (cut_rad, $fn = 360);
			}

			translate ([0, cut_rad * 2]) {
				mcad_array_rectangular ([2, 1],
										[cut_len_lg, 0],
										center = true) {
					circle (cut_rad, $fn = 8);
				}
			}
		}
	}
}


module wall_blank ()
{
	csquare ([wall_wid, wall_hei], center = X);
}

module nuthole ()
{
	mcad_bolt_hole_with_nut (size = screw,
							 length = 25,
							 align_with = "center",
							 nut_projection = "radial",
							 screw_extra_length = 30,
							 head_extra_length = 5,
							 bolt_tolerance = 0.1,
							 nut_tolerance = 0.1,
							 nut_projection_length = 30);
}

module arrange_nuthole () {
	mcad_mirror_duplicate (X) {
		translate ([wall_wid / 2, rest_thi * 0.75 + screw / 2, rest_thi * 0.75]) {
		rotate (Y * -90) 
			nuthole ();
	}
}
}

module assemble_wall ()
{
	difference () {
		union () {
			linear_extrude (height = wall_thi) {
				difference () {
					wall_blank ();
					translate ([0, wall_thi]) {
						cut ();
					}
				}
			}
		}
			#arrange_nuthole ();
	}
}
	
translate ([-80, 0, 0]) assemble_wall ();
translate ([50, 0, 0]) assemble_rest();
