import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:cliente/view-model/grupo-viewmodel.dart';
import 'package:cliente/view-model/pessoa-viewmodel.dart';
import 'package:cliente/view/utils/dialog-utils.dart';

class ServerSocket {
  Socket _socket;
  PessoaViewModel _pessoaFechar =
      new PessoaViewModel(nUsp: 000000, nome: "Fechar");

  void abrirConexao() async {
    Socket.connect("192.168.230.186", 9999).then((socket) {
      print(socket);
      _socket = socket;
    });
  }

  StreamSubscription<List<int>> buscarGrupos(PessoaViewModel pessoa,
      Function callback, GrupoViewModel grupo, int counter) {
    if (counter == 2) {
      _socket.write(json.encode(pessoa.toMap()));
      _socket.write(json.encode(grupo.toMap()));
    } else {
      _socket.write(json.encode(pessoa.toMap()));
    }

    return _socket.listen((onData) {
      callback(onData);
    });
  }

  Future enviaGrupo(GrupoViewModel grupo) {
    _socket.write(json.encode(grupo.toMap()));
  }

  StreamSubscription<List<int>> buscarAlunos(
      PessoaViewModel pessoa, Function callback) {
    _socket.write(json.encode(pessoa.toMap()));

    return _socket.listen((onData) {
      callback(onData);
    });
  }

  void fecharConexao() async {
    _socket.write(json.encode(_pessoaFechar.toMap()));
  }
}
