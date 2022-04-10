import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromARGB(255, 42, 42, 42),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/problems');
                  },
                  child: SizedBox(
                    child: AutoSizeText(
                      '1. Журнал неисправностей',
                      style: TextStyle(fontWeight: FontWeight.bold),
                      maxLines: 1,
                      minFontSize: 24,
                      maxFontSize: 48,
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/journal');
                  },
                  child: SizedBox(
                    child: AutoSizeText(
                      '2. Бортовой журнал',
                      style: TextStyle(fontWeight: FontWeight.bold),
                      maxLines: 1,
                      minFontSize: 24,
                      maxFontSize: 48,
                    ),
                  ),
                ),
              ]),
        ],
      ),
    );
  }
}
