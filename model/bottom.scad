include <params.scad>

module lid_hole() {
  s = 6;
  screw_h = 10;
  screw_d = 3;
  start_h = size.z - 2 * screw_h;
  h = size.z - wall_t;

  difference() {
    translate([0, 0, h - screw_h])
      linear_extrude(screw_h)
        square(s, s);

    translate([s / 2, s / 2, h - screw_h])
      linear_extrude(screw_h)
        circle(d=screw_d);
  }

  translate([0, 0, start_h])
    linear_extrude(h - screw_h - start_h, scale=s / 0.1)
      square([0.1, 0.1]);
}

module bottom() {
  // Case
  difference() {
    cube([size.x, size.y, size.z]);
    translate([wall_t, wall_t, wall_t])
      cube([size.x - 2 * wall_t, size.y - 2 * wall_t, size.z - 2 * wall_t]);
    translate([0, wall_t, size.z - wall_t])
      cube([size.x, size.y - wall_t, wall_t]);
    translate([size.x - capsule_hole_d - 2 * wall_t, 0, size.z - wall_t])
      cube([capsule_hole_d + 2 * wall_t, wall_t, wall_t]);

    translate([size.x - capsule_hole_d - 2 * wall_t, 0, 0])
      cube([capsule_hole_d + wall_t + wall_t, wall_t, size.z - wall_t]);
    translate([size.x - capsule_hole_d - 2 * wall_t - 15, 0, plate_h - wall_t])
      cube([15, wall_t, shaft_l + 2 * wall_t]);

    translate([wall_t, size.y - wall_t, wall_t])
      cube([usb_cutout_size.x, wall_t, usb_cutout_size.y]);
  }

  // Motor mount
  translate([wall_t, wall_t, wall_t + motor_body_h]) {
    linear_extrude(wall_t)
      difference() {
        square(motor_body);

        translate([motor_body / 2, motor_body / 2]) {
          // Center cutout
          circle(d=motor_body_hole_d);
          translate([0, -motor_body_hole_d / 2])
            square([motor_body / 2, motor_body_hole_d]);

          // Mounting holes
          for (x = [-motor_mount_spacing / 2, motor_mount_spacing / 2]) {
            for (y = [-motor_mount_spacing / 2, motor_mount_spacing / 2]) {
              translate([x, y]) circle(d=motor_mount_hole_d);
            }
          }
        }
      }

    // Security
    translate([0, 0, wall_t]) {
      difference() {
        linear_extrude((motor_body - motor_body_hole_d) / 2, scale=[0, 1])
          square([(motor_body - motor_body_hole_d) / 2, motor_body]);
        translate([motor_body / 2, motor_body / 2, 0])
          linear_extrude((motor_body - motor_body_hole_d) / 2) {
            for (y = [-motor_mount_spacing / 2, motor_mount_spacing / 2]) {
              translate([-motor_mount_spacing / 2, y]) circle(d=motor_mount_hole_top_d);
            }
          }
      }
    }
  }

  // Top holes
  translate([wall_t, wall_t, 0])
    lid_hole();
  translate([size.x - wall_t, wall_t, 0])
    rotate([0, 0, 90])
      lid_hole();
  translate([wall_t, size.y - wall_t, 0])
    rotate([0, 0, -90])
      lid_hole();
  translate([size.x - wall_t, size.y - wall_t, 0])
    rotate([0, 0, 180])
      lid_hole();
}

bottom();
