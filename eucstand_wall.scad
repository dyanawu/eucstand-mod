use <MCAD/fasteners/nuts_and_bolts.scad>
use <MCAD/array/mirror.scad>
use <MCAD/array/rectangular.scad>
use <MCAD/shapes/2Dshapes.scad>
include <MCAD/units/metric.scad>

include <eucstand_common.scad>

module wallcut ()
{
	translate (Y * wallcut_rad) {
		hull () {
			mcad_array_rectangular ([2, 1],
									[wallcut_len_sm, 0],
									center = true) {
				circle (wallcut_rad, $fn = 360);
			}

			translate ([0, wallcut_rad * 2]) {
				mcad_array_rectangular ([2, 1],
										[wallcut_len_lg, 0],
										center = true) {
					circle (wallcut_rad, $fn = 8);
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
							 length = rest_thi * 1.5,
							 align_with = "center",
							 nut_projection = "radial",
							 screw_extra_length = 30,
							 head_extra_length = 5,
							 bolt_tolerance = 0.1,
							 nut_tolerance = 0.1,
							 nut_projection_length = wall_thi);
}

module arrange_nuthole () {
	mcad_mirror_duplicate (X) {
		translate ([wall_wid / 2, rest_thi * 0.75 + screw / 2, wall_thi / 2 - screw / 2]) {
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
					translate ([0, wall_bot]) {
						wallcut ();
					}
				}
			}
		}
		arrange_nuthole ();
	}
}
