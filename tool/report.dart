// ignore_for_file: avoid_print
// Text fallback for the HAUDEX home screen's STATS CARD. Prints exactly what
// the five stat panels show, using the same logic (lib/stats.dart), for a
// Codespace where the web preview is fussy. The filter count, the list and the
// detail screen are read off the running app, not here. Run:
//   dart run tool/report.dart
import 'package:haudex_midterm/data.dart';
import 'package:haudex_midterm/stats.dart';

void main() {
  final ms = kMonsters;
  print('Total monsters:    ${totalMonsters(ms)}');
  print('Most common type:  ${mostCommonType(ms)}');
  print('High HP (> $kHighHpThreshold):    ${highHpCount(ms)}');
  print('Top region:        ${topRegion(ms)}');
  print('Strongest:         ${strongest(ms).name}');
}
