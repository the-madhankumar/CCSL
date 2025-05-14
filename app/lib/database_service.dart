

import 'package:firebase_database/firebase_database.dart';

class DatabaseService {
  final FirebaseDatabase _database = FirebaseDatabase.instance;

  Future<void> setData(String path, Map<String, dynamic> data) async {
    final DatabaseReference ref = _database.ref().child(path); 
    await ref.set(data);
  }

  Future<void> updateData(String path, Map<String, dynamic> data) async {
    final DatabaseReference ref = _database.ref().child(path); 
    await ref.update(data);
  }

  Future<void> deleteData(String path) async {
    final DatabaseReference ref = _database.ref().child(path); 
    await ref.remove();
  }

  Future<DataSnapshot?> getData(String path) async {
    final DatabaseReference ref = _database.ref().child(path); 
    final DataSnapshot snapshot = await ref.get();
    return snapshot.exists ? snapshot : null;
  }
}