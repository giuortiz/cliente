import 'package:cliente/server/server-socket.dart';
import 'package:cliente/view/home-view.dart';
import 'package:cliente/view/utils/dialog-utils.dart';
import 'package:flutter/material.dart';

class SplashScreenView extends StatefulWidget {
  @override
  _SplashScreenViewState createState() => _SplashScreenViewState();
}

class _SplashScreenViewState extends State<SplashScreenView> {
  ServerSocket serverSocket;

  @override
  void initState() {
    super.initState();
    serverSocket = new ServerSocket();

    _iniciaServidor();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new Center(child:  CircularProgressIndicator(
        valueColor: new AlwaysStoppedAnimation<Color>(Colors.blue),
        strokeWidth: 4.0,
      ),),
    );
  }

  void _iniciaServidor() async {
    serverSocket.abrirConexao();
    Future.delayed(Duration(milliseconds: 2000), () {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => HomeView(
                  serverSocket: serverSocket,
                )),
      );
    });
  }
}
