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
    kc.ESC & md.lgui & hold.reg.behavior htb_generic,
    kc.TAB & md.lctl & hold.reg.behavior htb_generic,
    kc.SPC & MO 1 & hold.reg.behavior htb_generic,
    XXXX & MO 2 & hold.reg.behavior htb_generic, # Not used
    kc.BSPC & md.lsft & hold.reg.behavior htb_generic,
    kc.ENT & md.lalt & hold.reg.behavior htb_generic,
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
                        thumb 0, thumb 1,  thumb 2,   MO 2,    thumb 4, thumb 5,
      # Combo [12, 13]
      # td.make 200 [MO 3, cu.BOOT],
    ],
    L' [ # lower
      ks.EXLM, ks.AT,   ks.HASH, ks.DLR,  ks.PERC,    ks.CIRC, ks.AMPR, ks.ASTR, ks.LPRN, ks.RPRN,
      ks.TILD, ks.UNDS, ks.PLUS, ks.LCBR, ks.RCBR,    XXXX,    XXXX,    XXXX,    XXXX,    ks.DQUO,
                        ks.PIPE, kc.COMM, kc.DOT,     XXXX,    ks.COLN, kc.SLASH,
                        XXXX,    XXXX,    XXXX,       MO 3,    XXXX,    XXXX,
    ],
    L' [ # raise
      kc.N1,   kc.N2,   kc.N3,   kc.N4,   kc.N5,      kc.N6,   kc.N7,   kc.N8,   kc.N9,   kc.N0,
      kc.GRV,  kc.MINS, kc.EQL,  kc.LBRC, kc.RBRC,    kc.LEFT, kc.DOWN, kc.UP,   kc.RIGHT,kc.QUOT,
                        kc.BSLS, ks.LABK, ks.RABK,    XXXX,    kc.SCLN, ks.QUES,
                        XXXX,    XXXX,    MO 3,       XXXX,    XXXX,   XXXX,
    ],
    L' [ # lower + raise
      cu.BOOT, XXXX,    XXXX,    XXXX,    XXXX,       XXXX,    XXXX,    XXXX,    XXXX,    XXXX,
      kc.F1,   kc.F2,   kc.F3,   kc.F4,   kc.F5,      kc.F6,   XXXX,    XXXX,    XXXX,    XXXX,
                        kc.F7,   kc.F8,   kc.F9,      kc.F10,   kc.F11,   kc.F12,
                        XXXX,    XXXX,    XXXX,       XXXX,    XXXX,    XXXX,
    ],
  ]
} in

keymap
