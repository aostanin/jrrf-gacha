$fn = 100;

pitch = 28;
tiles = 4;
h = 1.6;

module tile() {
  import("../opengrid/opengrid-bare-lite-snap.3mf", center=true);
}

translate([pitch / 2, pitch / 2, 0]) {
  for (x = [0 : tiles - 1], y = [0 : tiles - 1]) {
    translate([x * pitch, y * pitch, 0]) tile();
  }
}

translate([0, 0, 3.4 / 2]) {
  linear_extrude(h) {
    square(pitch * tiles);
  }
  translate([0, 0, h]) {
    linear_extrude(0.6) {
      scale(pitch * tiles / 45) import("qr.svg");
    }
  }
}
