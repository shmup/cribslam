import nico

proc cursorfill*() =
  let x = mouse()[0]
  let y = mouse()[1]
  setColor(1)
  circfill(x, y, 1)