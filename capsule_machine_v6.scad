// ═══════════════════════════════════════════════════════════════
//   KAPSÜL DOLUM APARATI  —  Numara 0  (V8 · Temiz Geometri)
//   100 delik · 10×10 grid · 170×170 mm tabla
//   Bambu Lab P2S · PETG · 0.4 mm nozzle · 4 perimeter
//
//   ─── PARÇALAR ────────────────────────────────────────────────
//   body_plate   — kapsül gövde tepsisi (yaylı ayaklı alt tabla)
//   foot         — yaylı ayak (×4)
//   middle_plate — ayırma / separator plakası
//   capping      — kapak tutma plakası
//   frame        — hizalama çerçevesi (tüm plakaları hizalar)
//   spill_guard  — toz dökülme koruma çerçevesi
//   spreader     — toz yayma spatulası
//   tamper       — toz sıkıştırma tamper
//   tpu_spring   — basılabilir TPU yay (metal yay alternatifi)
//   alignment_pin— hizalama pimi (×4–8)
//   all          — tüm parçalar yanda
//
//   ─── DONANIM (her köşe için ×4) ─────────────────────────────
//   M4 × 35 mm buton başlı cıvata  (ISO 7380 · 304 paslanmaz)
//   M4 altıgen somun               (ayak içine press-fit)
//   Sıkıştırma yayı:  OD 8 mm · tel Ø 0.8 mm · serbest L 20 mm
//     (yay cıvata şaftı etrafında, tabla altı ile ayak arasında
//      görünür şekilde çalışır — referans ürün görseli gibi)
//
//   ─── NUMARA 0 KAPSÜL ÖLÇÜLERİ (Capsugel/Lonza spec) ─────────
//   Kapak  OD 7.65 mm · L 11.1 mm
//   Gövde  OD 7.34 mm · ID 7.13 mm · L 15.9 mm
//   Kilitli toplam ≈ 22.2 mm
//
//   ─── MONTAJ SIRASI (alttan üste) ────────────────────────────
//   1. foot ×4  → yay cıvata şaftına geçer, body_plate'ten geçer
//   2. body_plate  → kapsül gövdeleri açık taraf yukarı düşer
//   3. middle_plate → üstten oturur, kapakları ayırır
//   4. frame   → tüm tablaları çerçeveler
//   5. capping → kapakları tutar
//   6. spill_guard → dolum sırasında tozu tutar
// ═══════════════════════════════════════════════════════════════

// ─── HANGİ PARÇA RENDERLENSİN ──────────────────────────────────
PART = "body_plate";
//  "body_plate"  "foot"    "middle_plate"  "capping"
//  "frame"       "spill_guard"  "spreader" "tamper"
//  "tpu_spring"  "alignment_pin"           "all"


// ═══════════════════════════════════════════════════════════════
//   § A  ANA PARAMETRELER  (yalnızca burası düzenlenir)
// ═══════════════════════════════════════════════════════════════

PITCH       = 14.5;   // delik merkez-merkez mesafesi (mm)
BORDER      = 19.75;  // plaka kenarı → ilk delik merkezi
                      //   = (170 − 9×14.5) / 2 = 19.75

FOOT_POS    = 12;     // köşeden cıvata/ayak merkezi uzaklığı (mm)
                      //   dört köşede cıvata ve ayak KONSANTRİK

FRAME_RIM   = 9;      // çerçeve iç duvar kalınlığı (mm)


// ═══════════════════════════════════════════════════════════════
//   § B  SABİT GEOMETRİ
// ═══════════════════════════════════════════════════════════════

PLATE_SIZE  = 170;    // kare tabla kenar uzunluğu
N           = 10;     // eksen başına delik sayısı
PLATE_T     = 12;     // standart tabla kalınlığı
CORNER_R    = 4;      // köşe yuvarlatma yarıçapı
CHAMFER     = 0.8;    // üst kenar pah yüksekliği

// ─── Numara 0 kapsül delikleri ──────────────────────────────────
//   TOL = 0.30 mm: PETG için iyi kayan geçme
CAP_OD      = 7.65;
BODY_OD     = 7.34;
BODY_ID     = 7.13;
CAP_L       = 11.1;   // kapak boyu (kilitli)
BODY_L      = 15.9;   // gövde boyu (kilitli)
TOL         = 0.30;

CAP_HOLE    = CAP_OD  + TOL;  // 7.95 mm — kapak geçme deliği
BODY_HOLE   = BODY_OD + TOL;  // 7.64 mm — gövde geçme deliği
PEG_OD      = BODY_ID - 0.25; // 6.88 mm — tamper peg çapı

// Delik giriş pahı (kapsül yüklemeyi kolaylaştırır)
ENTRY_C     = 1.2;    // giriş pahı derinliği (mm)
ENTRY_ANGLE = 30;     // pah açısı (°)

// ─── M4 donanım ─────────────────────────────────────────────────
M4_CLEAR    = 4.5;    // cıvata şaftı geçme deliği
M4_HEAD_D   = 9.2;    // buton baş counterbore çapı
M4_HEAD_H   = 3.2;    // buton baş yüksekliği
M4_NUT_FF   = 7.2;    // hex somun düz-düz (toleranslı)
M4_NUT_H    = 3.5;    // hex somun yüksekliği

// ─── Yay (dıştan görünür, cıvata etrafında) ─────────────────────
SPR_OD      = 8.0;    // yay dış çapı
SPR_FREE    = 20.0;   // yay serbest boyu
SPR_ID      = M4_CLEAR + 0.2; // yay iç çapı (cıvata üstünden geçer)
SPR_SEAT_D  = SPR_OD + 2.0;   // yay oturma cebinin çapı

// ─── Ayak ───────────────────────────────────────────────────────
FOOT_D      = 18;     // ayak dış çapı
FOOT_H      = 11;     // ayak yüksekliği

// ─── Hizalama pimi ──────────────────────────────────────────────
EDGE_OFF    = 6;      // kenardan hizalama deliği merkezi
ALIGN_D     = 3.3;    // hizalama pimi geçme deliği
PIN_L       = 52;     // pim uzunluğu

// ─── Toz koruma çerçevesi ────────────────────────────────────────
SPILL_W     = 10;     // duvar kalınlığı
SPILL_H     = 18;     // duvar yüksekliği

// ─── Çerçeve plakası ─────────────────────────────────────────────
FRAME_H     = 12;     // yükseltilmiş çerçeve rim yüksekliği

// ─── Render kalitesi ─────────────────────────────────────────────
$fa = 0.8;
$fs = 0.3;
EPS     = 0.15;       // z-fighting önleme epsilonu
HOLE_FN = 80;         // kapsül delikleri için kenar sayısı (pürüzsüz)


// ═══════════════════════════════════════════════════════════════
//   § C  YARDIMCI MODÜLLER
// ═══════════════════════════════════════════════════════════════

// 10×10 grid — delik silindirleri
module hole_grid(d, h, z = 0) {
    for (r = [0:N-1], c = [0:N-1])
        translate([BORDER + c*PITCH, BORDER + r*PITCH, z])
            cylinder(d = d, h = h, $fn = HOLE_FN);
}

// Kapsül deliği: silindir + üst giriş pahı (tek çağrıda)
// z=0 tabanı plakanın alt yüzeyidir
module cap_hole_w_chamfer(d, plate_t) {
    // Ana silindir
    translate([0, 0, -EPS])
        cylinder(d = d, h = plate_t + 2*EPS, $fn = HOLE_FN);
    // Üst giriş pahı
    c_r = ENTRY_C * tan(ENTRY_ANGLE);
    translate([0, 0, plate_t - ENTRY_C])
        cylinder(d1 = d, d2 = d + 2*c_r,
                 h = ENTRY_C + EPS, $fn = HOLE_FN);
}

// 10×10 grid — pah dahil delikler
module hole_grid_chamfered(d, plate_t) {
    for (r = [0:N-1], c = [0:N-1])
        translate([BORDER + c*PITCH, BORDER + r*PITCH, 0])
            cap_hole_w_chamfer(d, plate_t);
}

// Dört köşe konumu — cıvata ve ayak KONSANTRİK (aynı merkez)
module four_corners() {
    s = PLATE_SIZE - FOOT_POS;
    for (p = [[FOOT_POS, FOOT_POS],
              [s,        FOOT_POS],
              [FOOT_POS, s       ],
              [s,        s       ]])
        translate([p.x, p.y, 0]) children();
}

// Dört kenar ortası — hizalama pimi delikleri
module four_mid_edges() {
    c = PLATE_SIZE / 2;
    s = PLATE_SIZE - EDGE_OFF;
    for (p = [[c,        EDGE_OFF],
              [c,        s       ],
              [EDGE_OFF, c       ],
              [s,        c       ]])
        translate([p.x, p.y, 0]) children();
}

// Yuvarlatılmış köşeli düz tabla (üst pah opsiyonlu)
module base_plate(t = PLATE_T, sz = PLATE_SIZE, chamfer = true) {
    profile = offset(r = CORNER_R) offset(r = -CORNER_R) square([sz, sz]);
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

// Hizalama pimi geçme delikleri (kenar ortaları, tam boy)
module align_holes() {
    four_mid_edges()
        translate([0, 0, -EPS])
            cylinder(d = ALIGN_D, h = PLATE_SIZE, $fn = 32);
}

// M4 hex somun cep (Z konumu yukarıdan ölçülür)
module nut_pocket(from_z) {
    translate([0, 0, from_z])
        rotate([0, 0, 30])
            cylinder(d = M4_NUT_FF / cos(30),
                     h = M4_NUT_H + EPS, $fn = 6);
}


// ═══════════════════════════════════════════════════════════════
//   § 1  BODY PLATE  (kapsül gövde tepsisi — en alt tabla)
//
//   Çalışma prensibi:
//   · Kapsül gövdeleri (açık taraf yukarı) deliklerden düşürülür
//   · Gövde L = 15.9 mm, tabla = 12 mm → gövde üstten 3.9 mm taşar
//   · Toz gövdelere üstten doldurulur
//   · Tabla kapping üzerine çevrilip bastırılır →
//     yay ayaklar sıkışır, gövdeler kapak içine girer (kaplama)
//
//   Delik özellikleri:
//   · BODY_HOLE = 7.64 mm tam derinlik
//   · Üstte 1.2 mm×30° pah → kapsül yükleme kolaylaşır
//   · Alt yüzeyde yay oturma cebi (SPR_SEAT_D × 3.5 mm derin)
//
//   Köşe cıvata:
//   · Üstte M4 buton baş counterbore (flush)
//   · Alt yüzeyde yay oturma cebi (yay cıvata etrafında görünür)
// ═══════════════════════════════════════════════════════════════
module body_plate() {
    difference() {
        base_plate(PLATE_T);

        // ── 100 kapsül gövde deliği (pah dahil) ───────────────
        hole_grid_chamfered(BODY_HOLE, PLATE_T);

        // ── Köşe cıvata + yay oturma cebi ──────────────────────
        four_corners() {
            // M4 şaft geçme deliği — tam kalınlık
            translate([0, 0, -EPS])
                cylinder(d = M4_CLEAR,
                         h = PLATE_T + 2*EPS, $fn = 36);

            // Buton baş counterbore — üst yüzeyde flush
            translate([0, 0, PLATE_T - M4_HEAD_H])
                cylinder(d = M4_HEAD_D,
                         h = M4_HEAD_H + EPS, $fn = 48);

            // Yay oturma cebi — alt yüzeyde
            // Yay bu cep içinde başlar, ayak üst yüzeyinde biter
            translate([0, 0, -EPS])
                cylinder(d = SPR_SEAT_D,
                         h = 3.5, $fn = 48);
        }

        // ── Kenar hizalama pimi delikleri ──────────────────────
        align_holes();
    }
}


// ═══════════════════════════════════════════════════════════════
//   § 2  FOOT  (yaylı ayak — ×4 baskı)
//
//   · FOOT_D × FOOT_H silindir + alt geniş flange bileziği
//   · Üst yüzeyden hex somun press-fit cebi (cıvata buraya vidalanır)
//   · M4 şaft geçme deliği tam boydan
//   · Alt yüzeyden silikon ped reses (yapıştırılır, kaymayı önler)
//   · Alt kenar pahı — baskı ilk katmanı temiz olur
//
//   Yay yerleşimi:
//   · Cıvata yukarıdan body_plate'ten geçer
//   · Yay (OD 8 mm) cıvata şaftına geçirilir
//   · Cıvata ayak hex somun cebine vidalanır
//   · Yay body_plate alt yüzeyi ile ayak üst yüzeyi arasında görünür
// ═══════════════════════════════════════════════════════════════
module foot() {
    difference() {
        union() {
            // Ana silindir gövde
            cylinder(d = FOOT_D, h = FOOT_H, $fn = 64);
            // Alt genişletilmiş flange — oturma alanını artırır
            cylinder(d = FOOT_D + 5, h = 2.5, $fn = 64);
        }

        // M4 şaft geçme deliği (tam boy)
        translate([0, 0, -EPS])
            cylinder(d = M4_CLEAR,
                     h = FOOT_H + 2*EPS, $fn = 36);

        // Hex somun press-fit cebi (üstten)
        nut_pocket(FOOT_H - M4_NUT_H);

        // Alt silikon ped reses (Ø 12 mm, 1 mm derin)
        translate([0, 0, -EPS])
            cylinder(d = 12, h = 1.0 + EPS, $fn = 48);

        // Alt kenar pahı (baskı kalitesi için)
        translate([0, 0, -EPS])
            difference() {
                cylinder(d = FOOT_D + 7, h = 1.5, $fn = 64);
                translate([0, 0, -EPS])
                    cylinder(d1 = FOOT_D - 2,
                             d2 = FOOT_D + 5 + EPS,
                             h  = 1.5 + 2*EPS, $fn = 64);
            }
    }
}


// ═══════════════════════════════════════════════════════════════
//   § 3  MIDDLE PLATE  (ayırma plakası / separator)
//
//   Çalışma prensibi:
//   · Body plate üstüne oturur; delikler BASAMAKLIDIR:
//     — Üst 4.5 mm : CAP_HOLE (7.95 mm)  — kapak burada oturur
//     — Alt 7.5 mm : SEP_HOLE (7.54 mm)  — gövde bu bölümden geçer
//   · SEP_HOLE = BODY_OD + 0.20 mm
//     → gövde (7.34) geçer ✓  /  kapak (7.65) yakalanır ✓
//     → too-tight hatası önlenir; FDM toleransı gözetilir
//   · Tabla yatay kaydırılınca kapaklar gövdeden ayrılır
// ═══════════════════════════════════════════════════════════════
module middle_plate() {
    STEP_H   = 4.5;
    // Separator hole — body geçer, cap yakalanır
    // BODY_OD+0.20 → gövde boşluğu 0.10/kenar, kapak tutumu 0.055/kenar
    SEP_HOLE = BODY_OD + 0.20;  // 7.54 mm (size 0)
    step_c_r = 0.8;

    difference() {
        base_plate(PLATE_T);

        for (r = [0:N-1], c = [0:N-1])
            translate([BORDER + c*PITCH, BORDER + r*PITCH, 0]) {
                // Alt bölüm — gövde geçişi (SEP_HOLE — daraltılmış)
                translate([0, 0, -EPS])
                    cylinder(d = SEP_HOLE,
                             h = PLATE_T - STEP_H + EPS, $fn = HOLE_FN);
                // Basamak geçişi (konik — pürüzsüz)
                translate([0, 0, PLATE_T - STEP_H - step_c_r])
                    cylinder(d1 = SEP_HOLE,
                             d2 = CAP_HOLE,
                             h  = step_c_r * 2, $fn = HOLE_FN);
                // Üst bölüm — kapak oturması (CAP_HOLE)
                translate([0, 0, PLATE_T - STEP_H + step_c_r])
                    cylinder(d = CAP_HOLE,
                             h = STEP_H - step_c_r + EPS, $fn = HOLE_FN);
                // Üst giriş pahı
                translate([0, 0, PLATE_T - ENTRY_C])
                    cylinder(d1 = CAP_HOLE,
                             d2 = CAP_HOLE + 2*ENTRY_C*tan(ENTRY_ANGLE),
                             h  = ENTRY_C + EPS, $fn = HOLE_FN);
            }

        align_holes();
    }
}


// ═══════════════════════════════════════════════════════════════
//   § 4  CAPPING PLATE  (kapak tutma plakası)
//
//   · Kapaklar açık taraf YUKARI, bu plakadaki cebe oturur
//   · Cep derinliği = CAP_L − 1.5 mm → kapak 1.5 mm taşar
//     (gövde ile buluşma için yeterli rehberlik)
//   · Üstte geniş huni girişi → kapsül kapak yükleme kolaylaşır
//   · Alt yüzey düz ve kapalı — kapak içinden çıkamaz
// ═══════════════════════════════════════════════════════════════
module capping_plate() {
    // Kapak cep derinliği
    CAP_POCKET = CAP_L - 1.5;  // 9.6 mm
    FUNNEL_D   = 12.0;          // huni üst çap

    difference() {
        base_plate(PLATE_T);

        for (r = [0:N-1], c = [0:N-1])
            translate([BORDER + c*PITCH, BORDER + r*PITCH, 0]) {
                // Kapak cebi (üstten aşağı, alt yüzey kapalı)
                translate([0, 0, PLATE_T - CAP_POCKET])
                    cylinder(d = CAP_HOLE,
                             h = CAP_POCKET + EPS, $fn = HOLE_FN);
                // Huni girişi (üstten 3 mm)
                translate([0, 0, PLATE_T - 3])
                    cylinder(d1 = CAP_HOLE, d2 = FUNNEL_D,
                             h  = 3 + EPS, $fn = HOLE_FN);
            }

        align_holes();
    }
}


// ═══════════════════════════════════════════════════════════════
//   § 5  FRAME PLATE  (hizalama çerçeve plakası)
//
//   · Tüm diğer plakaları sınırlayan yüksek duvarlı tepsiye benzer
//   · Alt yarı: BODY_HOLE — gövde geçişi
//   · Üst yarı: CAP_HOLE + huni — kapak rehberliği
//   · Üste FRAME_H yüksekliğinde yükseltilmiş çerçeve rim
//     (FRAME_RIM genişliğinde duvar, iç boşluk açık)
// ═══════════════════════════════════════════════════════════════
module frame_plate() {
    HALF = PLATE_T / 2;
    FUNNEL_D = 12.0;
    inner = PLATE_SIZE - 2*FRAME_RIM;

    union() {
        difference() {
            base_plate(PLATE_T);

            for (r = [0:N-1], c = [0:N-1])
                translate([BORDER + c*PITCH, BORDER + r*PITCH, 0]) {
                    // Alt yarı — gövde geçiş deliği
                    translate([0, 0, -EPS])
                        cylinder(d = BODY_HOLE,
                                 h = HALF + EPS, $fn = HOLE_FN);
                    // Basamak geçişi
                    translate([0, 0, HALF - 0.8])
                        cylinder(d1 = BODY_HOLE, d2 = CAP_HOLE,
                                 h  = 1.6, $fn = HOLE_FN);
                    // Üst yarı — kapak deliği
                    translate([0, 0, HALF + 0.8 - EPS])
                        cylinder(d = CAP_HOLE,
                                 h = HALF - 0.8 + EPS, $fn = HOLE_FN);
                    // Huni girişi
                    translate([0, 0, PLATE_T - 3])
                        cylinder(d1 = CAP_HOLE, d2 = FUNNEL_D,
                                 h  = 3 + EPS, $fn = HOLE_FN);
                }

            align_holes();
        }

        // Yükseltilmiş çerçeve duvarı (plakanın üstüne yapışır)
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
//   § 6  SPILL GUARD  (toz dökülme koruması)
//
//   · Yalnızca çerçeve — içi ve altı açık
//   · Toz dolumu sırasında body plate etrafına oturur
//   · Duvar kalınlığı: SPILL_W = 10 mm
//   · İç geçme boyutu: (PLATE_SIZE − 2×SPILL_W) kare
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
//   § 7  TAMPER  (toz sıkıştırma tamper)
//
//   · 100 adet ince peg (PEG_OD = 6.88 mm) aşağıya uzanır
//   · Peg kapsül gövde iç çapına (7.13 mm) uyumlu girer
//   · Peg uçları yarı-küresel → giriş sırasında yüzey hasarı yok
//   · Üstte ergonomik tutamaç köprüsü
// ═══════════════════════════════════════════════════════════════
module tamper() {
    PEG_DEPTH = 11;  // pegin kapsüle girdiği derinlik
    HW = 110; HD = 30; HH = 34;

    union() {
        difference() {
            base_plate(PLATE_T);
            align_holes();
        }

        // 100 tamper peg (aşağı yön)
        for (r = [0:N-1], c = [0:N-1])
            translate([BORDER + c*PITCH, BORDER + r*PITCH, 0]) {
                // Peg gövdesi
                translate([0, 0, -PEG_DEPTH])
                    cylinder(d = PEG_OD,
                             h = PEG_DEPTH, $fn = HOLE_FN);
                // Yarı-küresel peg ucu
                translate([0, 0, -PEG_DEPTH])
                    intersection() {
                        scale([1, 1, 0.5])
                            sphere(d = PEG_OD, $fn = HOLE_FN);
                        translate([0, 0, -PEG_OD/2])
                            cylinder(d = PEG_OD + 1,
                                     h = PEG_OD/2, $fn = HOLE_FN);
                    }
            }

        // Ergonomik tutamaç
        translate([(PLATE_SIZE - HW)/2,
                   (PLATE_SIZE - HD)/2,
                   PLATE_T])
            hull() {
                for (x = [8, HW-8], y = [8, HD-8])
                    translate([x, y, 0]) cylinder(d = 12, h = 2, $fn = 48);
                for (x = [15, HW-15])
                    translate([x, HD/2, HH-10]) sphere(d = 16, $fn = 48);
            }
    }
}


// ═══════════════════════════════════════════════════════════════
//   § 8  SPREADER  (toz yayma spatulası)
//
//   · Referans görsele göre: genişlik 96 mm, yükseklik 135 mm
//   · Trapez form: alt geniş (96 mm), üst dar (96-2×12=72 mm)
//   · Ön kenar 28° pahıyla tek geçişte temiz yayma
//   · Üst yüzeyde boyuna oluklar — toz akışını düzenler
//   · Baskı yönü: T (4.5 mm) ekseninde, destek yok
// ═══════════════════════════════════════════════════════════════
module spreader() {
    T       = 4.5;    // kalınlık
    W       = 96;     // alt taban genişliği (referans ölçü)
    H       = 135;    // yükseklik
    TAPER   = 12;     // her kenardan daralan miktar
    R       = 3;      // köşe yuvarlatma

    // Oluk parametreleri
    GROOVE_W = 1.5;   // oluk genişliği
    GROOVE_D = 1.2;   // oluk derinliği
    GROOVE_N = 7;     // oluk sayısı
    GROOVE_GAP = (W - 2*TAPER - GROOVE_N*GROOVE_W) / (GROOVE_N + 1);

    difference() {
        union() {
            // Ana gövde
            linear_extrude(T)
                offset(r = R) offset(r = -R)
                    polygon([[0,0],[W,0],[W-TAPER,H],[TAPER,H]]);
        }

        // Ön bevel — keskin yayma kenarı
        translate([-2, -EPS, T])
            rotate([28, 0, 0])
                cube([W + 4, 18, 14]);

        // Üst yüzey boyuna oluklar (referans görseldeki gibi)
        for (i = [0:GROOVE_N-1]) {
            x = TAPER + GROOVE_GAP + i * (GROOVE_W + GROOVE_GAP);
            translate([x, R, T - GROOVE_D])
                cube([GROOVE_W, H - 2*R, GROOVE_D + EPS]);
        }
    }
}


// ═══════════════════════════════════════════════════════════════
//   § 9  TPU SPRING  (basılabilir yay — 95A TPU)
//
//   · Metal yay ile aynı OD → direkt değişim
//   · Sarmal kesim yay esnekliği sağlar
//   · Baskı: düz, destek gerektirmez
// ═══════════════════════════════════════════════════════════════
module tpu_spring() {
    difference() {
        cylinder(d = SPR_OD - 0.4, h = SPR_FREE, $fn = 48);
        // Cıvata geçme deliği
        translate([0, 0, -EPS])
            cylinder(d = M4_CLEAR,
                     h = SPR_FREE + 2*EPS, $fn = 32);
        // Sarmal kesim (yay hareketi sağlar)
        linear_extrude(SPR_FREE, twist = 720,
                       slices = 120, convexity = 10)
            translate([(SPR_OD - 0.4)/4, 0])
                square([(SPR_OD - 0.4)/2 + 1, 0.8], center = true);
    }
}


// ═══════════════════════════════════════════════════════════════
//   § 10  ALIGNMENT PIN  (hizalama pimi — ×4–8)
//
//   · Hafif konik şaft → 3.3 mm deliklere kendi kendine merkezlenir
//   · Mantar baş → kolay çekme
//   · PETG baskı, sert geçme
// ═══════════════════════════════════════════════════════════════
module alignment_pin() {
    HEAD_D = 10;
    union() {
        // Konik şaft
        cylinder(d1 = 3.15, d2 = 2.90,
                 h  = PIN_L, $fn = 28);
        // Flanş geçiş
        translate([0, 0, PIN_L])
            cylinder(d1 = 3.15, d2 = HEAD_D,
                     h  = 2.5, $fn = 36);
        // Mantar baş
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
    G = 188;  // parça araları
    translate([  0,   0, 0]) body_plate();
    translate([  G,   0, 0]) middle_plate();
    translate([2*G,   0, 0]) capping_plate();
    translate([  0,   G, 0]) frame_plate();
    translate([  G,   G, 0]) spill_guard();
    translate([2*G,   G, 0]) tamper();
    translate([  0, 2*G, 0]) spreader();
    translate([  G, 2*G, 0]) {
        for (i = [0:3]) translate([i * 26, 0, 0]) foot();
    }
    translate([G + 110, 2*G, 0]) tpu_spring();
    translate([G + 140, 2*G, 0]) alignment_pin();
}
