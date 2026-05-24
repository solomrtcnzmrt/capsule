// ═══════════════════════════════════════════════════════════════
//   CAPSULE FILLING MACHINE  —  V6 (External Spring Feet)
//   100 holes · 10×10 grid · 170×170 mm · pitch 14.5
//   Bambu Lab P2S · PETG · 0.4 mm nozzle
//
//   V6: Single body plate + 4 separate spring-loaded feet.
//   Springs are visible between body plate and feet.
//   Bolt passes top-down; spring sits on shaft; foot captures bolt
//   via press-fit M4 hex nut.
//
//   HARDWARE (×4 each)
//     M4 × 30 mm button-head bolt  (304 stainless)
//     M4 hex nut  (press-fit into foot pocket)
//     Compression spring  OD 6 mm · ID 4 mm · free L 15 mm · wire 0.5 mm
//
//   ASSEMBLY
//     1. Press M4 hex nut into top pocket of foot (firm push)
//     2. Slide spring onto bolt shaft
//     3. Drop bolt into top of body plate (head into counterbore)
//     4. Push bolt tip through spring
//     5. Thread bolt into foot nut, hand-tight
//     6. Tighten with allen key until spring is pre-compressed ~3 mm
//     7. Repeat at all 4 corners
// ═══════════════════════════════════════════════════════════════

// ─── DISPATCH — change this string to render a single part ─────
PART = "body_plate";
//  "body_plate" | "foot" | "spill_guard" | "middle" |
//  "capping"    | "frame"| "tamper"      | "spreader"|
//  "tpu_spring" | "alignment_pin"        | "all"


// ═══════════════════════════════════════════════════════════════
//   § A  PRIMARY PARAMETERS  (edit these to tune the design)
// ═══════════════════════════════════════════════════════════════

PITCH         = 14.5;   // hole-to-hole spacing, mm
BORDER        = 19.75;  // distance from plate edge to first hole centre
                        //   formula: (PLATE_SIZE - (N-1)*PITCH) / 2

FOOT_POS      = 7;      // bolt/foot centre offset from plate corner, mm
                        //   feet sit at (FOOT_POS, FOOT_POS) and mirrors
FOOT_DIAMETER = 12;     // foot cylinder outer diameter, mm
FRAME_RIM     = 8;      // wall width of the frame rim, mm


// ═══════════════════════════════════════════════════════════════
//   § B  DERIVED / FIXED GEOMETRY
// ═══════════════════════════════════════════════════════════════

PLATE_SIZE   = 170;
N            = 10;      // holes per axis
PLATE_T      = 12;      // plate thickness
CORNER_R     = 3;       // corner rounding radius
EDGE_CHAMFER = 0.6;     // top-edge chamfer height

// ─── Size-0 capsule dimensions ──────────────────────────────────
CAP_OD   = 7.65;
BODY_OD  = 7.34;
BODY_ID  = 7.13;
TOL      = 0.30;        // diametric clearance for printed holes

CAP_HOLE   = CAP_OD  + TOL;   // 7.95 mm — cap shell clears this
BODY_HOLE  = BODY_OD + TOL;   // 7.64 mm — body shell clears this
PEG_OD     = BODY_ID - TOL;   // 6.83 mm — tamper peg fits inside body
PEG_L      = 16;
FUNNEL_TOP = 12;
CAP_DEPTH  = 9;

// ─── M4 hardware ────────────────────────────────────────────────
M4_SHAFT     = 4.5;    // bolt-shaft clearance hole diameter
M4_HEAD      = 9.0;    // button-head diameter (counterbore)
M4_HEAD_H    = 3.2;    // button-head height
M4_NUT_FLATS = 7.2;    // hex-nut flat-to-flat (clearance)
M4_NUT_H     = 4.0;    // hex-nut height

// ─── Compression spring ─────────────────────────────────────────
SPRING_OD      = 6.0;
SPRING_L_FREE  = 15.0;
SPRING_GUIDE_D = 3.8;  // guide post OD on foot top
SPRING_GUIDE_H = 3.0;  // guide post height (and underside pocket depth)

// ─── Foot geometry ──────────────────────────────────────────────
FOOT_D = FOOT_DIAMETER;   // alias so modules read clearly
FOOT_H = 10;

// ─── Alignment pins ─────────────────────────────────────────────
EDGE_OFFSET  = 5;      // alignment-hole centre inset from plate edge
ALIGN_HOLE_D = 3.3;    // alignment-pin clearance hole

// ─── Spill-guard rim ────────────────────────────────────────────
SPILL_RIM_H = 14;
SPILL_RIM_W = 9;

// ─── Frame rim (uses FRAME_RIM from § A) ────────────────────────
FRAME_RIM_H = 8;       // height of the raised frame rim

// ─── Render quality ─────────────────────────────────────────────
$fa = 1;
$fs = 0.4;
EPS     = 0.1;          // overlap epsilon to avoid z-fighting
HOLE_FN = 64;           // facet count for capsule holes


// ═══════════════════════════════════════════════════════════════
//   § C  HELPER MODULES
// ═══════════════════════════════════════════════════════════════

// 10×10 grid of cylinders centred on hole positions
module hole_grid(d, h, z = 0) {
    for (r = [0:N-1], c = [0:N-1])
        translate([BORDER + c*PITCH, BORDER + r*PITCH, z])
            cylinder(d=d, h=h, $fn=HOLE_FN);
}

// Four bolt/foot corners: inset FOOT_POS from each corner.
// Feet are CONCENTRIC with the bolts because this single module
// places both the M4 shaft and the foot at the same (x, y).
module four_corners() {
    s = PLATE_SIZE - FOOT_POS;
    for (p = [[FOOT_POS, FOOT_POS],
              [s,        FOOT_POS],
              [FOOT_POS, s       ],
              [s,        s       ]])
        translate([p.x, p.y, 0])
            children();
}

// Four mid-edge alignment-hole positions
module four_mid_edges() {
    c = PLATE_SIZE / 2;
    s = PLATE_SIZE - EDGE_OFFSET;
    for (p = [[c,          EDGE_OFFSET],
              [c,          s          ],
              [EDGE_OFFSET, c         ],
              [s,          c          ]])
        translate([p.x, p.y, 0])
            children();
}

// Flat plate with rounded corners and optional top chamfer
module base_plate(t = PLATE_T, size = PLATE_SIZE, chamfer = true) {
    if (chamfer) {
        union() {
            linear_extrude(height = t - EDGE_CHAMFER)
                offset(r = CORNER_R) offset(r = -CORNER_R)
                    square([size, size]);
            translate([0, 0, t - EDGE_CHAMFER])
                linear_extrude(
                    height = EDGE_CHAMFER,
                    scale  = (size - 2*EDGE_CHAMFER) / size)
                    offset(r = CORNER_R) offset(r = -CORNER_R)
                        square([size, size]);
        }
    } else {
        linear_extrude(height = t)
            offset(r = CORNER_R) offset(r = -CORNER_R)
                square([size, size]);
    }
}

// Through-holes at mid-edge positions (alignment pins)
module align_holes_mid_edge() {
    four_mid_edges()
        translate([0, 0, -EPS])
            cylinder(d = ALIGN_HOLE_D, h = 200, $fn = 32);
}


// ═══════════════════════════════════════════════════════════════
//   § 1  BODY PLATE
//        · 100 capsule-body holes on 14.5 mm grid
//        · M4 bolt counterbores at all 4 corners (FOOT_POS offset)
//        · Spring-guide pockets on the underside (concentric with bolts)
//        · Mid-edge alignment holes
// ═══════════════════════════════════════════════════════════════
module body_plate() {
    difference() {
        base_plate(PLATE_T);

        // ── 100 capsule body holes ──────────────────────────────
        translate([0, 0, -EPS])
            hole_grid(BODY_HOLE, PLATE_T + 2*EPS);

        // ── M4 bolt holes + button-head counterbores ────────────
        //    Feet and bolts share the same (x,y) via four_corners(),
        //    so they are automatically concentric.
        four_corners() {
            // Shaft clearance — full depth
            translate([0, 0, -EPS])
                cylinder(d = M4_SHAFT,
                         h = PLATE_T + 2*EPS, $fn = 32);
            // Counterbore for button head (recessed from top)
            translate([0, 0, PLATE_T - M4_HEAD_H])
                cylinder(d = M4_HEAD,
                         h = M4_HEAD_H + EPS, $fn = 48);
        }

        // ── Spring-guide pockets on underside ───────────────────
        //    Spring OD + 1.5 mm clearance; depth = SPRING_GUIDE_H
        four_corners()
            translate([0, 0, -EPS])
                cylinder(d = SPRING_OD + 1.5,
                         h = SPRING_GUIDE_H, $fn = 48);

        // ── Mid-edge alignment pin holes ────────────────────────
        align_holes_mid_edge();
    }
}


// ═══════════════════════════════════════════════════════════════
//   § 2  FOOT  (print 4×)
//        · Cylinder FOOT_DIAMETER × FOOT_H
//        · Spring-guide post on top (centres spring over bolt)
//        · M4 bolt clearance through full height
//        · Hex-nut press-fit pocket near top (captures bolt)
//        · Bottom chamfer for clean bed adhesion
// ═══════════════════════════════════════════════════════════════
module foot() {
    difference() {
        union() {
            cylinder(d = FOOT_D, h = FOOT_H, $fn = 64);
            // Spring-guide post sits on top of the foot;
            // slight taper helps spring slide on
            translate([0, 0, FOOT_H - EPS])
                cylinder(d1 = SPRING_GUIDE_D,
                         d2 = SPRING_GUIDE_D - 0.4,
                         h  = SPRING_GUIDE_H, $fn = 48);
        }

        // Bolt clearance through full height + guide post
        translate([0, 0, -EPS])
            cylinder(d = M4_SHAFT,
                     h = FOOT_H + SPRING_GUIDE_H + 2*EPS, $fn = 32);

        // Hex-nut press-fit pocket (from top, rotate 30° for flat alignment)
        translate([0, 0, FOOT_H - M4_NUT_H])
            rotate([0, 0, 30])
                cylinder(d = M4_NUT_FLATS / cos(30),
                         h = M4_NUT_H + EPS, $fn = 6);

        // Bottom chamfer — improves first-layer quality
        translate([0, 0, -EPS])
            difference() {
                cylinder(d = FOOT_D + 2, h = 0.8, $fn = 64);
                cylinder(d1 = FOOT_D - 1.6, d2 = FOOT_D,
                         h  = 0.8 + EPS, $fn = 64);
            }
    }
}


// ═══════════════════════════════════════════════════════════════
//   § 3  SPILL GUARD
// ═══════════════════════════════════════════════════════════════
module spill_guard() {
    inner = PLATE_SIZE - 2*SPILL_RIM_W;
    difference() {
        base_plate(SPILL_RIM_H);
        translate([SPILL_RIM_W, SPILL_RIM_W, -EPS])
            linear_extrude(SPILL_RIM_H + 2*EPS)
                offset(r = CORNER_R - 1) offset(r = -(CORNER_R - 1))
                    square([inner, inner]);
        align_holes_mid_edge();
    }
}


// ═══════════════════════════════════════════════════════════════
//   § 4  MIDDLE PLATE
// ═══════════════════════════════════════════════════════════════
module middle_plate() {
    difference() {
        base_plate();
        for (r = [0:N-1], c = [0:N-1])
            translate([BORDER + c*PITCH, BORDER + r*PITCH, 0]) {
                translate([0, 0, -EPS])
                    cylinder(d = CAP_HOLE,
                             h = PLATE_T + 2*EPS, $fn = HOLE_FN);
                // Entry chamfer (bottom)
                translate([0, 0, -EPS])
                    cylinder(d1 = CAP_HOLE + 3, d2 = CAP_HOLE,
                             h  = 2, $fn = HOLE_FN);
                // Exit chamfer (top)
                translate([0, 0, PLATE_T - 2])
                    cylinder(d1 = CAP_HOLE, d2 = CAP_HOLE + 3,
                             h  = 2 + EPS, $fn = HOLE_FN);
            }
        align_holes_mid_edge();
    }
}


// ═══════════════════════════════════════════════════════════════
//   § 5  CAPPING PLATE
// ═══════════════════════════════════════════════════════════════
module capping_plate() {
    difference() {
        base_plate();
        hole_grid(CAP_HOLE, CAP_DEPTH + EPS, PLATE_T - CAP_DEPTH);
        align_holes_mid_edge();
    }
}


// ═══════════════════════════════════════════════════════════════
//   § 6  FRAME PLATE
//        · Funnel holes guide capsule cap onto body
//        · Raised rim (FRAME_RIM wide) keeps parts aligned
// ═══════════════════════════════════════════════════════════════
module frame_plate() {
    union() {
        difference() {
            base_plate();
            for (r = [0:N-1], c = [0:N-1])
                translate([BORDER + c*PITCH, BORDER + r*PITCH, 0]) {
                    // Funnel: wide at top, narrows to cap hole
                    translate([0, 0, 8])
                        cylinder(d1 = CAP_HOLE, d2 = FUNNEL_TOP,
                                 h  = 4 + EPS, $fn = HOLE_FN);
                    translate([0, 0, 4])
                        cylinder(d = CAP_HOLE,
                                 h = 4 + EPS, $fn = HOLE_FN);
                    // Lower body-hole section
                    translate([0, 0, -EPS])
                        cylinder(d = BODY_HOLE,
                                 h = 4 + 2*EPS, $fn = HOLE_FN);
                }
            align_holes_mid_edge();
        }

        // Raised rim sits on top of the plate
        translate([0, 0, PLATE_T - EPS])
            difference() {
                base_plate(FRAME_RIM_H, chamfer = false);
                translate([FRAME_RIM, FRAME_RIM, -EPS])
                    linear_extrude(FRAME_RIM_H + 2*EPS)
                        offset(r = CORNER_R - 1) offset(r = -(CORNER_R - 1))
                            square([PLATE_SIZE - 2*FRAME_RIM,
                                    PLATE_SIZE - 2*FRAME_RIM]);
            }
    }
}


// ═══════════════════════════════════════════════════════════════
//   § 7  TAMPER
// ═══════════════════════════════════════════════════════════════
module tamper() {
    union() {
        difference() {
            base_plate();
            align_holes_mid_edge();
        }

        // 100 tamper pegs
        for (r = [0:N-1], c = [0:N-1])
            translate([BORDER + c*PITCH, BORDER + r*PITCH, -(PEG_L - 1)]) {
                cylinder(d = PEG_OD, h = PEG_L - 1, $fn = HOLE_FN);
                // Rounded peg tip
                translate([0, 0, -0.5])
                    intersection() {
                        scale([1, 1, 0.5]) sphere(d = PEG_OD, $fn = HOLE_FN);
                        translate([-PEG_OD, -PEG_OD, -PEG_OD])
                            cube([2*PEG_OD, 2*PEG_OD, PEG_OD]);
                    }
            }

        // Ergonomic handle
        handle_w = 100;
        handle_d = 24;
        handle_h = 28;
        translate([(PLATE_SIZE - handle_w)/2,
                   (PLATE_SIZE - handle_d)/2,
                   PLATE_T])
            hull() {
                translate([4,            4,            0]) cylinder(d=8, h=2, $fn=48);
                translate([handle_w - 4, 4,            0]) cylinder(d=8, h=2, $fn=48);
                translate([4,            handle_d - 4, 0]) cylinder(d=8, h=2, $fn=48);
                translate([handle_w - 4, handle_d - 4, 0]) cylinder(d=8, h=2, $fn=48);
                translate([8,            handle_d/2, handle_h - 6]) sphere(d=12, $fn=48);
                translate([handle_w - 8, handle_d/2, handle_h - 6]) sphere(d=12, $fn=48);
            }
    }
}


// ═══════════════════════════════════════════════════════════════
//   § 8  POWDER SPREADER
// ═══════════════════════════════════════════════════════════════
module spreader() {
    T       = 4;
    W       = 96;
    H_TOTAL = 135;
    difference() {
        linear_extrude(T)
            offset(r=4) offset(r=-4)
                polygon(points=[
                    [0,        0      ],
                    [W,        0      ],
                    [W - 12,   H_TOTAL],
                    [12,       H_TOTAL]
                ]);
        // Angled scraper edge
        translate([-5, -EPS, T])
            rotate([30, 0, 0])
                cube([W + 10, 12, 8]);
    }
}


// ═══════════════════════════════════════════════════════════════
//   § 9  TPU SPRING  (printable alternative to metal spring)
// ═══════════════════════════════════════════════════════════════
module tpu_spring() {
    difference() {
        cylinder(d = SPRING_OD - 0.2, h = SPRING_L_FREE, $fn = 48);
        // Bolt clearance
        translate([0, 0, -EPS])
            cylinder(d = M4_SHAFT,
                     h = SPRING_L_FREE + 2*EPS, $fn = 32);
        // Helical slot gives the part its spring action
        linear_extrude(height = SPRING_L_FREE, twist = 720,
                       slices = 80, convexity = 10)
            translate([SPRING_OD/4, 0])
                square([SPRING_OD/2 + 1, 0.6], center = true);
    }
}


// ═══════════════════════════════════════════════════════════════
//   § 10  ALIGNMENT PIN
// ═══════════════════════════════════════════════════════════════
module alignment_pin() {
    union() {
        cylinder(d1 = 3.0, d2 = 2.8, h = 46, $fn = 24);
        translate([0, 0, 46])
            cylinder(d1 = 3.0, d2 = 8.0, h = 2, $fn = 32);
        translate([0, 0, 48])
            cylinder(d = 8.0, h = 4, $fn = 32);
        translate([0, 0, 52])
            intersection() {
                sphere(d = 8.0, $fn = 32);
                cylinder(d = 8.0, h = 4, $fn = 32);
            }
    }
}


// ═══════════════════════════════════════════════════════════════
//   DISPATCH
// ═══════════════════════════════════════════════════════════════
if      (PART == "body_plate")    body_plate();
else if (PART == "foot")          foot();
else if (PART == "spill_guard")   spill_guard();
else if (PART == "middle")        middle_plate();
else if (PART == "capping")       capping_plate();
else if (PART == "frame")         frame_plate();
else if (PART == "tamper")        tamper();
else if (PART == "spreader")      spreader();
else if (PART == "tpu_spring")    tpu_spring();
else if (PART == "alignment_pin") alignment_pin();
else if (PART == "all") {
    translate([  0,   0, 0]) body_plate();
    translate([190,   0, 0]) spill_guard();
    translate([380,   0, 0]) middle_plate();
    translate([  0, 190, 0]) capping_plate();
    translate([190, 190, 0]) frame_plate();
    translate([380, 190, 0]) tamper();
    translate([  0, 380, 0]) spreader();
    // 4 feet spread out for printing
    translate([200, 380, 0]) foot();
    translate([220, 380, 0]) foot();
    translate([240, 380, 0]) foot();
    translate([260, 380, 0]) foot();
    translate([300, 380, 0]) tpu_spring();
    translate([320, 380, 0]) alignment_pin();
}
