import 'package:flutter/material.dart';

class DialogUtils {
  void showProgressDialog(context, text) {
    showDialog(
        context: context,
        builder: (context) => new Container(
            color: Colors.white,
            child: new Row(
              children: <Widget>[
                new Container(
                  child: CircularProgressIndicator(
                    valueColor: new AlwaysStoppedAnimation<Color>(Colors.blue),
                    strokeWidth: 4.0,
                  ),
                ),
                new Text(text),
              ],
            )));
  }

  void dialogDismiss(context) {
    Navigator.of(context).pop();
  }
}
