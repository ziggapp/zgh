![banner](https://user-images.githubusercontent.com/14275989/102886072-b89a6580-4454-11eb-963c-6675db83f6c9.png)

# zgh - Light & fast geohash compression

Geohash is a public domain geocode system invented in 2008 by Gustavo Niemeyer and G.M. Morton, which encodes a geographic location into a short string of letters and digits. It is a hierarchical spatial data structure which subdivides space into buckets of grid shape, which is one of the many applications of what is known as a Z-order curve, and generally space-filling curves.

Describing a geographical area using geohashes (for example for running a query over it) is done by listing all buckets (geohash) forming that area. Depending on how this is done and the size of the area, this list can end up being huge and thus running a query over it become slow and ineficient.

ZGH start at the lowest precision hashes and work its way up the dataset gradually clustering hashes with common parents. The result is a dataset up to 99% smaller that still define the area with the same level as accuracy.

The following example show a base geohash set of `3424` geohashes at level 7

- Running zgh with `{minLevel: 1, maxLevel: 7}` achieve a `81.48%` lossless compression yielding `634` geohashes
- Running zgh with `{minLevel: 1, maxLevel: 6}` achieve a `97.19%` lossy compression yielding `96` geohashes

![compression exemple](https://user-images.githubusercontent.com/14275989/102883143-ca2d3e80-444f-11eb-956a-33f8d0f429b7.png)

## Benchmark

65 Millions hashes compress to 100k in about 1 minute on the following machine:

- _Model:_ MacBook Pro (13-inch, 2017)
- _Processor:_ 2.3 GHz Dual-Core Intel Core i5
- _Memory:_ 16 GB 2133 MHz LPDDR3

```
$ dart ./benchmark/speed_bench.dart
Input: 65540960 geohashes
Compression done in 0:00:59.309131
Output: 105447 geohashes (-99.83911282349236%)
```

## Installation

### 1. Depend on it

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  zgh: '^1.0.0'
```

#### 2. Install it

You can install packages from the command line:

```bash
$ pub get
```

Alternatively, your editor might support pub. Check the docs for your editor to learn more.

#### 3. Import it

Now in your Dart code, you can use:

```Dart
import 'package:zgh/zgh.dart' as zgh;
```

## Usage

Read the unit tests under `test`, or see code example below:

```Dart
const List<String> geohashes = [
	'u09tv0', 'u09tv1', 'u09tv2', 'u09tv3', 'u09tv4', 'u09tv5',
	'u09tv6', 'u09tv7', 'u09tv8', 'u09tv9', 'u09tvb', 'u09tvc',
	'u09tvd', 'u09tve', 'u09tvf', 'u09tvg', 'u09tvh', 'u09tvj',
	'u09tvk', 'u09tvm', 'u09tvn', 'u09tvp', 'u09tvq', 'u09tvr',
	'u09tvs', 'u09tvt', 'u09tvu', 'u09tvv', 'u09tvw', 'u09tvx',
	'u09tvy', 'u09tvz'
];
final List<String> compressed = zgh.compress(geohashes);
print(compressed); // ["u09tv"]
```
