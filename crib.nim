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
  fifteens, pairs, flush, runs, knobs, total: int

proc newHand(): Hand =
  cards = newSeq[Card]()
  points = 0

  for s in Suit:
    for v in 1..13:
      cards.add(Card(suit: Suit(s), heirarchy: v, value: if v > 10: 10 else: v))
  shuffle(cards)

  cards[0..4]

proc reset() =
  cls()
  points = 0
  hand = newHand()
  fifteens = findFifteens(hand).len * 2
  pairs = findPairs(hand).len * 2
  flush = if isFlush(hand): 5 else: 0
  knobs = if isKnobs(hand): 1 else: 0
  total = fifteens + flush + pairs + runs + knobs

proc drawCards() =
  # draw cards
  for c in 0..hand.len-1:
    hand[c].location.y = 100
    hand[c].location.x = 18*(c+1)
    hand[c].draw()

  # draw deck art
  drawDeck()

proc drawScores() =
  # draw points
  setColor(3)
  let x = width - 49
  print("fifteens: " & $fifteens, x, 2)
  print("   pairs: " & $pairs, x, 8)
  print("    runs: " & $runs, x, 14)
  print("   flush: " & $flush, x, 20)
  print("   knobs: " & $knobs, x, 26)
  setColor(2)
  print("   total: " & $total, x, 32)

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
  drawCards()
  drawScores()

nico.init("shmup", "cribslam")
nico.loadPaletteCGA()
nico.createWindow("cribslam", width, height, scale)
nico.run(gameInit, gameUpdate, gameDraw)
