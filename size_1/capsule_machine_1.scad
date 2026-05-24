// ═══════════════════════════════════════════════════════════════
//   KAPSÜL DOLUM APARATI  —  Numara 1  (V2 · İkili Body Plate)
//   100 delik · 10×10 grid · 170×170 mm tabla
//   Bambu Lab P2S · PETG · 0.4 mm nozzle · 4 perimeter
//
//   ─── PARÇALAR ────────────────────────────────────────────────
//   body_base    — düz alt tabla (masaya oturur, sabit)
//   body_holes   — delikli üst tabla (yaylar üzerinde yüzer)
//   middle_plate — ayırma / separator plakası
//   capping      — kapak tutma plakası
//   frame        — hizalama çerçevesi
//   spill_guard  — toz dökülme koruma çerçevesi
//   spreader     — toz yayma spatulası (96 mm)
//   tamper       — toz sıkıştırma tamper
//   tpu_spring   — basılabilir TPU yay
//   alignment_pin— hizalama pimi (×4–8)
//   all          — tüm parçalar yanda
//
//   ─── BODY PLATE ÇALIŞMA PRENSİBİ ────────────────────────────
//   body_base  ←─ sabit, masada
//      │  [yay OD 8 mm · serbest 18 mm · iki plaka arası görünür]
//   body_holes ←─ 100 delikli, ~8 mm yukarı/aşağı hareket eder
//
//   ─── DONANIM (her köşe ×4) ───────────────────────────────────
//   M4 × 30 mm buton başlı cıvata (ISO 7380 · 304 paslanmaz)
//   M4 altıgen somun  (body_base altına press-fit)
//   Sıkıştırma yayı  OD 8 mm · tel Ø 0.8 mm · serbest L 18 mm
//
//   ─── NUMARA 1 KAPSÜL ÖLÇÜLERİ (Capsugel/ACG spec) ───────────
//   Kapak  OD 6.91 mm · L 10.0 mm
//   Gövde  OD 6.63 mm · ID 6.43 mm · L 14.3 mm
//   Kilitli toplam ≈ 20.0 mm  ·  Dolum hacmi 0.50 ml
//
//   ─── MONTAJ SIRASI (alttan üste) ────────────────────────────
//   1. body_base masaya koyulur
//   2. 4× yay kılavuz postuna geçirilir
//   3. body_holes üstten indirilir, cıvata delikleri hizalanır
//   4. 4× M4×30 cıvata üstten vidalanır; ~4 mm ön-sıkıştırma
//   5. middle_plate, frame, capping sırasıyla üste eklenir
// ═══════════════════════════════════════════════════════════════

PART = "body_base";
//  "body_base"   "body_holes"  "middle_plate"  "capping"
//  "frame"       "spill_guard" "spreader"      "tamper"
//  "tpu_spring"  "alignment_pin"               "all"


// ═══════════════════════════════════════════════════════════════
//   § A  ANA PARAMETRELER
// ═══════════════════════════════════════════════════════════════

PITCH      = 14.5;
BORDER     = 19.75;
BOLT_POS   = 12;
FRAME_RIM  = 9;


// ═══════════════════════════════════════════════════════════════
//   § B  NUMARA 1 GEOMETRİSİ
// ═══════════════════════════════════════════════════════════════

PLATE_SIZE = 170;
N          = 10;
CORNER_R   = 4;
CHAMFER    = 0.8;

// İkili body plate kalınlıkları
BASE_T  = 8;    // body_base (sabit alt tabla)
TOP_T   = 10;   // body_holes — gövde L=14.3 mm, 10 mm plaka → 4.3 mm taşar

// Diğer plakalar (middle, capping, frame, tamper)
PLATE_T = 11;

// Numara 1 — Capsugel standart
CAP_OD    = 6.91;
BODY_OD   = 6.63;
BODY_ID   = 6.43;
CAP_L     = 10.0;
BODY_L    = 14.3;
TOL       = 0.30;   // PETG kayar geçme toleransı

CAP_HOLE  = CAP_OD  + TOL;   // 7.21 mm
BODY_HOLE = BODY_OD + TOL;   // 6.93 mm
PEG_OD    = BODY_ID - 0.25;  // 6.18 mm

ENTRY_C     = 1.2;
ENTRY_ANGLE = 30;

// M4 donanım
M4_CLEAR   = 4.5;
M4_HEAD_D  = 9.2;
M4_HEAD_H  = 3.2;
M4_NUT_FF  = 7.2;
M4_NUT_H   = 3.5;

// Yay
SPR_OD      = 8.0;
SPR_FREE    = 18.0;
SPR_SEAT_D  = SPR_OD + 2.0;   // 10.0 mm
SPR_GUIDE_D = 5.5;
SPR_GUIDE_H = 6.0;

// Hizalama
EDGE_OFF  = 6;
ALIGN_D   = 3.3;
PIN_L     = 48;

// Spill guard
SPILL_W   = 10;
SPILL_H   = 16;

// Çerçeve
FRAME_H   = 11;

// Render
$fa = 0.8;
$fs = 0.3;
EPS     = 0.15;
HOLE_FN = 80;


// ═══════════════════════════════════════════════════════════════
//   § C  YARDIMCI MODÜLLER
// ═══════════════════════════════════════════════════════════════

module hole_grid(d, h, z = 0) {
    for (r = [0:N-1], c = [0:N-1])
        translate([BORDER + c*PITCH, BORDER + r*PITCH, z])
            cylinder(d = d, h = h, $fn = HOLE_FN);
}

module cap_hole_w_chamfer(d, plate_t) {
    c_r = ENTRY_C * tan(ENTRY_ANGLE);
    translate([0, 0, -EPS])
        cylinder(d = d, h = plate_t + 2*EPS, $fn = HOLE_FN);
    translate([0, 0, plate_t - ENTRY_C])
        cylinder(d1 = d, d2 = d + 2*c_r,
                 h = ENTRY_C + EPS, $fn = HOLE_FN);
}

module hole_grid_chamfered(d, plate_t) {
    for (r = [0:N-1], c = [0:N-1])
        translate([BORDER + c*PITCH, BORDER + r*PITCH, 0])
            cap_hole_w_chamfer(d, plate_t);
}

module four_corners() {
    s = PLATE_SIZE - BOLT_POS;
    for (p = [[BOLT_POS, BOLT_POS], [s, BOLT_POS],
              [BOLT_POS, s       ], [s, s        ]])
        translate([p.x, p.y, 0]) children();
}

module four_mid_edges() {
    c = PLATE_SIZE / 2;
    s = PLATE_SIZE - EDGE_OFF;
    for (p = [[c, EDGE_OFF], [c, s], [EDGE_OFF, c], [s, c]])
        translate([p.x, p.y, 0]) children();
}

module base_plate(t, sz = PLATE_SIZE, chamfer = true) {
    if (chamfer) {
        union() {
            linear_extrude(t - CHAMFER)
                offset(r = CORNER_R) offset(r = -CORNER_R) square([sz, sz]);
            translate([0, 0, t - CHAMFER])
                linear_extrude(CHAMFER, scale = (sz - 2*CHAMFER) / sz)
                    offset(r = CORNER_R) offset(r = -CORNER_R) square([sz, sz]);
        }
    } else {
        linear_extrude(t)
            offset(r = CORNER_R) offset(r = -CORNER_R) square([sz, sz]);
    }
}

module align_holes() {
    four_mid_edges()
        translate([0, 0, -EPS])
            cylinder(d = ALIGN_D, h = PLATE_SIZE, $fn = 32);
}

module nut_pocket(from_z) {
    translate([0, 0, from_z])
        rotate([0, 0, 30])
            cylinder(d = M4_NUT_FF / cos(30),
                     h = M4_NUT_H + EPS, $fn = 6);
}


// ═══════════════════════════════════════════════════════════════
//   § 1a  BODY BASE  (düz alt tabla)
//
//   · Deliksiz, sağlam, masaya düz oturur
//   · 4 köşede M4 hex somun cebi (ALTTAN press-fit)
//   · 4 köşede yay kılavuz posti
//   · Alt 4 köşe silikon ped reses
// ═══════════════════════════════════════════════════════════════
module body_base() {
    difference() {
        base_plate(BASE_T);

        four_corners() {
            translate([0, 0, -EPS])
                cylinder(d = M4_CLEAR,
                         h = BASE_T + 2*EPS, $fn = 36);
            nut_pocket(-EPS);
        }

        four_corners()
            translate([0, 0, -EPS])
                cylinder(d = 14, h = 1.2, $fn = 48);

        align_holes();
    }

    four_corners()
        translate([0, 0, BASE_T])
            cylinder(d = SPR_GUIDE_D,
                     h = SPR_GUIDE_H, $fn = 36);
}


// ═══════════════════════════════════════════════════════════════
//   § 1b  BODY HOLES  (100 delikli üst tabla)
//
//   · 100 × BODY_HOLE (6.93 mm) + giriş pahı
//   · Gövde 14.3 mm, plaka 10 mm → 4.3 mm taşar (toz dolumu)
//   · 4 köşede M4 flush counterbore + alt yay cebi
// ═══════════════════════════════════════════════════════════════
module body_holes() {
    difference() {
        base_plate(TOP_T);

        hole_grid_chamfered(BODY_HOLE, TOP_T);

        four_corners() {
            translate([0, 0, -EPS])
                cylinder(d = M4_CLEAR,
                         h = TOP_T + 2*EPS, $fn = 36);
            translate([0, 0, TOP_T - M4_HEAD_H])
                cylinder(d = M4_HEAD_D,
                         h = M4_HEAD_H + EPS, $fn = 48);
            translate([0, 0, -EPS])
                cylinder(d = SPR_SEAT_D,
                         h = 4.5, $fn = 48);
        }

        align_holes();
    }
}


// ═══════════════════════════════════════════════════════════════
//   § 2  MIDDLE PLATE  (separator)
//
//   SEP_HOLE = BODY_OD + 0.20 = 6.83 mm
//   → gövde (6.63 mm) geçer ✓  /  kapak (6.91 mm) yakalanır ✓
// ═══════════════════════════════════════════════════════════════
module middle_plate() {
    STEP_H   = 4.0;
    SEP_HOLE = BODY_OD + 0.20;   // 6.83 mm
    step_c_r = 0.8;

    difference() {
        base_plate(PLATE_T);

        for (r = [0:N-1], c = [0:N-1])
            translate([BORDER + c*PITCH, BORDER + r*PITCH, 0]) {
                translate([0, 0, -EPS])
                    cylinder(d = SEP_HOLE,
                             h = PLATE_T - STEP_H + EPS, $fn = HOLE_FN);
                translate([0, 0, PLATE_T - STEP_H - step_c_r])
                    cylinder(d1 = SEP_HOLE, d2 = CAP_HOLE,
                             h = step_c_r * 2, $fn = HOLE_FN);
                translate([0, 0, PLATE_T - STEP_H + step_c_r])
                    cylinder(d = CAP_HOLE,
                             h = STEP_H - step_c_r + EPS, $fn = HOLE_FN);
                translate([0, 0, PLATE_T - ENTRY_C])
                    cylinder(d1 = CAP_HOLE,
                             d2 = CAP_HOLE + 2*ENTRY_C*tan(ENTRY_ANGLE),
                             h = ENTRY_C + EPS, $fn = HOLE_FN);
            }

        align_holes();
    }
}


// ═══════════════════════════════════════════════════════════════
//   § 3  CAPPING PLATE
//
//   CAP_POCKET = CAP_L - 1.5 = 8.5 mm → kapak 1.5 mm taşar
//   Huni girişi Ø11 mm
// ═══════════════════════════════════════════════════════════════
module capping_plate() {
    CAP_POCKET = CAP_L - 1.5;   // 8.5 mm
    FUNNEL_D   = 11.0;

    difference() {
        base_plate(PLATE_T);

        for (r = [0:N-1], c = [0:N-1])
            translate([BORDER + c*PITCH, BORDER + r*PITCH, 0]) {
                translate([0, 0, PLATE_T - CAP_POCKET])
                    cylinder(d = CAP_HOLE,
                             h = CAP_POCKET + EPS, $fn = HOLE_FN);
                translate([0, 0, PLATE_T - 3])
                    cylinder(d1 = CAP_HOLE, d2 = FUNNEL_D,
                             h = 3 + EPS, $fn = HOLE_FN);
            }

        align_holes();
    }
}


// ═══════════════════════════════════════════════════════════════
//   § 4  FRAME PLATE
// ═══════════════════════════════════════════════════════════════
module frame_plate() {
    HALF     = PLATE_T / 2;
    FUNNEL_D = 11.0;
    inner    = PLATE_SIZE - 2*FRAME_RIM;

    union() {
        difference() {
            base_plate(PLATE_T);

            for (r = [0:N-1], c = [0:N-1])
                translate([BORDER + c*PITCH, BORDER + r*PITCH, 0]) {
                    translate([0, 0, -EPS])
                        cylinder(d = BODY_HOLE,
                                 h = HALF + EPS, $fn = HOLE_FN);
                    translate([0, 0, HALF - 0.8])
                        cylinder(d1 = BODY_HOLE, d2 = CAP_HOLE,
                                 h = 1.6, $fn = HOLE_FN);
                    translate([0, 0, HALF + 0.8 - EPS])
                        cylinder(d = CAP_HOLE,
                                 h = HALF - 0.8 + EPS, $fn = HOLE_FN);
                    translate([0, 0, PLATE_T - 3])
                        cylinder(d1 = CAP_HOLE, d2 = FUNNEL_D,
                                 h = 3 + EPS, $fn = HOLE_FN);
                }

            align_holes();
        }

        translate([0, 0, PLATE_T - EPS])
            difference() {
                base_plate(FRAME_H, chamfer = false);
                translate([FRAME_RIM, FRAME_RIM, -EPS])
                    linear_extrude(FRAME_H + 2*EPS)
                        offset(r = max(CORNER_R - 1, 0.5))
                            offset(r = -max(CORNER_R - 1, 0.5))
                                square([inner, inner]);
            }
    }
}


// ═══════════════════════════════════════════════════════════════
//   § 5  SPILL GUARD
// ═══════════════════════════════════════════════════════════════
module spill_guard() {
    inner = PLATE_SIZE - 2*SPILL_W;
    difference() {
        base_plate(SPILL_H, chamfer = false);
        translate([SPILL_W, SPILL_W, -EPS])
            linear_extrude(SPILL_H + 2*EPS)
                offset(r = max(CORNER_R - 1, 0.5))
                    offset(r = -max(CORNER_R - 1, 0.5))
                        square([inner, inner]);
        align_holes();
    }
}


// ═══════════════════════════════════════════════════════════════
//   § 6  TAMPER
//
//   PEG_OD = 6.18 mm (kapsül 1 iç çapına uyumlu)
// ═══════════════════════════════════════════════════════════════
module tamper() {
    PEG_DEPTH = 10;
    HW = 110; HD = 30; HH = 34;

    union() {
        difference() {
            base_plate(PLATE_T);
            align_holes();
        }

        for (r = [0:N-1], c = [0:N-1])
            translate([BORDER + c*PITCH, BORDER + r*PITCH, 0]) {
                translate([0, 0, -PEG_DEPTH])
                    cylinder(d = PEG_OD, h = PEG_DEPTH, $fn = HOLE_FN);
                translate([0, 0, -PEG_DEPTH])
                    intersection() {
                        scale([1, 1, 0.5])
                            sphere(d = PEG_OD, $fn = HOLE_FN);
                        translate([0, 0, -PEG_OD/2])
                            cylinder(d = PEG_OD + 1,
                                     h = PEG_OD/2, $fn = HOLE_FN);
                    }
            }

        translate([(PLATE_SIZE-HW)/2, (PLATE_SIZE-HD)/2, PLATE_T])
            hull() {
                for (x = [8, HW-8], y = [8, HD-8])
                    translate([x, y, 0]) cylinder(d = 12, h = 2, $fn = 48);
                for (x = [15, HW-15])
                    translate([x, HD/2, HH-10]) sphere(d = 16, $fn = 48);
            }
    }
}


// ═══════════════════════════════════════════════════════════════
//   § 7  SPREADER  (96 mm × 135 mm — tüm numara için aynı)
// ═══════════════════════════════════════════════════════════════
module spreader() {
    T         = 4.5;
    W         = 96;
    H         = 135;
    TAPER     = 12;
    R         = 3;
    GROOVE_W  = 1.5;
    GROOVE_D  = 1.2;
    GROOVE_N  = 7;
    GROOVE_GAP = (W - 2*TAPER - GROOVE_N*GROOVE_W) / (GROOVE_N + 1);

    difference() {
        linear_extrude(T)
            offset(r = R) offset(r = -R)
                polygon([[0,0],[W,0],[W-TAPER,H],[TAPER,H]]);
        translate([-2, -EPS, T])
            rotate([28, 0, 0]) cube([W + 4, 18, 14]);
        for (i = [0:GROOVE_N-1]) {
            x = TAPER + GROOVE_GAP + i*(GROOVE_W + GROOVE_GAP);
            translate([x, R, T - GROOVE_D])
                cube([GROOVE_W, H - 2*R, GROOVE_D + EPS]);
        }
    }
}


// ═══════════════════════════════════════════════════════════════
//   § 8  TPU SPRING
// ═══════════════════════════════════════════════════════════════
module tpu_spring() {
    difference() {
        cylinder(d = SPR_OD - 0.4, h = SPR_FREE, $fn = 48);
        translate([0, 0, -EPS])
            cylinder(d = M4_CLEAR, h = SPR_FREE + 2*EPS, $fn = 32);
        linear_extrude(SPR_FREE, twist = 720, slices = 120, convexity = 10)
            translate([(SPR_OD - 0.4)/4, 0])
                square([(SPR_OD - 0.4)/2 + 1, 0.8], center = true);
    }
}


// ═══════════════════════════════════════════════════════════════
//   § 9  ALIGNMENT PIN
// ═══════════════════════════════════════════════════════════════
module alignment_pin() {
    HEAD_D = 10;
    union() {
        cylinder(d1 = 3.15, d2 = 2.90, h = PIN_L, $fn = 28);
        translate([0, 0, PIN_L])
            cylinder(d1 = 3.15, d2 = HEAD_D, h = 2.5, $fn = 36);
        translate([0, 0, PIN_L + 2.5]) {
            cylinder(d = HEAD_D, h = 6, $fn = 36);
            translate([0, 0, 6])
                intersection() {
                    sphere(d = HEAD_D, $fn = 36);
                    cylinder(d = HEAD_D, h = HEAD_D/2, $fn = 36);
                }
        }
    }
}


// ═══════════════════════════════════════════════════════════════
//   DISPATCH
// ═══════════════════════════════════════════════════════════════
if      (PART == "body_base")     body_base();
else if (PART == "body_holes")    body_holes();
else if (PART == "middle_plate")  middle_plate();
else if (PART == "capping")       capping_plate();
else if (PART == "frame")         frame_plate();
else if (PART == "spill_guard")   spill_guard();
else if (PART == "tamper")        tamper();
else if (PART == "spreader")      spreader();
else if (PART == "tpu_spring")    tpu_spring();
else if (PART == "alignment_pin") alignment_pin();
else if (PART == "all") {
    G = 188;
    translate([  0,   0,           0]) body_base();
    translate([  0,   0, BASE_T + 14]) body_holes();
    translate([  G,   0, 0]) middle_plate();
    translate([2*G,   0, 0]) capping_plate();
    translate([  0,   G, 0]) frame_plate();
    translate([  G,   G, 0]) spill_guard();
    translate([2*G,   G, 0]) tamper();
    translate([  0, 2*G, 0]) spreader();
    translate([  G, 2*G, 0]) tpu_spring();
    translate([G+40, 2*G, 0]) alignment_pin();
}
