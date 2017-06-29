import nico

type
  Button* = object
    x*, y*: int
    bg*: int
    fg*: int
    text*: string
    pressed*: bool
    callback*: proc()

proc newButton*(x, y: int, text: string, callback: proc()): Button =
  Button(x: x, y: y, text: text, fg: 0, bg: 3, callback: callback)

proc fire*(b: Button) =
  b.callback()

proc buttonfill*(b: Button) =
  let tw = textWidth(b.text)
  setColor(b.bg)
  rectfill(b.x, b.y, b.x+tw+2, b.y+6)
  setColor(b.fg)
  print(b.text, b.x+2, b.y+1)
 
proc buttoncollide*(b: Button, x, y: int): bool =
  if x >= b.x and x <= b.x+textWidth(b.text)+2:
    if y >= b.y and y <= b.y+6:
      return true
  return false
