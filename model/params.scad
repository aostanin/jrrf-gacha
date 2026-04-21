m3_hole_d = 3.5;

wall_t = 3;

capsule_d = 75;
capsule_clearance = 10;
capsule_hole_d = capsule_d + capsule_clearance;

hose_id = capsule_hole_d + 2 * wall_t;
hose_clamp_h = 12;

motor_body = 42.3;
motor_body_h = 37.8;
motor_body_hole_d = 24;
motor_mount_spacing = 31;
motor_mount_hole_d = m3_hole_d;
motor_mount_hole_top_d = 6.5;
shaft_d = 5.4;
shaft_flat = 4.8;
shaft_l = 18;

plate_h = wall_t + motor_body_h + 5.4;

_size_side = 2 * wall_t + motor_body + capsule_hole_d;
_size_height = 3 * wall_t + capsule_hole_d;
size = [_size_side, _size_side, _size_height];
usb_cutout_size = [12, 6];

$fn = 72;
