import nico

type
  Suit* = enum
    spade, heart, diamond, club

  Card* = object
    suit*: Suit
    value*: int
    location*: Point

  Point* = object
    x*: int
    y*: int

proc translateValue(v: int): string =
  case v:
    of 11:
      "J"
    of 12:
      "Q"
    of 13:
      "K"
    else:
      $v

proc draw*(c: Card, ) =
  # outline
  spr(0, c.location.x, c.location.y, 2, 3)
  # suit
  spr(2, c.location.x+4, c.location.y+9, 1, 1)
  # value
  let w = 9 - (textWidth($c.value)/2)
  print(translateValue(c.value), c.location.x+w, c.location.y+4)