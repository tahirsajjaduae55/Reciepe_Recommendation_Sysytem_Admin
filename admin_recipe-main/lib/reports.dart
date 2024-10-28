import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

class Reports extends StatelessWidget {
  const Reports({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal,
          title: const Text('Reports'),
          bottom: const TabBar(
            labelColor: Colors.white,
            indicatorColor: Colors.white,
            tabs: [
              Tab(text: 'Recipe Visited'),
              Tab(text: 'Ratings'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            MostVisited(),
            Ratings(),

            // Top Rated Tab
          ],
        ),
      ),
    );
  }
}

class MostVisited extends StatefulWidget {
  const MostVisited({super.key});

  @override
  State<MostVisited> createState() => _MostVisitedState();
}

class _MostVisitedState extends State<MostVisited> {
  Map<dynamic, dynamic> _data = {};
  bool isLoading = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  Future<void> getData() async {
    isLoading = true;
    DatabaseReference databaseReference = FirebaseDatabase.instance
        .ref()
        .child('user_recipe_data')
        .child('recipeVisitCount');
    DatabaseEvent databaseEvent = await databaseReference.once();
    DataSnapshot dataSnapshot = databaseEvent.snapshot;

    setState(() {
      _data = dataSnapshot.value as dynamic;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            isLoading
                ? const Center(
                    child: Padding(
                    padding: EdgeInsets.all(18.0),
                    child: CircularProgressIndicator(),
                  ))
                : DataTable(
                    columns: const [
                      DataColumn(
                          label: Text(
                        'Recipe Name',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                      DataColumn(
                          label: Text(
                        'Total Visits',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                    ],
                    rows: _data.entries.map((entry) {
                      String recipeName = entry.key;
                      int totalVisits = entry.value;

                      return DataRow(
                        cells: [
                          DataCell(Text(
                            recipeName,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          )),
                          DataCell(Text(totalVisits.toString())),
                        ],
                      );
                    }).toList(),
                  ),
            // _buildChart(),
          ],
        ),
      ),
    );
  }
}

class Ratings extends StatelessWidget {
  const Ratings({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        // backgroundColor: Colors.grey,
        // appBar: AppBar(
        //   title: const Text("Custom SubTap"),
        // ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Container(
                height: 70,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.teal),
                child: const TabBar(
                  indicatorColor: Colors.black,
                  labelColor: Colors.white,
                  dividerColor: Colors.white,
                  tabs: [
                    Tab(
                      text: "Top Rated",
                    ),
                    Tab(
                      text: "Average",
                    ),
                    Tab(
                      text: "low",
                    ),
                  ],
                ),
              ),
              const Expanded(
                child: TabBarView(children: [
                  TopRated(),
                  AverageRating(),
                  LowRated(),
                ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class TopRated extends StatelessWidget {
  const TopRated({super.key});

  @override
  Widget build(BuildContext context) {
    Query dbRef = FirebaseDatabase.instance
        .ref()
        .child('recipe_ratings')
        .orderByChild('rating')
        .equalTo('5.0');

    return Column(
      children: [
        Expanded(
          child: FirebaseAnimatedList(
            query: dbRef,
            itemBuilder: (BuildContext context, DataSnapshot snapshot,
                Animation<double> animation, int index) {
              Map rating = snapshot.value as Map;
              rating['key'] = snapshot.key;

              return listItem(rating: rating);
            },
          ),
        ),
      ],
    );
  }
}

class AverageRating extends StatelessWidget {
  const AverageRating({super.key});

  @override
  Widget build(BuildContext context) {
    Query dbRef = FirebaseDatabase.instance
        .ref()
        .child('recipe_ratings')
        .orderByChild('rating')
        .equalTo('3.0');

    return Column(
      children: [
        Expanded(
          child: FirebaseAnimatedList(
            query: dbRef,
            itemBuilder: (BuildContext context, DataSnapshot snapshot,
                Animation<double> animation, int index) {
              Map rating = snapshot.value as Map;
              rating['key'] = snapshot.key;

              return listItem(rating: rating);
            },
          ),
        ),
      ],
    );
  }
}

class LowRated extends StatelessWidget {
  const LowRated({super.key});

  @override
  Widget build(BuildContext context) {
    Query dbRef = FirebaseDatabase.instance
        .ref()
        .child('recipe_ratings')
        .orderByChild('rating')
        .equalTo('1.0');

    return Column(
      children: [
        Expanded(
          child: FirebaseAnimatedList(
            query: dbRef,
            itemBuilder: (BuildContext context, DataSnapshot snapshot,
                Animation<double> animation, int index) {
              Map rating = snapshot.value as Map;
              rating['key'] = snapshot.key;

              return listItem(rating: rating);
            },
          ),
        ),
      ],
    );
  }
}

Widget listItem({required Map rating}) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.blueGrey,
      borderRadius: BorderRadius.circular(10),
    ),
    margin: const EdgeInsets.all(10),
    padding: const EdgeInsets.all(10),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          leading: const Text(
            'Name',
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
          title: Text(
            rating['name'],
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        ListTile(
          leading: const Text(
            'Rating',
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
          title: Text(
            rating['rating'],
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
