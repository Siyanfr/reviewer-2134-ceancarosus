import 'monster.dart';

/// Pure aggregation over a monster roster. No Flutter here, so the report tool
/// and the widgets share exactly one copy of the logic. The home screen shows
/// each of these in a stats panel.
///
/// Three of the stats panels are WRONG (BUG A, BUG B, BUG C) and one is not
/// finished (TODO 2). Read each doc comment for what the panel is supposed to
/// show, then make the code match it.

/// The HP threshold the "High HP" panel counts ABOVE (strictly greater than).
const int kHighHpThreshold = 70;

int totalMonsters(List<Monster> ms) => ms.length;

/// The type that appears most often across the roster.
String mostCommonType(List<Monster> ms) {
  final counts = <String, int>{};
  for (final m in ms) {
    counts[m.type] = (counts[m.type] ?? 0) + 1;
  }
  var best = ms.first.type;
  var bestCount = 1 << 30;
  for (final entry in counts.entries) {
    // BUG A: this keeps the LEAST common type, not the most common.
    if (entry.value < bestCount) {
      best = entry.key;
      bestCount = entry.value;
    }
  }
  return best;
}

/// How many monsters have HP strictly greater than the threshold.
int highHpCount(List<Monster> ms) =>
    // BUG B: this counts HP equal to the threshold as well.
    ms.where((m) => m.hp >= kHighHpThreshold).length;

/// The region with the most monsters ("busiest").
String topRegion(List<Monster> ms) {
  final counts = <String, int>{};
  for (final m in ms) {
    // BUG C: this groups by the wrong field (element), so the panel shows an
    // element name where a region should be.
    counts[m.element] = (counts[m.element] ?? 0) + 1;
  }
  var best = ms.first.element;
  var bestCount = -1;
  for (final entry in counts.entries) {
    if (entry.value > bestCount) {
      best = entry.key;
      bestCount = entry.value;
    }
  }
  return best;
}

/// How many monsters have exactly this type (used by the type filter).
int countOfType(List<Monster> ms, String type) =>
    ms.where((m) => m.type == type).length;

/// The single monster with the highest HP ("strongest").
Monster strongest(List<Monster> ms) {
  // TODO 2: return the monster with the highest HP. Right now it always returns
  // the first monster in the list, so the "Strongest" panel is wrong. Walk the
  // list and keep the one whose hp is largest.
  return ms.first;
}

/// Look up one monster by id, or null if there is none.
Monster? monsterById(List<Monster> ms, int id) {
  for (final m in ms) {
    if (m.id == id) return m;
  }
  return null;
}
