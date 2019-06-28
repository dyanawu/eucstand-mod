use <MCAD/fasteners/nuts_and_bolts.scad>
use <MCAD/array/mirror.scad>
use <MCAD/array/rectangular.scad>
include <MCAD/units/metric.scad>

include <eucstand_common.scad>

module screwhole ()
{
	mcad_bolt_hole_with_nut (size = screw,
							 length = rest_thi + 10,
							 align_with = "above_head",
							 nut_projection = "radial",
							 bolt_tolerance = 0.1,
							 screw_extra_length = 10,
							 head_extra_length = 5,
							 nut_tolerance = 0.1,
							 nut_projection_length = rest_thi);
}

module rest_outer ()
{
	square ([rest_len, rest_hei]);
}

module rest_cut ()
{
	mcad_array_rectangular ([2, 1], [cut_len + cut, 0], false) {
		hull () {
			mcad_array_rectangular ( [2, 2], [cut_len, cut_hei], false)
				circle (cut_rnd);
		}
	}
}

module rest_main ()
{
	linear_extrude (height = rest_thi) {
		difference () {
			rest_outer ();
			translate ([rest_bor + cut_rnd, rest_bor + cut_rnd]) rest_cut ();
		}
	}
}

module arrange_screwhole ()
{
	mcad_mirror_duplicate (X) {
		translate ([screw_dist / 2, screw / 2])
			screwhole ();
	}
}

module assemble_rest ()
{
translate (X * (-rest_len / 2)) {
	difference () {
		rest_main ();
		translate ([rest_len / 2, rest_thi * 0.75, 0]) {
			arrange_screwhole ();
		}
	}
}
}
