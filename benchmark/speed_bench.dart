import 'package:proximity_hash/proximity_hash.dart';
import 'package:zgh/zgh.dart' as zgh;

main() {
  List<String> inputGHs =
      createGeohashes(48.85362949495339, 2.3485638639703765, 100000, 8)
          .toSet()
          .toList();
  print("Input: ${inputGHs.length} geohashes");
  final st = Stopwatch()..start();
  List<String> compressed = zgh.compress(inputGHs, maxLevel: 8);
  print("Compression done in ${st.elapsed}");
  print(
      'Output: ${compressed.length} geohashes (-${100 - ((compressed.length / inputGHs.length) * 100)}%)');
}
