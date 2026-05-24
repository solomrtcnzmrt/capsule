// ═══════════════════════════════════════════════════════════════
//   CAPSULE FILLING MACHINE  —  V7
//   Size 0 capsule · 100 holes · 10×10 grid · 170×170 mm base
//   Bambu Lab P2S · PETG · 0.4 mm nozzle · 4 perimeters
//
//   PARTS
//     body_plate   — capsule body holder with spring-loaded feet
//     foot         — spring foot (print 4×, PETG or TPU)
//     middle_plate — separation / organisation tray (orange)
//     capping      — cap-holding plate with funnel entries
//     frame        — raised-wall tray that aligns all plates
//     spill_guard  — powder-containment frame
//     spreader     — powder squeegee
//     tamper       — peg tamper for powder compression
//     tpu_spring   — printed spring alternative to metal
//     alignment_pin— stack alignment dowel (print 4–8×)
//     all          — all parts spread for reference
//
//   HARDWARE per machine (×4 each)
//     M4 × 35 mm button-head bolt  (ISO 7380, stainless)
//     M4 hex nut                   (press-fit into foot)
//     Compression spring  OD 8 mm · wire 0.8 mm · free L 20 mm
//       (spring sits OUTSIDE bolt, VISIBLE between plate and foot)
//
//   SIZE 0 CAPSULE REFERENCE
//     Cap  OD 7.65 mm  · L 11.5 mm
//     Body OD 7.34 mm  · ID 7.13 mm · L 15.9 mm
//     Assembled total length ≈ 22 mm
//
//   ASSEMBLY ORDER (bottom to top)
//     1. foot (×4) — spring around bolt, bolt through body plate
//     2. body_plate — capsule bodies drop in, bodiesdown
//     3. middle_plate — sits on top, separates halves
//     4. frame — walls align everything
//     5. capping — holds caps
//     6. spill_guard — contains powder during filling
// ═══════════════════════════════════════════════════════════════

// ─── DISPATCH ──────────────────────────────────────────────────
PART = "body_plate";
//  Options: "body_plate" "foot" "middle_plate" "capping"
//           "frame" "spill_guard" "spreader" "tamper"
//           "tpu_spring" "alignment_pin" "all"


// ═══════════════════════════════════════════════════════════════
//   § A  PRIMARY PARAMETERS  (edit freely)
// ═══════════════════════════════════════════════════════════════

PITCH         = 14.5;   // hole centre-to-centre spacing, mm
BORDER        = 19.75;  // plate edge → first hole centre
                        //   = (170 - 9×14.5) / 2  =  19.75

// Foot / bolt corner position — both are concentric at this offset
FOOT_POS      = 10;     // inset from plate corner (mm)
FOOT_DIAMETER = 16;     // foot OD (visible spring collar)

FRAME_RIM     = 9;      // frame-plate inner wall thickness


// ═══════════════════════════════════════════════════════════════
//   § B  FIXED GEOMETRY
// ═══════════════════════════════════════════════════════════════

PLATE_SIZE  = 170;
N           = 10;       // holes per axis
PLATE_T     = 13;       // standard plate thickness
CORNER_R    = 4;        // corner rounding radius
CHAMFER     = 0.8;      // top-edge chamfer height

// ─── Size-0 capsule (verified from pharmacopoeia data) ─────────
CAP_OD    = 7.65;
BODY_OD   = 7.34;
BODY_ID   = 7.13;
CAP_L     = 11.5;       // cap shell length
BODY_L    = 15.9;       // body shell length
TOL       = 0.28;       // diametric clearance for printed holes

CAP_HOLE  = CAP_OD  + TOL;   // 7.93 mm
BODY_HOLE = BODY_OD + TOL;   // 7.62 mm
PEG_OD    = BODY_ID - 0.25;  // 6.88 mm — tamper peg
PEG_L     = 17;
FUNNEL_D  = 13;               // funnel top diameter

// ─── M4 hardware ────────────────────────────────────────────────
M4_CLEAR    = 4.5;    // shaft clearance hole
M4_HEAD_D   = 9.0;   // button-head counterbore diameter
M4_HEAD_H   = 3.2;   // button-head height
M4_NUT_FF   = 7.2;   // hex-nut flat-to-flat (+ tolerance)
M4_NUT_H    = 3.5;   // hex-nut height

// ─── Spring (external, visible) ─────────────────────────────────
SPR_OD       = 8.0;   // spring outer diameter
SPR_FREE     = 20.0;  // spring free length
SPR_PRECOMP  = 4.0;   // assembly pre-compression
SPR_CLEARANCE = SPR_OD + 1.5;  // pocket / counterbore diameter

// ─── Foot ───────────────────────────────────────────────────────
FOOT_D  = FOOT_DIAMETER;
FOOT_H  = 12;         // foot cylinder height (spring sits on top face)

// ─── Alignment pins ─────────────────────────────────────────────
EDGE_OFF    = 6;      // alignment-hole inset from plate edge
ALIGN_D     = 3.3;    // pin clearance hole diameter
PIN_L       = 50;     // alignment pin length

// ─── Spill guard ────────────────────────────────────────────────
SPILL_W     = 10;     // wall width
SPILL_H     = 16;     // wall height above plate surface

// ─── Frame plate ────────────────────────────────────────────────
FRAME_H     = 10;     // height of raised rim

// ─── Render quality ─────────────────────────────────────────────
$fa = 1;
$fs = 0.4;
EPS     = 0.15;
HOLE_FN = 72;


// ═══════════════════════════════════════════════════════════════
//   § C  HELPER MODULES
// ═══════════════════════════════════════════════════════════════

// 10×10 grid of cylinders at capsule hole positions
module hole_grid(d, h, z = 0) {
    for (r = [0:N-1], c = [0:N-1])
        translate([BORDER + c*PITCH, BORDER + r*PITCH, z])
            cylinder(d = d, h = h, $fn = HOLE_FN);
}

// Four corner positions — bolt and foot are CONCENTRIC here
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
    s = PLATE_SIZE - EDGE_OFF;
    for (p = [[c,        EDGE_OFF],
              [c,        s       ],
              [EDGE_OFF, c       ],
              [s,        c       ]])
        translate([p.x, p.y, 0])
            children();
}

// Flat rounded plate with optional top chamfer
module base_plate(t = PLATE_T, sz = PLATE_SIZE, chamfer = true) {
    if (chamfer) {
        union() {
            linear_extrude(t - CHAMFER)
                offset(r = CORNER_R) offset(r = -CORNER_R)
                    square([sz, sz]);
            translate([0, 0, t - CHAMFER])
                linear_extrude(CHAMFER, scale = (sz - 2*CHAMFER)/sz)
                    offset(r = CORNER_R) offset(r = -CORNER_R)
                        square([sz, sz]);
        }
    } else {
        linear_extrude(t)
            offset(r = CORNER_R) offset(r = -CORNER_R)
                square([sz, sz]);
    }
}

// Through-holes at mid-edge positions for alignment pins
module align_holes() {
    four_mid_edges()
        translate([0, 0, -EPS])
            cylinder(d = ALIGN_D, h = 300, $fn = 32);
}

// Hex-nut pocket (M4, from a given Z upward)
module nut_pocket(from_z) {
    translate([0, 0, from_z])
        rotate([0, 0, 30])
            cylinder(d = M4_NUT_FF / cos(30),
                     h = M4_NUT_H + EPS, $fn = 6);
}


// ═══════════════════════════════════════════════════════════════
//   § 1  BODY PLATE
//
//   · 100 capsule-BODY holes  (bodies drop in, open end up)
//   · M4 button-head bolt counterbore on TOP surface at 4 corners
//   · Spring-seat counterbore on BOTTOM — spring sits here,
//     visible between plate underside and foot top
//   · Mid-edge alignment pin holes
//
//   Spring-foot logic (matching reference product):
//     Bolt head is flush with plate top.
//     Spring (OD 8 mm) wraps bolt shaft, compressed between
//     plate underside and foot top face.
//     Foot floats down ~SPR_PRECOMP mm when pressed.
// ═══════════════════════════════════════════════════════════════
module body_plate() {
    difference() {
        base_plate(PLATE_T);

        // ── 100 capsule body holes (full depth) ────────────────
        translate([0, 0, -EPS])
            hole_grid(BODY_HOLE, PLATE_T + 2*EPS);

        // ── Corner bolt + spring features ──────────────────────
        four_corners() {
            // M4 shaft clearance — full thickness
            translate([0, 0, -EPS])
                cylinder(d = M4_CLEAR,
                         h = PLATE_T + 2*EPS, $fn = 32);

            // Button-head counterbore — recessed from TOP
            // head sits flush so other plates can stack flat
            translate([0, 0, PLATE_T - M4_HEAD_H])
                cylinder(d = M4_HEAD_D,
                         h = M4_HEAD_H + EPS, $fn = 48);

            // Spring-seat pocket on BOTTOM (spring coils rest here)
            // Diameter slightly larger than spring OD
            translate([0, 0, -EPS])
                cylinder(d = SPR_CLEARANCE,
                         h = 3.5, $fn = 48);
        }

        // ── Mid-edge alignment pin through-holes ───────────────
        align_holes();
    }
}


// ═══════════════════════════════════════════════════════════════
//   § 2  FOOT  (print 4×)
//
//   · Cylinder FOOT_D × FOOT_H
//   · Top face: spring rests on flat rim around M4 clearance hole
//   · M4 nut press-fit pocket from TOP (bolt threads in from above)
//   · M4 shaft clearance through full height
//   · Anti-skid chamfer on bottom edge
//   · Optional rubber-pad recess on sole (0.8 mm deep)
// ═══════════════════════════════════════════════════════════════
module foot() {
    difference() {
        union() {
            // Main cylinder
            cylinder(d = FOOT_D, h = FOOT_H, $fn = 64);
            // Flange collar at base — widens contact patch
            cylinder(d = FOOT_D + 4, h = 2, $fn = 64);
        }

        // M4 clearance through full height
        translate([0, 0, -EPS])
            cylinder(d = M4_CLEAR,
                     h = FOOT_H + 2*EPS, $fn = 32);

        // Hex-nut pocket from top — bolt threads into nut
        // Pocket depth = nut height; bolt tip is captured here
        nut_pocket(FOOT_H - M4_NUT_H);

        // Rubber-pad recess on sole (glue a 1 mm silicone disc)
        translate([0, 0, -EPS])
            cylinder(d = FOOT_D - 4, h = 0.9, $fn = 48);

        // Bottom outer chamfer — clean first layer
        translate([0, 0, -EPS])
            difference() {
                cylinder(d = FOOT_D + 6, h = 1.2, $fn = 64);
                cylinder(d1 = FOOT_D - 2, d2 = FOOT_D + 4,
                         h  = 1.2 + EPS, $fn = 64);
            }
    }
}


// ═══════════════════════════════════════════════════════════════
//   § 3  MIDDLE PLATE  (orange in reference)
//
//   · Sits on top of body plate during capsule separation
//   · 100 cap-size holes (slightly larger than body hole)
//   · Raised rim (1.5 mm) around each hole on TOP surface
//     — these pips help the capsule caps pop and separate cleanly
//   · Bottom chamfer on each hole guides capsule bodies in
// ═══════════════════════════════════════════════════════════════
module middle_plate() {
    difference() {
        union() {
            base_plate(PLATE_T);
            // Raised pip rings around each hole (top surface)
            for (r = [0:N-1], c = [0:N-1])
                translate([BORDER + c*PITCH, BORDER + r*PITCH, PLATE_T - EPS])
                    difference() {
                        cylinder(d = CAP_HOLE + 3.5, h = 1.8, $fn = HOLE_FN);
                        cylinder(d = CAP_HOLE,       h = 1.8 + EPS, $fn = HOLE_FN);
                    }
        }

        for (r = [0:N-1], c = [0:N-1])
            translate([BORDER + c*PITCH, BORDER + r*PITCH, 0]) {
                // Main hole (cap size)
                translate([0, 0, -EPS])
                    cylinder(d = CAP_HOLE,
                             h = PLATE_T + 2*EPS, $fn = HOLE_FN);
                // Entry chamfer on bottom — guides body into hole
                translate([0, 0, -EPS])
                    cylinder(d1 = CAP_HOLE + 3, d2 = CAP_HOLE,
                             h  = 2.5, $fn = HOLE_FN);
            }

        align_holes();
    }
}


// ═══════════════════════════════════════════════════════════════
//   § 4  CAPPING PLATE
//
//   · Holds capsule CAPS open end up during filling
//   · Cap pocket: 9 mm deep, matches CAP_HOLE diameter
//   · Funnel entry from top: wide → CAP_HOLE over 3 mm
//   · Plate bottom is solid — caps cannot fall through
// ═══════════════════════════════════════════════════════════════
module capping_plate() {
    CAP_POCKET = 9.5;   // depth of cap-retention pocket
    difference() {
        base_plate(PLATE_T);

        for (r = [0:N-1], c = [0:N-1])
            translate([BORDER + c*PITCH, BORDER + r*PITCH, 0]) {
                // Cap pocket — measured from TOP surface
                translate([0, 0, PLATE_T - CAP_POCKET])
                    cylinder(d = CAP_HOLE,
                             h = CAP_POCKET + EPS, $fn = HOLE_FN);
                // Funnel entry at top
                translate([0, 0, PLATE_T - 3])
                    cylinder(d1 = CAP_HOLE, d2 = FUNNEL_D,
                             h  = 3 + EPS, $fn = HOLE_FN);
            }

        align_holes();
    }
}


// ═══════════════════════════════════════════════════════════════
//   § 5  FRAME PLATE  (tray that aligns the whole stack)
//
//   · Base plate with a raised rectangular rim (FRAME_RIM wide)
//   · Inside rim locates and squares all the other plates
//   · Bottom has full hole grid (body size) so bodies protrude
//   · Funnel from top guides bodies into alignment
// ═══════════════════════════════════════════════════════════════
module frame_plate() {
    // The inside rim opening
    inner = PLATE_SIZE - 2*FRAME_RIM;

    union() {
        difference() {
            base_plate(PLATE_T);

            for (r = [0:N-1], c = [0:N-1])
                translate([BORDER + c*PITCH, BORDER + r*PITCH, 0]) {
                    // Lower bore (body size)
                    translate([0, 0, -EPS])
                        cylinder(d = BODY_HOLE,
                                 h = PLATE_T / 2 + EPS, $fn = HOLE_FN);
                    // Upper bore + funnel (cap size with wide entry)
                    translate([0, 0, PLATE_T / 2])
                        cylinder(d = CAP_HOLE,
                                 h = PLATE_T / 2 + EPS, $fn = HOLE_FN);
                    translate([0, 0, PLATE_T - 3])
                        cylinder(d1 = CAP_HOLE, d2 = FUNNEL_D,
                                 h  = 3 + EPS, $fn = HOLE_FN);
                }

            align_holes();
        }

        // Raised rim on top
        translate([0, 0, PLATE_T - EPS])
            difference() {
                base_plate(FRAME_H, chamfer = false);
                translate([FRAME_RIM, FRAME_RIM, -EPS])
                    linear_extrude(FRAME_H + 2*EPS)
                        offset(r = CORNER_R - 1) offset(r = -(CORNER_R - 1))
                            square([inner, inner]);
            }
    }
}


// ═══════════════════════════════════════════════════════════════
//   § 6  SPILL GUARD
//
//   · Thin-wall frame that sits around the plate stack
//   · Prevents powder spilling off during filling pass
//   · Height: SPILL_H above seating plate top
//   · Wall thickness: SPILL_W
// ═══════════════════════════════════════════════════════════════
module spill_guard() {
    inner = PLATE_SIZE - 2*SPILL_W;
    difference() {
        base_plate(SPILL_H, chamfer = false);
        translate([SPILL_W, SPILL_W, -EPS])
            linear_extrude(SPILL_H + 2*EPS)
                offset(r = CORNER_R - 1) offset(r = -(CORNER_R - 1))
                    square([inner, inner]);
        align_holes();
    }
}


// ═══════════════════════════════════════════════════════════════
//   § 7  TAMPER  (peg plate to compress powder in capsule bodies)
//
//   · 100 pegs, diameter = PEG_OD (fits inside body shell ID)
//   · Rounded peg tips for smooth entry
//   · Ergonomic bridge handle on top
// ═══════════════════════════════════════════════════════════════
module tamper() {
    union() {
        difference() {
            base_plate(PLATE_T);
            align_holes();
        }

        // 100 tamper pegs projecting DOWNWARD
        for (r = [0:N-1], c = [0:N-1])
            translate([BORDER + c*PITCH, BORDER + r*PITCH, 0]) {
                translate([0, 0, -(PEG_L - 1)])
                    cylinder(d = PEG_OD, h = PEG_L, $fn = HOLE_FN);
                // Rounded tip
                translate([0, 0, -PEG_L])
                    intersection() {
                        scale([1, 1, 0.5]) sphere(d = PEG_OD, $fn = HOLE_FN);
                        translate([-PEG_OD, -PEG_OD, -PEG_OD/2])
                            cube([2*PEG_OD, 2*PEG_OD, PEG_OD/2]);
                    }
            }

        // Ergonomic bridge handle
        HW = 110; HD = 28; HH = 32;
        translate([(PLATE_SIZE - HW)/2, (PLATE_SIZE - HD)/2, PLATE_T])
            hull() {
                for (x = [6, HW-6], y = [6, HD-6])
                    translate([x, y, 0]) cylinder(d = 10, h = 2, $fn = 48);
                for (x = [12, HW-12])
                    translate([x, HD/2, HH-8]) sphere(d = 14, $fn = 48);
            }
    }
}


// ═══════════════════════════════════════════════════════════════
//   § 8  POWDER SPREADER  (flat squeegee / scraper)
//
//   · Trapezoidal blade, 4 mm thick
//   · Angled leading edge (30°) for clean one-pass spreading
//   · Fits inside spill-guard inner opening
// ═══════════════════════════════════════════════════════════════
module spreader() {
    T = 4.5;
    W = inner_sz();
    H = 140;

    function inner_sz() = PLATE_SIZE - 2*SPILL_W - 4;

    difference() {
        linear_extrude(T)
            offset(r = 3) offset(r = -3)
                polygon([[0,0],[W,0],[W-14,H],[14,H]]);
        // Angled scraper bevel on leading edge
        translate([-2, -EPS, T])
            rotate([28, 0, 0])
                cube([W + 4, 14, 10]);
    }
}


// ═══════════════════════════════════════════════════════════════
//   § 9  TPU SPRING  (printed alternative to metal spring)
//
//   · Helical slot gives spring action; print in 95A TPU
//   · Same OD as metal spring — drop-in replacement
// ═══════════════════════════════════════════════════════════════
module tpu_spring() {
    difference() {
        cylinder(d = SPR_OD - 0.3, h = SPR_FREE, $fn = 48);
        // Bolt clearance
        translate([0, 0, -EPS])
            cylinder(d = M4_CLEAR, h = SPR_FREE + 2*EPS, $fn = 32);
        // Helical slot
        linear_extrude(SPR_FREE, twist = 720, slices = 100, convexity = 10)
            translate([SPR_OD/4, 0])
                square([SPR_OD/2 + 1, 0.7], center = true);
    }
}


// ═══════════════════════════════════════════════════════════════
//   § 10  ALIGNMENT PIN  (4–8 per machine, PETG)
//
//   · Slight taper so it self-centres in the 3.3 mm holes
//   · Mushroom head for easy gripping
// ═══════════════════════════════════════════════════════════════
module alignment_pin() {
    union() {
        // Shaft — tapers slightly for press fit
        cylinder(d1 = 3.1, d2 = 2.9, h = PIN_L, $fn = 24);
        // Flange transition
        translate([0, 0, PIN_L])
            cylinder(d1 = 3.1, d2 = 9.0, h = 2, $fn = 32);
        // Head cap
        translate([0, 0, PIN_L + 2]) {
            cylinder(d = 9.0, h = 5, $fn = 32);
            translate([0, 0, 5])
                intersection() {
                    sphere(d = 9.0, $fn = 32);
                    cylinder(d = 9.0, h = 4.5, $fn = 32);
                }
        }
    }
}


// ═══════════════════════════════════════════════════════════════
//   DISPATCH
// ═══════════════════════════════════════════════════════════════
if      (PART == "body_plate")    body_plate();
else if (PART == "foot")          foot();
else if (PART == "middle_plate")  middle_plate();
else if (PART == "capping")       capping_plate();
else if (PART == "frame")         frame_plate();
else if (PART == "spill_guard")   spill_guard();
else if (PART == "tamper")        tamper();
else if (PART == "spreader")      spreader();
else if (PART == "tpu_spring")    tpu_spring();
else if (PART == "alignment_pin") alignment_pin();
else if (PART == "all") {
    // Lay all parts flat for overview
    GAP = 185;
    translate([    0,    0, 0]) body_plate();
    translate([ GAP,     0, 0]) middle_plate();
    translate([2*GAP,    0, 0]) capping_plate();
    translate([    0,  GAP, 0]) frame_plate();
    translate([ GAP,   GAP, 0]) spill_guard();
    translate([2*GAP,  GAP, 0]) tamper();
    translate([    0, 2*GAP,0]) spreader();
    translate([ GAP,  2*GAP,0]) {
        // 4 feet side by side
        for (i = [0:3]) translate([i*22, 0, 0]) foot();
    }
    translate([ GAP+100, 2*GAP, 0]) tpu_spring();
    translate([ GAP+130, 2*GAP, 0]) alignment_pin();
}
