library zgh;

Set<String> _getChildren(String ghb) {
  const base32 = [
    '0',
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    'b',
    'c',
    'd',
    'e',
    'f',
    'g',
    'h',
    'j',
    'k',
    'm',
    'n',
    'p',
    'q',
    'r',
    's',
    't',
    'u',
    'v',
    'w',
    'x',
    'y',
    'z'
  ];
  return base32.map((c) => "$ghb$c").toSet();
}

List<String> compress(List<String> geohashes,
    {int minLevel = 1, int maxLevel = 12}) {
  bool foundOptimization = true;
  Set<String> ghsSet = geohashes.toSet();
  while (foundOptimization) {
    foundOptimization = false;
    for (String gh in ghsSet.toList()) {
      if (gh.length < minLevel) continue;
      final parent = gh.substring(0, gh.length - 1);
      if (ghsSet.contains(parent)) continue;
      final childrens = _getChildren(parent);
      if (gh.length > maxLevel || ghsSet.containsAll(childrens)) {
        foundOptimization = true;
        ghsSet.add(parent);
        ghsSet.removeAll(childrens);
      }
    }
  }
  return ghsSet.toList();
}
