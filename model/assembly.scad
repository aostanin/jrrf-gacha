include <params.scad>
use <top.scad>
use <middle.scad>
use <bottom.scad>

top();
middle();
bottom();

translate([size.x - 2 * wall_t - capsule_hole_d / 2, 2 * wall_t + capsule_hole_d / 2, wall_t + capsule_d / 2])
  sphere(d=capsule_d);

// translate([size.x - 2 * wall_t - capsule_hole_d / 2, -5, wall_t + capsule_d / 2])
// sphere(d=capsule_d);
