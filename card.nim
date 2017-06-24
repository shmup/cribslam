import nico

type
  Suit* = enum
    spade, heart, diamond, club

  Card* = object
    suit*: Suit
    heirarchy*: int
    value*: int
    location*: Point

  Hand* = seq[Card]

  Point* = object
    x*: int
    y*: int

var
  cardWidth: float

proc translateValue(v: int): string =
  case v:
    of 1:
      "A"
    of 11:
      "J"
    of 12:
      "Q"
    of 13:
      "K"
    else:
      $v

proc translateSuit(s: Suit): int =
  case s:
    of Suit.heart:
      2
    of Suit.spade:
      3
    of Suit.diamond:
      4
    of Suit.club:
      5

proc draw*(c: Card, ) =
  # outline
  spr(0, c.location.x, c.location.y, 2, 3)
  # suit
  spr(translateSuit(c.suit), c.location.x+4, c.location.y+9, 1, 1)
  # value
  cardWidth = 9 - (textWidth($c.heirarchy)/2)
  if c.heirarchy > 10:
    cardWidth += 2.0
  setColor(3)
  print(translateValue(c.heirarchy), c.location.x+cardWidth, c.location.y+4)

proc drawDeck*() =
  setColor(3)
  var x1 = 94
  var x2 = x1 + 10
  var y1, y2 = 119

  for i in 0..1:
    rectfill(x1+i, y1+i, x2+i, y2+i)

  x1 = x2 + 2
  x2 = x1
  y1 = 104
  y2 = y1 + 17

  for i in 0..1:
    rectfill(x1-i, y1-i, x2-i, y2-2-i)

