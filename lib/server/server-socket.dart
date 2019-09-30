import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:cliente/view-model/pessoa-viewmodel.dart';
import 'package:cliente/view/utils/dialog-utils.dart';

class ServerSocket {
  Socket _socket;

  void abrirConexao() async {

    Socket.connect("192.168.0.30", 9999).then((socket) {
      print(socket);
      _socket = socket;
    });
  }

  StreamSubscription<List<int>> buscarDados(
      PessoaViewModel pessoa, Function callback) {
    _socket.write(json.encode(pessoa.toMap()));

    return _socket.listen((onData) {
      callback(onData);
    });
  }
}
