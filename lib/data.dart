import 'monster.dart';

/// The reviewer roster is generated, not hand-written, so nobody can hand-count
/// the answers from reading this file. A fixed linear-congruential generator
/// (LCG) fills 200 monsters deterministically: the seed never changes, so every
/// student's roster - and every correct answer - is identical. This is the
/// REVIEWER, so the roster differs from the exam - practise the moves, not the
/// answers.
///
/// LCG low bits barely change between steps, so every field is drawn from the
/// HIGH bits (`>> 16`). Drawing from the low bits would pile most monsters into
/// one type or one region.
class _Lcg {
  int _state;
  _Lcg(this._state);

  /// Advance and return a value in [0, max).
  int next(int max) {
    _state = (1103515245 * _state + 12345) & 0x7fffffff;
    return ((_state >> 16) % max);
  }
}

const List<String> kTypes = [
  'banshee',
  'ghoul',
  'revenant',
  'wisp',
  'lich',
];

const List<String> kElements = ['ember', 'tide', 'gale', 'stone', 'toxin'];

const List<String> kRegions = [
  'Taguig',
  'Makati',
  'Pasig',
  'Quezon',
  'Cavite',
];

const List<String> _prefix = [
  'Aer', 'Dro', 'Fen', 'Hax', 'Lyr', 'Orv', 'Spar', 'Wyr',
];
const List<String> _suffix = [
  'bane', 'coil', 'fang', 'hollow', 'rasp', 'shade', 'thorn', 'wisp',
];

/// The full 200-monster roster, generated once. NEW seed for the reviewer.
final List<Monster> kMonsters = _generate();

List<Monster> _generate() {
  final rng = _Lcg(20260910);
  final out = <Monster>[];
  for (var id = 1; id <= 200; id++) {
    final name = '${_prefix[rng.next(_prefix.length)]}'
        '${_suffix[rng.next(_suffix.length)]}-$id';
    final type = kTypes[rng.next(kTypes.length)];
    final element = kElements[rng.next(kElements.length)];
    final region = kRegions[rng.next(kRegions.length)];
    final hp = 20 + rng.next(80); // 20..99
    final attack = 10 + rng.next(50); // 10..59
    out.add(Monster(
      id: id,
      name: name,
      type: type,
      element: element,
      hp: hp,
      attack: attack,
      region: region,
    ));
  }
  return out;
}
