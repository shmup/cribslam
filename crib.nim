import nico
import card

proc gameInit() = discard
proc gameUpdate(dt: float) = discard
proc gameDraw() = discard

nico.init("shmup", "cribslam")
nico.loadPaletteCGA()
nico.createWindow("cribslam", 128, 128, 4)
nico.run(gameInit, gameUpdate, gameDraw)