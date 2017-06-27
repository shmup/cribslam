import nico
import libs/cursor
import libs/card
import libs/score
import random
import sets
import algorithm
import seqUtils

let
  width, height = 128
  scale = 4

var
  cards: seq[Card]
  hand: Hand
  fifteens, pairs, flush, runs, knobs, total: int
  clickTimer = 0.0

proc newHand(): Hand =
  cards = newSeq[Card]()

  for s in Suit:
    for v in 1..13:
      cards.add(Card(suit: Suit(s), heirarchy: v, value: if v > 10: 10 else: v))
  shuffle(cards)

  cards[0..4].sortedByIt(it.heirarchy)

proc scoreHand() =
  fifteens = findFifteens(hand).len * 2
  pairs = findPairs(hand).len * 2
  runs = findRuns(hand)
  flush = if isFlush(hand): 5 else: 0
  knobs = if isKnobs(hand): 1 else: 0
  total = fifteens + flush + pairs + runs + knobs

proc reset() =
  cls()
  hand = newHand()
  scoreHand()

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
  clickTimer += dt

  # check for clicks
  if mousebtn(0) and clickTimer > 0.2:
    reset()
    clickTimer = 0

proc gameDraw() =
  cls()
  cursorfill()
  drawCards()
  drawScores()

nico.init("shmup", "cribslam")
nico.loadPaletteCGA()
nico.createWindow("cribslam", width, height, scale)
nico.run(gameInit, gameUpdate, gameDraw)