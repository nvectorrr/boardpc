import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class JournalView extends StatefulWidget {
  @override
  _JournalViewState createState() => _JournalViewState();
}

class _JournalViewState extends State<JournalView> {
  final Stream<QuerySnapshot> _streamSnapshot =
      FirebaseFirestore.instance.collection('journal').snapshots();

  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _streamSnapshot,
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
                  'Бортовой журнал',
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
                    itemBuilder: (ctx, index) => ListTile(
                          textColor: Colors.green,
                          title: AutoSizeText(
                            DateTime.tryParse(snap.data.docs[index]['date']
                                    .toDate()
                                    .toString())
                                .toString(),
                            style: TextStyle(fontWeight: FontWeight.bold),
                            maxLines: 1,
                            minFontSize: 20,
                            maxFontSize: 27,
                          ),
                          subtitle: AutoSizeText(
                            snap.data.docs[index]['event'],
                            style: TextStyle(fontWeight: FontWeight.w500),
                            maxLines: 3,
                            minFontSize: 18,
                            maxFontSize: 24,
                          ),
                        ))
              ],
            ));
      },
    );
  }
}
