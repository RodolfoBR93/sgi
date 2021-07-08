import 'package:sembast/sembast.dart';
import 'web_database.dart';
import 'package:sgi/models/user.dart';
import 'package:flutter/material.dart';

class UserWebDao {
  static const String USER_STORE_NAME = 'sgi';
  // A Store with int keys and Map<String, dynamic> values.
  // This Store acts like a persistent map, values of which are Fruit objects converted to Map
  final _userStore = intMapStoreFactory.store(USER_STORE_NAME);

  // Private getter to shorten the amount of code needed to get the
  // singleton instance of an opened database.
  Future<Database> get _db async => await WebDatabase.instance.database;

  Future insert(User user) async {
    debugPrint("dentro do insert inicio..");
    await _userStore.add(await _db, user.toMap());
    debugPrint("dentro do insert fim..");
  }

  Future update(User user) async {
    // For filtering by key (ID), RegEx, greater than, and many other criteria,
    // we use a Finder.
    final finder = Finder(filter: Filter.byKey(user.id));
    await _userStore.update(
      await _db,
      user.toMap(),
      finder: finder,
    );
  }

  Future delete(User user) async {
    final finder = Finder(filter: Filter.byKey(user.id));
    await _userStore.delete(
      await _db,
      finder: finder,
    );
  }

  Future<List<User>> getAllSortedByName() async {
    // Finder object can also sort data.
    final finder = Finder(sortOrders: [
      SortOrder('id'),
    ]);

    final recordSnapshots = await _userStore.find(
      await _db,
      finder: finder,
    );

    // Making a List<Fruit> out of List<RecordSnapshot>
    return recordSnapshots.map((snapshot) {
      final user = User.fromMap(snapshot.value);
      return user;
    }).toList();
  }
}
