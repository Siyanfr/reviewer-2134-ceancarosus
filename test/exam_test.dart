// Non-scoring self-check. Your grade is the Canvas quiz; this only tells you
// whether each bug and TODO is fixed, and prints your current answers. It works
// out the correct answer from the roster itself, so no answers are written here.
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:haudex_midterm/data.dart';
import 'package:haudex_midterm/stats.dart';
import 'package:haudex_midterm/main.dart';

String _mostFrequent(Iterable<String> xs) {
  final c = <String, int>{};
  for (final x in xs) c[x] = (c[x] ?? 0) + 1;
  return c.entries.reduce((a, b) => a.value >= b.value ? a : b).key;
}

void main() {
  test('BUG A: most common type is the MOST frequent', () {
    expect(mostCommonType(kMonsters), _mostFrequent(kMonsters.map((m) => m.type)));
  });
  test('BUG B: High HP counts hp strictly greater than the threshold', () {
    expect(highHpCount(kMonsters), kMonsters.where((m) => m.hp > kHighHpThreshold).length);
  });
  test('BUG C: top region is a region (not an element), the most common one', () {
    expect(topRegion(kMonsters), _mostFrequent(kMonsters.map((m) => m.region)));
  });
  test('TODO 2: strongest is the highest-HP monster', () {
    expect(strongest(kMonsters).id, kMonsters.reduce((a, b) => a.hp >= b.hp ? a : b).id);
  });

  testWidgets('BUG E: list rows show different monsters', (t) async {
    await t.pumpWidget(const HaudexApp());
    await t.pumpAndSettle();
    final tiles = find.byType(ListTile);
    final a = (t.widget<ListTile>(tiles.at(0)).title as Text).data;
    final b = (t.widget<ListTile>(tiles.at(1)).title as Text).data;
    expect(a == b, isFalse, reason: 'every row shows the same monster - BUG E');
  });

  testWidgets('BUG D: choosing a type updates the shown count', (t) async {
    await t.pumpWidget(const HaudexApp());
    await t.pumpAndSettle();
    const type = 'ghoul';
    await t.tap(find.byType(DropdownButton<String?>));
    await t.pumpAndSettle();
    await t.tap(find.text(type).last);
    await t.pumpAndSettle();
    final n = countOfType(kMonsters, type);
    expect(find.text('Showing $n of ${kMonsters.length}'), findsOneWidget);
  });

  testWidgets('TODO 1: tapping a monster opens its full detail', (t) async {
    await t.pumpWidget(const HaudexApp());
    await t.pumpAndSettle();
    final m = monsterById(kMonsters, 42)!;
    await t.scrollUntilVisible(find.text(m.name), 300, scrollable: find.byType(Scrollable).first);
    await t.tap(find.text(m.name));
    await t.pumpAndSettle();
    expect(find.text('Type'), findsOneWidget);
    expect(find.text('Element'), findsOneWidget);
    expect(find.text('Attack'), findsOneWidget);
    expect(find.text(m.type), findsWidgets);
  });

  testWidgets('ANSWERS', (t) async {
    final all = kMonsters;
    final m = monsterById(all, 42)!;
    String q5 = '(filter not fixed yet)';
    String q7 = '(look-up not finished yet)', q8 = q7, q9 = q7;
    await t.pumpWidget(const HaudexApp());
    await t.pumpAndSettle();
    // Q5: filter to wraith, read the "Showing N" count off the app
    try {
      await t.tap(find.byType(DropdownButton<String?>));
      await t.pumpAndSettle();
      await t.tap(find.text('ghoul').last);
      await t.pumpAndSettle();
      final showing = t.widgetList<Text>(find.textContaining('Showing '))
          .map((w) => w.data).firstWhere((s) => s != null, orElse: () => null);
      if (showing != null) q5 = showing.replaceAll('Showing ', '').split(' of ').first;
      // reset the filter back to All so monster 42 is in the list again
      await t.tap(find.byType(DropdownButton<String?>));
      await t.pumpAndSettle();
      await t.tap(find.text('All').last);
      await t.pumpAndSettle();
    } catch (_) {}
    // Q7-9: open monster 42's detail and read its rows off the app
    try {
      await t.scrollUntilVisible(find.text(m.name), 300, scrollable: find.byType(Scrollable).first);
      await t.tap(find.text(m.name));
      await t.pumpAndSettle();
      if (find.text('Type').evaluate().isNotEmpty &&
          find.text('Attack').evaluate().isNotEmpty) {
        q7 = m.type; q8 = '${m.attack}'; q9 = m.element;
      }
    } catch (_) {}
    debugPrint('HAUDEX-ANSWERS-START');
    debugPrint('Q1  Total monsters        : ${totalMonsters(all)}');
    debugPrint('Q2  Most common type      : ${mostCommonType(all)}');
    debugPrint('Q3  High HP (> 70)        : ${highHpCount(all)}');
    debugPrint('Q4  Top region            : ${topRegion(all)}');
    debugPrint('Q5  "ghoul" filter count : $q5');
    debugPrint('Q6  Repeated tile name    : read this off the ORIGINAL buggy app (before BUG E)');
    debugPrint('Q7  Monster 42 type       : $q7');
    debugPrint('Q8  Monster 42 attack     : $q8');
    debugPrint('Q9  Monster 42 element    : $q9');
    debugPrint('Q10 Strongest monster     : ${strongest(all).name}');
    debugPrint('HAUDEX-ANSWERS-END');
  });
}
