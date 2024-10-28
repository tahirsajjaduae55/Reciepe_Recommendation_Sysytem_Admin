import 'package:firebase_database/firebase_database.dart';

class FirebaseService {
  final databaseReference = FirebaseDatabase.instance.ref();

  Future<List<String>> getData() async {
    List<String> dataList = [];

    // Assuming your data is stored under a node called 'items'
    DatabaseEvent dataSnapshot =
        await databaseReference.child('ingridents').once();

    Map<dynamic, dynamic> values = dataSnapshot as dynamic;

    values.forEach((key, value) {
      dataList.add(value.toString());
    });

    return dataList;
  }
}
