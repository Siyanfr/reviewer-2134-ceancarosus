import 'package:flutter/material.dart';
import 'monster.dart';

/// One monster's full HAUDEX entry. Reached by tapping a tile on the home list.
///
/// TODO 1 (second half): three rows are missing below. Add rows for the
/// monster's Type, Element and Attack so this screen shows the full entry.
class DetailScreen extends StatelessWidget {
  final Monster monster;
  const DetailScreen({super.key, required this.monster});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(monster.name)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _row('Name', monster.name),
            // TODO 1: add a 'Type' row here.
            // TODO 1: add an 'Element' row here.
            _row('HP', '${monster.hp}'),
            // TODO 1: add an 'Attack' row here.
            _row('Region', monster.region),
          ],
        ),
      ),
    );
  }

  Widget _row(String label, String value) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
            Text(value),
          ],
        ),
      );
}
