$fs = 0.1;
$fa = 1;

xtrans = 50.5;
ytrans = 32.5;

module bit() {
	cylinder(r = 10.5, h = 15);
}

module bar() {
	hull() {
		bit();
		translate([xtrans * 2, 0, 0]) bit();
	}
}

union() {
	translate([-xtrans, ytrans, 0]) {
		#bar();
	}
	import("sidewall_up.stl");
}
