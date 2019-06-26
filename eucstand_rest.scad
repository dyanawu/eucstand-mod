include <eucstand_shared.scad>

module rest_outer ()
{
/*	rest_pts = [
	[0, 0],
	[rest_len_bt, 0],
	[rest_len_tp + rest_off, rest_hei],
	[rest_off, rest_hei]
	];

	polygon (rest_pts);
*/

	square ([rest_len, rest_hei]);
}

module rest_cut ()
{
	mcad_array_rectangular ([2, 1], [cut_len + cut, 0], false) {
		hull () {
			mcad_array_rectangular ( [2, 2], [cut_len, cut_hei], false)	circle (cut_rnd);
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

module screwholes ()
{
	mcad_mirror_duplicate (X) {
		translate ([screw_dist / 2, 0]) 
			mcad_bolt_hole_with_nut ( size = 6,
									  length = 30,
									  align_with = "above_head",
									  nut_projection = "radial",
									  screw_extra_length = 10,
									  head_extra_length = 5,
									  nut_projection_length = rest_thi);
	}
}

module assemble_rest ()
{
	difference () {
		rest_main ();

		translate ([rest_len / 2, rest_thi * 0.75, 0]) {
			#screwholes();
		}
	}
}

assemble_rest();
