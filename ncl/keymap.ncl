let { tap, hold, td, combo, .. } = import "./fak/keycode.ncl" in
let util = import "./fak/util_functions.ncl" in

let virtual_keys' = [
] in

let key_count = 32 + std.array.length virtual_keys' in

let kc = tap.reg.kc in
let ks = tap.reg.ks in
let md = hold.reg.mod in
let tm = tap.reg.mod in
let me = tap.custom.media in
let MO = hold.reg.layer in

let ki = {
  hp = { decision = 'hold, trigger_on = 'press },
  tp = { decision = 'tap, trigger_on = 'press },
  hr = { decision = 'hold, trigger_on = 'release },
  tr = { decision = 'tap, trigger_on = 'release },
  xx = { decision = 'none },
} in

let layouts = {
  QWERTY = "QWERTYUIOPASDFGHJKLMZXCVBN",
  DVORAK = "PYFGCRLAOEUIDHTNSQJKXBMWVZ",
  COLEMAK = "QWFPGJLUYARSTDHNEIOZXCVBKM",
} in

let XXXX = tap.none & hold.none in

let L' = fun layer => 
  let filler = std.array.replicate (key_count - std.array.length layer) XXXX in
  layer @ filler
in


let alphas = fun layout => layout
  |> std.string.characters
  |> util.array.enumerate
  |> std.array.map (fun { index, value } => kc."%{value}")
in

let cu = {
  SCSH = tm.lgui & tm.lsft & kc.S,
  PWSP = tm.lgui & kc.PGDN,
  NWSP = tm.lgui & kc.PGUP,
  CT =   tm.lctl & kc.TAB,
  CST =  tm.lctl & tm.lsft & kc.TAB,
  BOOT = tap.custom.fak.BOOT,
} in

let thumb = fun i =>
  let htb_generic = {
    timeout_ms = 200,
    quick_tap_ms = 150,
    key_interrupts = std.array.replicate key_count ki.hr,
  } in
  [
    kc.TAB & MO 3 & hold.reg.behavior htb_generic,
    kc.TAB & MO 3 & hold.reg.behavior htb_generic,
    kc.SPC & MO 1 & hold.reg.behavior htb_generic,
    kc.BSPC & MO 5 & hold.reg.behavior htb_generic,
    kc.BSPC & MO 4 & hold.reg.behavior htb_generic,
    kc.BSPC & MO 4 & hold.reg.behavior htb_generic,
  ]
  |> std.array.at i
in

let keymap = {
  virtual_keys = virtual_keys',
  layers = [
    let base = fun key_idx => (alphas layouts.QWERTY) |> std.array.at key_idx in
    [
      base 0,  base 1,  base 2,  base 3,  base 4,     base 5,  base 6,  base 7,  base 8,  base 9,
      base 10, base 11, base 12, base 13, base 14,    base 15, base 16, base 17, base 18, base 19,
                        base 20, base 21, base 22,    base 23, base 24, base 25,
                        cu.BOOT, kc.TAB,  kc.SPC,     kc.BSPC, kc.BSPC, kc.ENT,
      # Combo [12, 13]
      # td.make 200 [MO 3, cu.BOOT],
    ],
    L' [
      XXXX,    XXXX,    XXXX,    XXXX,    XXXX,       cu.PWSP, cu.CT,   cu.CST,  cu.NWSP, XXXX,
      md.lgui, md.lalt, md.lctl, md.lsft, cu.SCSH,    kc.LEFT, kc.DOWN, kc.UP,   kc.RGHT, XXXX,
                        XXXX,    XXXX,    XXXX,       kc.HOME, kc.PGDN, kc.PGUP,
                        XXXX,    XXXX,    kc.ENT,     XXXX,    XXXX,    XXXX,
    ],
    L' [
      XXXX,    XXXX,    XXXX,    XXXX,    XXXX,       XXXX,    kc.N7,   kc.N8,   kc.N9,   XXXX,
      XXXX,    XXXX,    XXXX,    XXXX,    XXXX,       XXXX,    kc.N4,   kc.N5,   kc.N6,   XXXX,
                        XXXX,    XXXX,    XXXX,       kc.N1,   kc.N2,   kc.N3,
                        XXXX,    XXXX,    XXXX,       kc.N0,   kc.".",   XXXX,
    ],
    L' [
      XXXX,    XXXX,    XXXX,    kc.F11,  XXXX,       XXXX,    kc.F12,  XXXX,    XXXX,    XXXX,
      kc.F7,   kc.F5,   kc.F3,   kc.F1,   XXXX,       kc.F8,   kc.F10,  kc.F2,   kc.F4,   kc.F6,
                        XXXX,    XXXX,    XXXX,       XXXX,    XXXX,    XXXX,
                        XXXX,    XXXX,    XXXX,       XXXX,    XXXX,    XXXX,
    ],
    L' [
      ks.CIRC, ks.DLR,  ks.TILD, ks.PIPE, ks.PERC,    ks.AMPR, ks.ASTR, kc.SLSH, ks.HASH, ks.AT,
      ks.DQUO, kc.LBRC, ks.LCBR, ks.LPRN, ks.LABK,    kc.GRV,  ks.UNDS, kc.EQL,  ks.COLN, kc.QUOT,
                        ks.RCBR, ks.RPRN, ks.RABK,    ks.QUES, ks.PLUS, kc.SCLN,
                           XXXX,    XXXX,    XXXX,    XXXX,    XXXX,    XXXX,
    ],
  ]
} in

keymap
