include <params.scad>
use <top.scad>
use <middle.scad>
use <bottom.scad>

// Gap between each part along Z.
// The middle's printed piece includes a tall wall (size.z high) that
// natively occupies the same Z-band as the bottom case.  We offset the
// middle so its wall sits a clear gap above the bottom, then offset the
// top so it sits a clear gap above the middle's tallest point.
gap = 40;

middle_wall_h = size.z;       // middle's vertical wall height
middle_offset = size.z + gap;
top_offset    = middle_offset + middle_wall_h + gap - (size.z - 2 * wall_t);

color("#4a90e2") translate([0, 0, top_offset])    top();     // lid — blue
color("#f7931a") translate([0, 0, middle_offset]) middle();  // paddle plate — Bitcoin orange
color("#6b7280")                                  bottom();  // case — slate gray
