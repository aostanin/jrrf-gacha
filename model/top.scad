include <params.scad>

alpha = 0.6;

module corner() {
  cube([6 + alpha, 6 + alpha, wall_t]);

  s = 6;
  screw_d = 3;
  translate([s / 2, s / 2, wall_t])
    linear_extrude(wall_t)
      circle(d=screw_d);
}

module top() {
  translate([0, 0, size.z - 2 * wall_t]) {
    difference() {
      translate([0, wall_t, 0])
        cube([size.x, size.y - wall_t, 2 * wall_t]);

      cube([size.x, wall_t + alpha, wall_t]);
      cube([wall_t + alpha, size.y, wall_t]);
      translate([0, size.y - wall_t - alpha, 0])
        cube([size.x, wall_t + alpha, wall_t]);
      translate([size.x - wall_t - alpha, 0, 0])
        cube([wall_t + alpha, size.y, wall_t]);

      // Corners
      translate([wall_t, wall_t, 0])
        corner();
      translate([size.x - wall_t, wall_t, 0])
        rotate([0, 0, 90])
          corner();
      translate([wall_t, size.y - wall_t, 0])
        rotate([0, 0, -90])
          corner();
      translate([size.x - wall_t, size.y - wall_t, 0])
        rotate([0, 0, 180])
          corner();

      translate([size.x - 2 * wall_t - capsule_hole_d / 2, 2 * wall_t + capsule_hole_d / 2, 0]) {
        // Capsule hole
        linear_extrude(2 * wall_t)
          circle(d=capsule_hole_d);
      }
    }

    translate([size.x - 2 * wall_t - capsule_hole_d / 2, 2 * wall_t + capsule_hole_d / 2, 2 * wall_t]) {
      linear_extrude(hose_clamp_h)
        difference() {
          circle(d=hose_id);
          circle(d=capsule_hole_d);
        }
      translate([0, 0, hose_clamp_h])
        linear_extrude(hose_clamp_h)
          difference() {
            circle(d=hose_id - 1);
            circle(d=capsule_hole_d);
          }
      translate([0, 0, 2 * hose_clamp_h])
        linear_extrude(hose_clamp_h)
          difference() {
            circle(d=hose_id);
            circle(d=capsule_hole_d);
          }
    }
  }
}

top();
