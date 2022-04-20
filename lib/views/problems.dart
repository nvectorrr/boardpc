import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:auto_size_text/auto_size_text.dart';

class ProblemsView extends StatefulWidget {
  @override
  _ProblemsViewState createState() => _ProblemsViewState();
}

class _ProblemsViewState extends State<ProblemsView> {
  var _streamSnapshot = FirebaseFirestore.instance.collection('tasks');

  String documentToUpdateId = "";

  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _streamSnapshot.snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snap) {
        if (snap.hasError) {
          return Text('Something went wrong');
        }

        if (snap.connectionState == ConnectionState.waiting) {
          return Material(
              color: Color.fromARGB(255, 45, 45, 45),
              child: Text(
                "Loading",
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
              ));
        }

        return Material(
            color: Color.fromARGB(255, 45, 45, 45),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 15,
                ),
                AutoSizeText(
                  'Журнал неполадок',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.green),
                  maxLines: 1,
                  minFontSize: 24,
                  maxFontSize: 48,
                ),
                SizedBox(
                  height: 30,
                ),
                ListView.builder(
                    shrinkWrap: true,
                    itemCount: snap.data.docs.length,
                    itemBuilder: (ctx, index) => Container(
                          child: Row(
                            children: <Widget>[
                              Checkbox(
                                value: !snap.data.docs[index]['active'],
                                onChanged: (bool value) {
                                  String documentId = snap.data.docs[index].id;
                                  bool currentState =
                                      snap.data.docs[index]['active'];
                                  updateDocument(documentId, currentState);
                                },
                              ),
                              AutoSizeText(
                                "| Задача: " +
                                    snap.data.docs[index]['name'] +
                                    " | ",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.green),
                                maxLines: 3,
                                minFontSize: 18,
                                maxFontSize: 24,
                              ),
                              AutoSizeText(
                                "Локация: " +
                                    snap.data.docs[index]['location'] +
                                    " | ",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.green),
                                maxLines: 3,
                                minFontSize: 18,
                                maxFontSize: 24,
                              ),
                              AutoSizeText(
                                "Персонал: " +
                                    snap.data.docs[index]['role'] +
                                    " |",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.green),
                                maxLines: 3,
                                minFontSize: 18,
                                maxFontSize: 24,
                              ),
                            ],
                          ),
                        ))
              ],
            ));
      },
    );
  }

  void updateDocument(String documentId, bool currentState) {
    print(documentId);
    _streamSnapshot.doc(documentId).update({'active': !currentState});
    documentToUpdateId = "";
  }
}
