let { ColToRowKey, .. } = import "./fak/keyboard.ncl" in
let { CH552T, .. } = import "./fak/mcus.ncl" in

{
  mcu = CH552T,
  debounce_ms = 7, # very important setting given that we're working with GT SMD switches
  matrix = {
    cols = [32, 14, 15, 16, 17, 12, 13, 35, 34, 33],
    rows = [10, 11, 31, 30]
  },
  usb_dev = {
    vendor_id = 48815, # 0xBEAF
    product_id = 1,
    product_ver = 1, # 0x0001
  },
  keys =
    let M = ColToRowKey in
    [
      M 0 0, M 1 0, M 2 0, M 3 0, M 4 0, M 5 0, M 6 0, M 7 0, M 8 0, M 9 0,
      M 0 1, M 1 1, M 2 1, M 3 1, M 4 1, M 5 1, M 6 1, M 7 1, M 8 1, M 9 1,
                    M 2 2, M 3 2, M 4 2, M 5 2, M 6 2, M 7 2,
                    M 2 3, M 3 3, M 4 3, M 5 3, M 6 3, M 7 3,
    ]
}
