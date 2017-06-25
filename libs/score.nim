import seqUtils
import card

var
  pairs, fifteens: seq[seq[int]]

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

proc findFifteens*(h: Hand): seq[seq[int]] =
  let nums = h.mapIt(it.value)
  var partial = newSeq[int]()
  fifteens = newSeq[seq[int]]()
  subsetSum(nums, 15, partial)
  return fifteens
