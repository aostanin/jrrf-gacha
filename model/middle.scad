include <params.scad>

angle = -0;
// angle = -55;

module shaft() {
  linear_extrude(shaft_l) {
    difference() {
      circle(d=shaft_d);
      translate([shaft_d / 2 - (shaft_d - shaft_flat), -shaft_d / 2])
        #square([shaft_d - shaft_flat, shaft_d]);
    }
  }
}

module middle() {
  translate([wall_t + motor_body / 2, wall_t + motor_body / 2, plate_h]) {
    rotate([0, 0, angle]) {
      // Shaft
      difference() {
        union() {
          linear_extrude(shaft_l)
            circle(r=motor_body / 2 - 5);
          translate([0, 0, shaft_l])
            sphere(r=motor_body / 2 - 5);
        }
        shaft();
      }

      // Case
      translate([-wall_t - motor_body / 2, -wall_t - motor_body / 2, -plate_h])
        translate([size.x - capsule_hole_d - wall_t, 0, 0])
          cube([capsule_hole_d + wall_t, wall_t, size.z]);

      // Plate
      plate_r = size.x - 2 * wall_t - motor_body / 2 - 5;
      difference() {
        union() {
          linear_extrude(shaft_l)
            circle(r=plate_r);
          translate([0, 0, 0])
            linear_extrude(shaft_l)
              intersection() {
                translate([-wall_t - motor_body / 2, -wall_t - motor_body / 2])
                  translate([size.x - 2 * wall_t - capsule_hole_d / 2, 2 * wall_t + capsule_hole_d / 2])
                    difference() {
                      circle(d=capsule_hole_d + 4 * wall_t);
                    }
                circle(r=plate_r);
              }
        }
        translate([0, 0, 0])
          linear_extrude(shaft_l) {
            circle(d=shaft_d);
            translate([-plate_r, -plate_r])
              square([plate_r - motor_body / 2 + 5, 2 * plate_r]);
            translate([-plate_r, -plate_r])
              square([plate_r, plate_r]);
            difference() {
              translate([0, -plate_r])
                square([plate_r, plate_r]);
              translate([-wall_t - motor_body / 2, -wall_t - motor_body / 2])
                translate([size.x - 2 * wall_t - capsule_hole_d / 2, 2 * wall_t + capsule_hole_d / 2]) {
                  circle(d=capsule_hole_d + 4 * wall_t);
                  translate([0, -capsule_hole_d / 2 - 2 * wall_t])
                    square([capsule_hole_d / 2, capsule_hole_d / 2]);
                }
            }

            translate([-wall_t - motor_body / 2, -wall_t - motor_body / 2])
              translate([size.x - 2 * wall_t - capsule_hole_d / 2, 2 * wall_t + capsule_hole_d / 2]) {
                circle(d=capsule_hole_d);
                translate([0, -capsule_hole_d / 2])
                  square([capsule_hole_d / 2, capsule_hole_d / 2]);
              }
          }
      }
    }
  }
}

middle();
