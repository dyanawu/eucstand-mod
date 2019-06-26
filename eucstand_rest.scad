use <MCAD/fasteners/nuts_and_bolts.scad>
use <MCAD/array/mirror.scad>
use <MCAD/array/rectangular.scad>
include <MCAD/units/metric.scad>

// eucguy's existing stand example STLs
//translate ([80,0,0]) import ("eg_frame_closed.stl");
//import ("eg_sidewall_down.stl");
//#translate ([0,84.5,0]) import ("eg_sidewall_up.stl");

/*
  rest
  wid = 180
  hei = 170 // could be a little shorter for S5
  thi = 15
*/

/*
  wall
  wid = 160 - crucial, this is space between inners of side walls
  hei = 80
  thi = 20
*/

rest_len = 200;
rest_hei = 130;
rest_thi = 17;
rest_bor = 20;

cut = rest_bor * 2;
cut_rnd = 10;
cut_len = (rest_len / 2) - (rest_bor * 1.5) - (cut_rnd * 2);
cut_hei = rest_hei - cut - (cut_rnd * 2);

screw = 5;
screw_dist = rest_len - rest_bor - screw;

module screwhole ()
{
	mcad_bolt_hole_with_nut ( size = 6,
							  length = 30,
							  align_with = "above_head",
							  nut_projection = "radial",
							  screw_extra_length = 10,
							  head_extra_length = 5,
							  nut_projection_length = rest_thi);
}

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

module arrange_screwhole () {
	mcad_mirror_duplicate (X) {
		translate ([screw_dist / 2, screw / 2])
			screwhole ();
			}
	}

module assemble_rest ()
{
	difference () {
		rest_main ();

		translate ([rest_len / 2, rest_thi * 0.75, 0]) {
			#arrange_screwhole ();
		}
	}
}

//assemble_rest();
