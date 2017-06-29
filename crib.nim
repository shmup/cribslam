import nico
import libs/cursor
import libs/card
import libs/score
import libs/button
import random
import sets
import algorithm
import seqUtils

let
  width, height = 128
  scale = 4

var
  cards: seq[Card]
  buttons: seq[Button]
  hand: Hand
  fifteens, pairs, flush, runs, knobs, total: int
  clickTimer = 0.0
  showHelp = false

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
  let tempTotal = fifteens + flush + pairs + runs + knobs
  total = if tempTotal > 0: tempTotal else: 19

proc reset*() =
  # discard()
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

proc help() =
  showHelp = not showHelp

proc gameInit() =
  loadSpriteSheet("sprites.png")
  reset()

  buttons = newSeq[Button]()
  buttons.add(newButton(3, 3, "HELP", help))
  buttons.add(newButton(3, 12, "DEAL", reset))

proc gameUpdate(dt: float) =
  clickTimer += dt

  if mousebtn(0) and clickTimer > 0.2:
    let x = mouse()[0]
    let y = mouse()[1]
    for btn in buttons:
      if btn.buttoncollide(x, y):
        btn.fire()
    clickTimer = 0

proc gameDraw() =
  cls()
  drawCards()
  if showHelp:
    drawScores()

  for btn in buttons:
    btn.buttonfill()

  # always on top
  cursorfill()

nico.init("shmup", "cribslam")
nico.loadPaletteCGA()
nico.createWindow("cribslam", width, height, scale)
nico.run(gameInit, gameUpdate, gameDraw)