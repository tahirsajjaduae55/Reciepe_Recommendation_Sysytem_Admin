import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddIngridents extends StatefulWidget {
  const AddIngridents({super.key});

  @override
  State<AddIngridents> createState() => _AddIngridentsState();
}

class _AddIngridentsState extends State<AddIngridents> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    String name;
    String cost;
    TextEditingController nameCtrl = TextEditingController();
    TextEditingController costCtrl = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text(
          'Add Ingriendents',
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Add Ingredients',
              style: TextStyle(
                color: Colors.red,
                fontSize: 20,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: nameCtrl,
              decoration: const InputDecoration(
                hintText: 'Ingredient Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: costCtrl,
              decoration: const InputDecoration(
                hintText: 'Ingredients Cost',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () async {
                setState(() {
                  isLoading = true;
                });
                name = nameCtrl.text;
                cost = costCtrl.text;

                if (name.isNotEmpty || cost.isNotEmpty) {
                  final addIngriedents = {
                    'name': name,
                    'cost': cost,
                  };

                  final DatabaseReference recipeRef =
                      FirebaseDatabase.instance.ref().child('ingridents');

                  await recipeRef.push().set(addIngriedents);
                  nameCtrl.clear();
                  costCtrl.clear();
                  setState(() {
                    isLoading = false;
                  });
                } else {
                  setState(() {
                    isLoading = false;
                  });
                  Fluttertoast.showToast(msg: 'All fields required');
                }
              },
              child: isLoading
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child:
                          CircularProgressIndicator()) // Show CircularProgressIndicator while loading
                  : const Text('Add'),
            ),
          ],
        ),
      ),
    );
  }
}
