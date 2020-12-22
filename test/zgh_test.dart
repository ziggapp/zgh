import 'package:proximity_hash/proximity_hash.dart';
import 'package:test/test.dart';
import 'package:zgh/zgh.dart' as zgh;

bool verifyGHSLevel(List<String> ghs, {int minLevel = 1, int maxLevel = 12}) {
  return !ghs.any((gh) => gh.length < minLevel || gh.length > maxLevel);
}

void main() {
  List<String> inputGHs =
      createGeohashes(48.85362949495339, 2.3485638639703765, 10000, 7);

  test('Level bounds (2, 4)', () {
    const int minLevel = 2;
    const int maxLevel = 4;
    final List<String> c =
        zgh.compress(inputGHs, minLevel: minLevel, maxLevel: maxLevel);
    expect(verifyGHSLevel(c, minLevel: minLevel, maxLevel: maxLevel), true);
  });

  test('Level bounds (4, 4)', () {
    const int minLevel = 4;
    const int maxLevel = 4;
    final List<String> c =
        zgh.compress(inputGHs, minLevel: minLevel, maxLevel: maxLevel);
    expect(verifyGHSLevel(c, minLevel: minLevel, maxLevel: 4), true);
  });
}
