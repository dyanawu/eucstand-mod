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
rest_thi = 15;
rest_bor = 20;

cut = rest_bor * 2;
cut_rnd = 10;
cut_len = (rest_len / 2) - (rest_bor * 1.5) - (cut_rnd * 2);
cut_hei = rest_hei - cut - (cut_rnd * 2);

//lenfactor = 
//heifactor = 

screw = 5;
screw_dist = rest_len - cut + screw;
