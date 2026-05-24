// ═══════════════════════════════════════════════════════════════
//   KAPSÜL DOLUM APARATI  —  Numara 0  (V9 · İkili Body Plate)
//   100 delik · 10×10 grid · 170×170 mm tabla
//   Bambu Lab P2S · PETG · 0.4 mm nozzle · 4 perimeter
//
//   ─── PARÇALAR ────────────────────────────────────────────────
//   body_base    — düz alt tabla (masaya oturur, ayak yok)
//   body_holes   — delikli üst tabla (yaylar üzerinde yüzer)
//   middle_plate — ayırma / separator plakası
//   capping      — kapak tutma plakası
//   frame        — hizalama çerçevesi
//   spill_guard  — toz dökülme koruma çerçevesi
//   spreader     — toz yayma spatulası (96 mm)
//   tamper       — toz sıkıştırma tamper
//   tpu_spring   — basılabilir TPU yay (metal yay alternatifi)
//   alignment_pin— hizalama pimi (×4–8)
//   all          — tüm parçalar yanda (referans görünüm)
//
//   ─── BODY PLATE ÇALIŞMA PRENSİBİ ────────────────────────────
//
//   body_base  ←─ alt, sabit, masaya düz oturur
//      │
//    [yay OD 8 mm, serbest 18 mm — ikisi arasında görünür]
//      │
//   body_holes ←─ üst, 100 delikli, yay üzerinde yüzer
//
//   M4 × 30 mm buton başlı cıvata:
//     • Baş  → body_holes üst yüzeyinde flush counterbore
//     • Şaft → body_holes içinden geçer (10 mm)
//     • Yay  → şaft etrafında, iki tabla arası boşlukta
//     • Uç   → body_base içindeki hex somun cebine vidalanır
//
//   Yay hareketi: body_holes ~8 mm bastırılabilir (kaplama anı)
//   Bırakılınca yay tableyi yukarı iter → kapsüller serbest kalır
//
//   ─── DONANIM (her köşe ×4) ───────────────────────────────────
//   M4 × 30 mm buton başlı cıvata (ISO 7380 · 304 paslanmaz)
//   M4 altıgen somun  (body_base içine press-fit, alttan)
//   Sıkıştırma yayı  OD 8 mm · tel Ø 0.8 mm · serbest L 18 mm
//     (montaj öncesi yay cıvata şaftına geçirilir)
//
//   ─── NUMARA 0 KAPSÜL ÖLÇÜLERİ (Capsugel/Lonza spec) ─────────
//   Kapak  OD 7.65 mm · L 11.1 mm
//   Gövde  OD 7.34 mm · ID 7.13 mm · L 15.9 mm
//   Kilitli toplam ≈ 22.2 mm  ·  Dolum hacmi 0.68 ml
//
//   ─── MONTAJ SIRASI (alttan üste) ────────────────────────────
//   1. body_base masaya düz koyulur (köşelerde silikon ped)
//   2. 4× yay her köşedeki kılavuz posta geçirilir
//   3. body_holes üstten indirilir, cıvata delikleri hizalanır
//   4. 4× M4×30 cıvata üstten geçirilip body_base somun cebine
//      vidalanır; yay ~4 mm ön-sıkıştırma olana dek sıkılır
//   5. body_holes elle bastırılınca ~8 mm iner, bırakılınca çıkar
//   6. middle_plate, frame, capping sırası ile üste eklenir
// ═══════════════════════════════════════════════════════════════

// ─── HANGİ PARÇA RENDERLENSİN ──────────────────────────────────
PART = "body_base";
//  "body_base"   "body_holes"  "middle_plate"  "capping"
//  "frame"       "spill_guard" "spreader"      "tamper"
//  "tpu_spring"  "alignment_pin"               "all"


// ═══════════════════════════════════════════════════════════════
//   § A  ANA PARAMETRELER
// ═══════════════════════════════════════════════════════════════

PITCH      = 14.5;   // delik merkez-merkez mesafesi (mm)
BORDER     = 19.75;  // plaka kenarı → ilk delik merkezi
BOLT_POS   = 12;     // köşeden cıvata merkezi — body_base ve
                     //   body_holes aynı pozisyon → konSANTRİK
FRAME_RIM  = 9;      // çerçeve iç duvar kalınlığı (mm)


// ═══════════════════════════════════════════════════════════════
//   § B  KAPSÜL VE PLAKA GEOMETRİSİ
// ═══════════════════════════════════════════════════════════════

PLATE_SIZE = 170;    // kare tabla kenar uzunluğu
N          = 10;     // eksen başına delik sayısı
CORNER_R   = 4;      // köşe yuvarlatma yarıçapı
CHAMFER    = 0.8;    // üst kenar pah yüksekliği

// ─── İkili body plate kalınlıkları ──────────────────────────────
BASE_T  = 8;    // body_base kalınlığı (sabit alt tabla)
TOP_T   = 10;   // body_holes kalınlığı (kapsül delikli üst tabla)
                //   Gövde L=15.9 mm, TOP_T=10 mm → 5.9 mm taşar (toz dolumu için)

// ─── Diğer plakalar ─────────────────────────────────────────────
PLATE_T = 12;   // middle, capping, frame, tamper kalınlığı

// ─── Numara 0 kapsül (Capsugel standart) ────────────────────────
CAP_OD    = 7.65;
BODY_OD   = 7.34;
BODY_ID   = 7.13;
CAP_L     = 11.1;
BODY_L    = 15.9;
TOL       = 0.30;   // PETG kayar geçme toleransı

CAP_HOLE  = CAP_OD  + TOL;   // 7.95 mm
BODY_HOLE = BODY_OD + TOL;   // 7.64 mm
PEG_OD    = BODY_ID - 0.25;  // 6.88 mm tamper peg

// Giriş pahı (kapsül yüklemeyi kolaylaştırır)
ENTRY_C     = 1.2;
ENTRY_ANGLE = 30;

// ─── M4 donanım ─────────────────────────────────────────────────
M4_CLEAR   = 4.5;   // şaft geçme deliği
M4_HEAD_D  = 9.2;   // buton baş counterbore çapı
M4_HEAD_H  = 3.2;   // buton baş yüksekliği
M4_NUT_FF  = 7.2;   // hex somun düz-düz (press-fit toleranslı)
M4_NUT_H   = 3.5;   // hex somun yüksekliği

// ─── Yay (iki tabla ARASI — görünür) ────────────────────────────
SPR_OD       = 8.0;    // yay dış çapı
SPR_FREE     = 18.0;   // yay serbest boyu
SPR_SEAT_D   = SPR_OD + 2.0;   // yay oturma cebinin çapı (10 mm)
SPR_GUIDE_D  = 5.5;    // kılavuz post çapı (yay iç çapı ≈ 6.4 mm)
SPR_GUIDE_H  = 6.0;    // kılavuz post yüksekliği (body_base üstüne çıkar)

// ─── Hizalama pimi ──────────────────────────────────────────────
EDGE_OFF  = 6;
ALIGN_D   = 3.3;
PIN_L     = 52;

// ─── Toz koruma çerçevesi ────────────────────────────────────────
SPILL_W   = 10;
SPILL_H   = 18;

// ─── Çerçeve plakası rim ─────────────────────────────────────────
FRAME_H   = 12;

// ─── Render kalitesi ─────────────────────────────────────────────
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

// Silindir + üst giriş pahı (tek çağrı)
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

// 4 köşe — body_base ve body_holes aynı BOLT_POS → konSANTRİK
module four_corners() {
    s = PLATE_SIZE - BOLT_POS;
    for (p = [[BOLT_POS, BOLT_POS],
              [s,        BOLT_POS],
              [BOLT_POS, s       ],
              [s,        s       ]])
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
                linear_extrude(CHAMFER, scale = (sz - 2*CHAMFER)/sz)
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

// Hex somun cebi — from_z'den itibaren yukarı açılır
module nut_pocket(from_z) {
    translate([0, 0, from_z])
        rotate([0, 0, 30])
            cylinder(d = M4_NUT_FF / cos(30),
                     h = M4_NUT_H + EPS, $fn = 6);
}


// ═══════════════════════════════════════════════════════════════
//   § 1a  BODY BASE  (düz alt tabla — masaya oturur)
//
//   · Deliksiz, düz, sağlam — tüm yükü taşır
//   · Her köşede M4 hex somun cebi (ALTTAN press-fit)
//     Cıvata aşağıdan değil yukarıdan geçip buraya vidalanır
//   · Her köşede yay kılavuz posti (SPR_GUIDE_D × SPR_GUIDE_H)
//     Post yayı ortalayarak baskı-kalkma sırasında kaymayı önler
//   · Alt yüzeyde 4 köşe silikon ped reses (kayma önleme)
//   · Kenar hizalama pimi delikleri
//
//   Montaj notu:
//     Hex somun body_base alt yüzeyinden press-fit ile girilir.
//     Cıvata body_holes üstünden inerek şuraya vidalanır.
// ═══════════════════════════════════════════════════════════════
module body_base() {
    difference() {
        base_plate(BASE_T);

        // ── Köşe: M4 şaft + hex somun cebi (alttan) ───────────
        four_corners() {
            // Şaft geçme deliği (tam kalınlık)
            translate([0, 0, -EPS])
                cylinder(d = M4_CLEAR,
                         h = BASE_T + 2*EPS, $fn = 36);
            // Hex somun cebi alttan — M4_NUT_H derinliğinde
            nut_pocket(-EPS);
        }

        // ── Alt yüzey silikon ped reser (4 köşe) ───────────────
        four_corners()
            translate([0, 0, -EPS])
                cylinder(d = 14, h = 1.2, $fn = 48);

        // ── Kenar hizalama pimi delikleri ──────────────────────
        align_holes();
    }

    // ── Yay kılavuz postları (üst yüzeyde, body_holes altına girer)
    //    Post yayı konumlar; cıvata da yayın ortasından geçer
    four_corners()
        translate([0, 0, BASE_T])
            cylinder(d = SPR_GUIDE_D,
                     h = SPR_GUIDE_H, $fn = 36);
}


// ═══════════════════════════════════════════════════════════════
//   § 1b  BODY HOLES  (100 delikli üst tabla — yay üzerinde yüzer)
//
//   · body_base üstünde 4 köşe cıvata + yay ile asılıdır
//   · 100 adet BODY_HOLE (7.64 mm) — kapsül gövdeler açık taraf
//     yukarı düşürülür; TOP_T=10 mm, gövde 5.9 mm taşar
//   · Her köşede:
//     — Üstte M4 buton baş flush counterbore (cıvata başı görünmez)
//     — Altta yay oturma cebi (SPR_SEAT_D) — yay üst ucu oturur
//   · Bastırılınca yay sıkışır, body_base'e yaklaşır (~8 mm hareket)
//   · Bırakılınca yay üste iter → kapsül gövdeler serbest
// ═══════════════════════════════════════════════════════════════
module body_holes() {
    difference() {
        base_plate(TOP_T);

        // ── 100 kapsül gövde deliği (pah dahil) ───────────────
        hole_grid_chamfered(BODY_HOLE, TOP_T);

        // ── Köşe cıvata delikleri ──────────────────────────────
        four_corners() {
            // M4 şaft geçme deliği (tam kalınlık)
            translate([0, 0, -EPS])
                cylinder(d = M4_CLEAR,
                         h = TOP_T + 2*EPS, $fn = 36);

            // Buton baş counterbore — üst yüzeyde flush
            // Cıvata başı tabla yüzeyiyle aynı seviyede
            translate([0, 0, TOP_T - M4_HEAD_H])
                cylinder(d = M4_HEAD_D,
                         h = M4_HEAD_H + EPS, $fn = 48);

            // Yay oturma cebi — alt yüzeyde (yay üst ucu buraya oturur)
            // Kılavuz post bu cep içine girer → yay ikili konumlanır
            translate([0, 0, -EPS])
                cylinder(d = SPR_SEAT_D,
                         h = 4.5, $fn = 48);
        }

        // ── Kenar hizalama pimi delikleri ──────────────────────
        align_holes();
    }
}


// ═══════════════════════════════════════════════════════════════
//   § 2  MIDDLE PLATE  (separator — basamaklı delik)
//
//   · body_holes üstüne oturur
//   · SEP_HOLE = BODY_OD + 0.20 mm (7.54 mm)
//     → gövde (7.34 mm) geçer ✓  /  kapak (7.65 mm) yakalanır ✓
//   · Tabla yatay kaydırılınca kapaklar gövdeden ayrılır
// ═══════════════════════════════════════════════════════════════
module middle_plate() {
    STEP_H   = 4.5;
    SEP_HOLE = BODY_OD + 0.20;  // 7.54 mm
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
//   § 3  CAPPING PLATE  (kapak tutma plakası)
//
//   · Kapaklar açık taraf yukarı, bu plakadaki cebe oturur
//   · Cep derinliği = CAP_L − 1.5 = 9.6 mm → kapak 1.5 mm taşar
//   · Üstte huni girişi (Ø12 mm) → kolay yükleme
//   · Alt yüzey kapalı — kapak içinden çıkamaz
// ═══════════════════════════════════════════════════════════════
module capping_plate() {
    CAP_POCKET = CAP_L - 1.5;  // 9.6 mm
    FUNNEL_D   = 12.0;

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
//   § 4  FRAME PLATE  (hizalama çerçeve plakası)
//
//   · Alt yarı BODY_HOLE, üst yarı CAP_HOLE + huni
//   · Üste FRAME_H yüksekliğinde çerçeve duvarı (FRAME_RIM genişlik)
// ═══════════════════════════════════════════════════════════════
module frame_plate() {
    HALF     = PLATE_T / 2;
    FUNNEL_D = 12.0;
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
//   § 5  SPILL GUARD  (toz dökülme koruması)
//
//   · Açık çerçeve, içi ve altı boş
//   · Dolum sırasında body_holes üstüne oturur
//   · Kenar hizalama pimi delikleri
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
//   § 6  TAMPER  (toz sıkıştırma)
//
//   · 100 peg (PEG_OD 6.88 mm) aşağıya; yarı-küresel uçlar
//   · Ergonomik köprü tutamaç
// ═══════════════════════════════════════════════════════════════
module tamper() {
    PEG_DEPTH = 11;
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
//   § 7  SPREADER  (toz yayma spatulası)
//
//   · Genişlik 96 mm (referans ölçü), yükseklik 135 mm
//   · Ön kenar 28° pahı — tek geçişte temiz yayma
//   · Üst yüzeyde 7 boyuna oluk — toz akışını düzenler
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
//   § 8  TPU SPRING  (basılabilir yay — 95A TPU)
//
//   · OD 7.6 mm (metal yay ile aynı dış çap aralığı)
//   · Sarmal slot yay esnekliği sağlar; 720° / 120 dilim
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
//   § 9  ALIGNMENT PIN  (hizalama pimi — ×4–8)
//
//   · Konik şaft → 3.3 mm deliklere kendi merkezlenir
//   · Mantar baş → kolay kavrama
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
    // Body assembly: yan yana (ikisi birlikte görülür)
    translate([  0,   0, 0]) body_base();
    translate([  0,   0, BASE_T + 14]) body_holes();  // yay boşluğuyla
    // Diğer plakalar
    translate([  G,   0, 0]) middle_plate();
    translate([2*G,   0, 0]) capping_plate();
    translate([  0,   G, 0]) frame_plate();
    translate([  G,   G, 0]) spill_guard();
    translate([2*G,   G, 0]) tamper();
    translate([  0, 2*G, 0]) spreader();
    translate([  G, 2*G, 0]) tpu_spring();
    translate([G+40, 2*G, 0]) alignment_pin();
}
