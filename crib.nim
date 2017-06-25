import nico
import libs/cursor
import libs/card
import libs/score
import random

let
  width, height = 128
  scale = 2

var
  cards: seq[Card]
  hand: Hand
  points: int
  fifteens = 0

proc newHand(): Hand =
  cards = newSeq[Card]()
  points = 0

  for s in Suit:
    for v in 1..13:
      cards.add(Card(suit: Suit(s), heirarchy: v, value: if v > 10: 10 else: v))
  shuffle(cards)

  cards[0..4]

proc reset() =
  points = 0
  hand = newHand()

  fifteens = findFifteens(hand).len * 2

proc gameInit() =
  loadSpriteSheet("sprites.png")
  reset()

proc gameUpdate(dt: float) =
  # check for clicks
  if mousebtn(0):
    reset()

proc gameDraw() =
  cls()
  cursorfill()

  # draw cards
  for c in 0..hand.len-1:
    hand[c].location.y = 100
    hand[c].location.x = 18*(c+1)
    hand[c].draw()

  # draw deck art
  drawDeck()

  # draw fifteens
  setColor(1)
  print("15: " & $fifteens, 2, 2)

nico.init("shmup", "cribslam")
nico.loadPaletteCGA()
nico.createWindow("cribslam", width, height, scale)
nico.run(gameInit, gameUpdate, gameDraw)
