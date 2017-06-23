import nico
import cursor
import card

var
  cards: seq[Card]

proc gameInit() =
  loadSpriteSheet("sprites.png")

  cards = newSeq[Card]()
  cards.add(Card(suit: heart, value: 10, location: Point(x: 64, y: 64)))
  cards.add(Card(suit: heart, value: 8, location: Point(x: 20, y: 64)))

proc gameUpdate(dt: float) = discard

proc gameDraw() =
  cls()
  cursorfill()

  for c in cards:
    c.draw()

nico.init("shmup", "cribslam")
nico.loadPaletteCGA()
nico.createWindow("cribslam", 128, 128, 2)
nico.run(gameInit, gameUpdate, gameDraw)