import 'package:hive/hive.dart';

abstract class StorageService {
  Future<List<T>> getAll<T>(String boxName);

  Future<T?> get<T>(
      String boxName,
      String key,
      );

  Future<void> put<T>(
      String boxName,
      String key,
      T value,
      );

  Future<void> delete(
      String boxName,
      String key,
      );

  Future<void> clear(String boxName);
}

class HiveStorageService implements StorageService {
  // Map to track boxes currently being opened to prevent race conditions
  final Map<String, Future<Box>> _openingBoxes = {};

  Future<Box> _openBox(String boxName) async {
    // 1. Check if already open
    if (Hive.isBoxOpen(boxName)) {
      return Hive.box(boxName);
    }

    // 2. Check if an open operation is already in progress
    if (_openingBoxes.containsKey(boxName)) {
      return await _openingBoxes[boxName]!;
    }

    // 3. Open the box without a generic type to avoid "Box already open with different type" errors
    final openFuture = Hive.openBox(boxName);
    _openingBoxes[boxName] = openFuture;

    try {
      final box = await openFuture;
      return box;
    } finally {
      // Remove from tracking once finished
      _openingBoxes.remove(boxName);
    }
  }

  @override
  Future<List<T>> getAll<T>(String boxName) async {
    final box = await _openBox(boxName);
    return box.values.cast<T>().toList();
  }

  @override
  Future<T?> get<T>(
      String boxName,
      String key,
      ) async {
    final box = await _openBox(boxName);
    final result = box.get(key);
    return result as T?; // Cast the dynamic result to your desired type T
  }

  @override
  Future<void> put<T>(
      String boxName,
      String key,
      T value,
      ) async {
    final box = await _openBox(boxName);
    await box.put(key, value);
  }

  @override
  Future<void> delete(
      String boxName,
      String key,
      ) async {
    final box = await _openBox(boxName);
    await box.delete(key);
  }

  @override
  Future<void> clear(String boxName) async {
    final box = await _openBox(boxName);
    await box.clear();
  }
}