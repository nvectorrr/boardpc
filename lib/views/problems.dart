import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/Task.dart';

class ProblemsView extends StatefulWidget {
  @override
  _ProblemsViewState createState() => _ProblemsViewState();
}

class _ProblemsViewState extends State<ProblemsView> {
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('tasks_global').snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _usersStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }

        return Material(
          child: ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data()! as Map<String, dynamic>;
              return ListTile(
                title: Text(data['name']),
                subtitle: Text(data['descr']),
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
