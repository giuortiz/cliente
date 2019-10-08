import 'dart:convert';

import 'package:cliente/view-model/pessoa-viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class CriarGrupoView extends StatefulWidget {
  var serverSocket;

  CriarGrupoView({this.serverSocket});

  @override
  _CriarGrupoViewState createState() => _CriarGrupoViewState();
}

class _CriarGrupoViewState extends State<CriarGrupoView> {
  List<PessoaViewModel> _list;

  @override
  void initState() {

    _list = List<PessoaViewModel>();
    _carregaDados();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return new ListView.builder(
        itemCount: _list.length,
        itemBuilder: (context, index) =>
            (_list.length < 1) ? new Container() : _itemList(index));
  }

  Widget _itemList(index) {
    var item = _list[index];
    return new ListTile(
      leading: new Text(item.nome),
    );
  }

  Future _carregaDados() async {
    PessoaViewModel _pessoaViewModel =
        new PessoaViewModel(nome: "Foles", nUsp: 9911430);
    widget.serverSocket.buscarAlunos(_pessoaViewModel, (onData) {
      try {
        var l = (json.decode((utf8.decode(onData))) as List)
            .map((i) => new PessoaViewModel.fromJson(i));

        var list = l.toList();

        if (list != null) {
          setState(() {
            _list = list;
          });
        } else {
          print("Erro, não foi possivel carregar a lista!");
        }
      } catch (e) {
        return null;
      }
    });
  }
}
