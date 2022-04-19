import 'package:cloud_firestore/cloud_firestore.dart';

class JournalItem {
  Timestamp date;
  String descr;

  JournalItem({this.date, this.descr});
}
