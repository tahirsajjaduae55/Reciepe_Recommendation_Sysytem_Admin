import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:recipe_admin/add_ingridients.dart';

class IngredientsList extends StatelessWidget {
  const IngredientsList({super.key});

  @override
  Widget build(BuildContext context) {
    Query dbRef = FirebaseDatabase.instance.ref().child('ingridents');

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text('Ingridents'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddIngridents()),
          );
        },
        child: const Icon(
          Icons.add,
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: FirebaseAnimatedList(
              query: dbRef,
              itemBuilder: (BuildContext context, DataSnapshot snapshot,
                  Animation<double> animation, int index) {
                Map qrCode = snapshot.value as Map;
                qrCode['key'] = snapshot.key;

                return listItem(qrCodes: qrCode);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget listItem({required Map qrCodes}) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      color: Colors.blueGrey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: const Text(
              'Name: ',
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
            title: Text(
              qrCodes['name'],
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          ListTile(
            leading: const Text(
              'Cost: ',
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
            title: Text(
              qrCodes['cost'],
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
