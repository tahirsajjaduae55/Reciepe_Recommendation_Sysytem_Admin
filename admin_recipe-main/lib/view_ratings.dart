import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ViewRatings extends StatelessWidget {
  const ViewRatings({super.key});

  @override
  Widget build(BuildContext context) {
    Query dbRef = FirebaseDatabase.instance.ref().child('recipe_ratings');
    // DatabaseReference reference =
    //     FirebaseDatabase.instance.ref().child('qr_codes');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text(
          'Ratings',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
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
      ),
    );
  }

  Widget listItem({required Map rating}) {
    return InkWell(
      onTap: () {},
      child: Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),
        color: Colors.blueGrey,
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
                'Instructions',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              title: Text(
                rating['instructions'],
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            ListTile(
              leading: const Text(
                'Cost',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              title: Text(
                rating['cost'],
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
            ListTile(
              leading: const Text(
                'Feedback',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              title: Text(
                rating['feedback'],
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              trailing: IconButton(
                  onPressed: () async {
                    String mail = rating['email'];
                    var url = Uri.parse("mailto:$mail");
                    if (await canLaunchUrl(url)) {
                      await launchUrl(url);
                    } else {
                      throw 'Could not launch $url';
                    }
                  },
                  icon: const Icon(
                    Icons.send,
                    color: Colors.white,
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
