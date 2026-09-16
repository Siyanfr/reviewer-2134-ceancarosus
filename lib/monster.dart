/// One HAUDEX monster record. Immutable, built from the seed in data.dart.
class Monster {
  final int id;
  final String name;
  final String type;
  final String element;
  final int hp;
  final int attack;
  final String region;

  const Monster({
    required this.id,
    required this.name,
    required this.type,
    required this.element,
    required this.hp,
    required this.attack,
    required this.region,
  });
}
