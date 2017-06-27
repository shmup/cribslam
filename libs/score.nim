import seqUtils
import algorithm
import card
import sets

var
  fifteens: seq[seq[int]]
  pairs: seq[seq[Card]]

proc subsetSum(numbers: seq[int], target: int, partial: var seq[int]) =
  var sum = if (partial.len > 0): foldl(partial, a+b) else: 0
  if sum == target:
    fifteens.add(partial)
  if sum >= target: return

  for i in 0..numbers.len-1:
    var newPartial = newSeq[int]()
    newPartial.insert(partial)
    newPartial.add(numbers[i])
    subsetSum(numbers[i+1..^1], target, newPartial)

proc subsetPairs(cards: Hand, partial: var seq[Card]) =
  if partial.len == 2 and partial[0].heirarchy == partial[1].heirarchy:
    pairs.add(partial)
    return
  elif partial.len > 2:
    return

  for i in 0..cards.len-1:
    var newPartial = newSeq[Card]()
    newPartial.insert(partial)
    newPartial.add(cards[i])
    subsetPairs(cards[i+1..^1], newPartial)

proc findFifteens*(h: Hand): seq[seq[int]] =
  let nums = h.mapIt(it.value)
  var partial = newSeq[int]()
  fifteens = newSeq[seq[int]]()
  subsetSum(nums, 15, partial)
  return fifteens

proc findPairs*(h: Hand): seq[Hand] =
  var partial = newSeq[Card]()
  pairs = newSeq[seq[Card]]()
  subsetPairs(h, partial)
  return pairs

proc findRuns*(h: Hand): int =
  var 
    lastRepeat = 0
    multiplier, runCount = 1

  var values = h.mapIt(it.heirarchy)
  echo values

  for i in 1..4:
    # run startin
    if values[i] - values[i-1] == 1:
      runCount += 1
    elif values[i] == values[i-1]:
      # triple dupe?
      if values[i] != lastRepeat and lastRepeat != 0:
        multiplier += 1
      multiplier += 1
      lastRepeat = values[i]
    else:
      # pz
      if runCount >= 3:
        break
      # reset
      else:
        runCount = 1
        multiplier = 1

  return if runCount >= 3: runCount * multiplier else: 0

proc isKnobs*(h: Hand): bool =
  # can't knob a flipped up jack
  if h[4].heirarchy == 11: return false
  # filter any jacks in the hand
  h[0..3].filter(proc(c: Card): bool = return c.heirarchy == 11)
         # check if any equal suit of flipped up card
         .any(proc(c: Card): bool = return c.suit == h[4].suit)

proc isFlush*(h: Hand): bool =
  h.all(proc(c: Card): bool = return c.suit == h[0].suit)