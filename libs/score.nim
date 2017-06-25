import seqUtils
import card

var
  fifteens: seq[seq[int]]
  pairs: seq[seq[int]]

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

proc subsetPairs(numbers: seq[int], partial: var seq[int]) =
  if partial.len == 2 and partial[0] == partial[1]:
    pairs.add(partial)
    return
  elif partial.len > 2:
    return

  for i in 0..numbers.len-1:
    var newPartial = newSeq[int]()
    newPartial.insert(partial)
    newPartial.add(numbers[i])
    subsetPairs(numbers[i+1..^1], newPartial)

proc findFifteens*(h: Hand): seq[seq[int]] =
  let nums = h.mapIt(it.value)
  var partial = newSeq[int]()
  fifteens = newSeq[seq[int]]()
  subsetSum(nums, 15, partial)
  return fifteens

proc findPairs*(h: Hand): seq[seq[int]] =
  let nums = h.mapIt(it.heirarchy)
  var partial = newSeq[int]()
  pairs = newSeq[seq[int]]()
  subsetPairs(nums, partial)
  return pairs

proc isKnobs*(h: Hand): bool =
  # can't knob a flipped up jack
  if h[4].heirarchy == 11: return false
  # filter any jacks in the hand
  h[0..3].filter(proc(c: Card): bool = return c.heirarchy == 11)
         # check if any equal suit of flipped up card
         .any(proc(c: Card): bool = return c.suit == h[4].suit)

proc isFlush*(h: Hand): bool =
  h.all(proc(c: Card): bool = return c.suit == h[0].suit)
