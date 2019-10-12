import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:cliente/view-model/grupo-viewmodel.dart';
import 'package:cliente/view-model/pessoa-viewmodel.dart';

class ServerSocket {
  Socket _socket;
  PessoaViewModel _pessoaFechar =
      new PessoaViewModel(nUsp: 000000, nome: "Fechar");

  void abrirConexao() async {
    //METODO RESPONSAVEL POR ESTABELECER A CONEXAO COM O SERVIDOR
    Socket.connect("192.168.0.27", 9999).then((socket) {
      print(socket);
      _socket = socket;
    });
  }

  StreamSubscription<List<int>> buscarGrupos(PessoaViewModel pessoa,
      Function callback, GrupoViewModel grupo, int counter) {
    //METODO PARA REQUISICAO DE LISTAS
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
    //METODO PARA CRIACAO DE GRUPO
    _socket.write(json.encode(grupo.toMap()));
  }



  void fecharConexao() async {
    _socket.write(json.encode(_pessoaFechar.toMap()));
  }
}
