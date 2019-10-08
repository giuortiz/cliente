import 'package:flutter/material.dart';

class DialogUtils {
  BuildContext _context;

  DialogUtils(BuildContext context) {
    _context = context;
  }

  void showProgressDialog( text) async{
    showDialog(
        context: _context,
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

  void dialogDismiss() {
    Navigator.of(_context).pop();
  }
}
