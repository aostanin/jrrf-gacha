$fn = 100;

wall = 6.8;
id = 101.5;
od = id + wall;
h = 15;

module grid() {
  translate([0, 0, wall / 2])
    import("../opengrid/opengrid-2x2.3mf", center=true);
}

grid();
difference() {
  linear_extrude(wall) circle(d=od);
  hull() grid();
}

translate([0, 0, 6.8])
  linear_extrude(h) difference() {
      circle(d=od);
      circle(d=id);
    }
