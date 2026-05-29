$fn = 100;

pitch = 28;
font_en = "Roboto:style=Black";
font_jp = "Noto Sans CJK JP:style=Black";
h = 1;

function en(t) = ["en", t];
function jp(t) = ["jp", t];
function svg(f, s) = ["svg", f, s];
function mdi(name, s = 2.75) = ["svg", str("mdi/", name, ".svg"), s];

function substr(s, start, end) =
  start >= end ? "" : str(s[start], substr(s, start + 1, end));

module tile_base() {
  import("../opengrid/opengrid-bare-lite-snap.3mf");
  translate([0, 0, 3.4])
    linear_extrude(height=h)
      children();
}

module en_tile(t) {
  l = len(t);
  if (l <= 2) {
    size = l > 1 ? 12 : 18;
    tile_base()
      translate([0, -size / 2])
        text(t, size=size, font=font_en, halign="center", valign="baseline");
  } else {
    size = 10;
    split = ceil(l / 2);
    line_h = size * 1.1;
    tile_base() {
      translate([0, line_h / 2])
        text(substr(t, 0, split), size=size, font=font_en, halign="center", valign="center");
      translate([0, -line_h / 2])
        text(substr(t, split, l), size=size, font=font_en, halign="center", valign="center");
    }
  }
}

module jp_tile(t) {
  tile_base()
    text(t, size=14, font=font_jp, halign="center", valign="center");
}

module svg_tile(f, s) {
  tile_base()
    scale(s) import(f, center=true);
}

module tile(item) {
  type = item[0];
  if (type == "en")
    en_tile(item[1]);
  else if (type == "jp")
    jp_tile(item[1]);
  else if (type == "svg") svg_tile(item[1], item[2]);
}

module grid(items, cols) {
  for (i = [0:len(items) - 1]) {
    translate([(i % cols) * pitch, -floor(i / cols) * pitch, 0])
      tile(items[i]);
  }
}

grid(
  [
    en(""),
    en("G"),
    en("A"),
    en("C"),
    en("H"),
    en("A"),
    en("SATS"),
    en("0"),
    en("1"),
    en("2"),
    en("3"),
    en("4"),
    en("5"),
    en("6"),
    en("7"),
    en("8"),
    en("9"),
    jp("お"),
    jp("か"),
    jp("し"),
    mdi("bitcoin"),
    mdi("currency-btc"),
    mdi("candy"),
    mdi("lightning-bolt-circle"),
    mdi("printer-3d"),
    mdi("qrcode"),
    mdi("cellphone"),
    svg("Bitcoin.svg", 0.5),
    svg("Bitcoin_lightning_bolt.svg", 0.4),
  ],
  6
);
