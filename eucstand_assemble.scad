use <MCAD/array/mirror.scad>
include <MCAD/units/metric.scad>

use <eucstand_rest.scad>
use <eucstand_wall.scad>
include <eucstand_common.scad>

assemble = 0; // 1 built, 0 flatpack

if (assemble == 1)
{
	mcad_mirror_duplicate (Y) {
		translate (Y * (-rest_len / 2 + wall_thi)) {
			rotate (X * 90) {
				assemble_wall ();
			}
		}
	}

	mcad_mirror_duplicate (X) {
		translate (X * (wall_wid / 2 + rest_thi)) {
			rotate ([90, 0, -90]) {
				assemble_rest ();
			}
		}
	}
}

else
{
	translate (X * -wall_wid * 0.75) {
		assemble_wall ();
	}
	translate ([rest_len * 0.75, 0, rest_thi]) {
		rotate (Y * 180) {
			assemble_rest ();
		}
	}
}
