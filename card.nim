type
  Suit* = enum
    spade, heart, diamond, club

  Card* = object
    suit: Suit
    value: int