import 'package:flutter/material.dart';
import 'data.dart';
import 'stats.dart';

/// HAUDEX home: a stats card over a filterable list of monsters.
///
/// Two things are broken here (BUG D, BUG E) and one is not wired up (TODO 1).
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? _filterType; // null = show every type

  List get _visible => _filterType == null
      ? kMonsters
      : kMonsters.where((m) => m.type == _filterType).toList();

  @override
  Widget build(BuildContext context) {
    final all = kMonsters;
    final visible = _visible;
    final best = strongest(all);
    return Scaffold(
      appBar: AppBar(title: const Text('HAUDEX Reviewer')),
      body: Column(
        children: [
          Card(
            margin: const EdgeInsets.all(12),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _stat('Total monsters', '${totalMonsters(all)}'),
                  _stat('Most common type', mostCommonType(all)),
                  _stat('High HP (> $kHighHpThreshold)', '${highHpCount(all)}'),
                  _stat('Top region', topRegion(all)),
                  _stat('Strongest', best.name),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: [
                const Text('Filter type: '),
                DropdownButton<String?>(
                  value: _filterType,
                  hint: const Text('All'),
                  items: [
                    const DropdownMenuItem(value: null, child: Text('All')),
                    for (final t in kTypes)
                      DropdownMenuItem(value: t, child: Text(t)),
                  ],
                  // BUG D: this updates the field but never calls setState, so
                  // the list and the "Showing N" count never change.
                  onChanged: (v) => _filterType = v,
                ),
                const Spacer(),
                Text('Showing ${visible.length} of ${all.length}'),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: visible.length,
              itemBuilder: (context, index) {
                // BUG E: this always reads the first monster, so every row in
                // the list shows the same one. It should use `index`.
                final m = visible[0];
                return ListTile(
                  title: Text(m.name),
                  subtitle: Text('${m.type} - ${m.region}'),
                  trailing: Text('HP ${m.hp}'),
                  // TODO 1: when a tile is tapped, open DetailScreen for THIS monster
                  // (import detail_screen.dart, then Navigator.push a
                  // MaterialPageRoute). Right now tapping a tile does nothing.
                  onTap: () {},
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _stat(String label, String value) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label),
            Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      );
}
