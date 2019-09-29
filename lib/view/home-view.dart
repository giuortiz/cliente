import 'dart:convert';

import 'package:cliente/server/server-socket.dart';
import 'package:cliente/view-model/grupo-viewmodel.dart';
import 'package:cliente/view-model/pessoa-viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  ServerSocket serverSocket;

  HomeView({this.serverSocket});

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _counter = 0;
  PessoaViewModel _pessoaViewModel;
  List<GrupoViewModel> _listaGrupos;

  @override
  void initState() {
    _pessoaViewModel = new PessoaViewModel(nome: "Xolis", nUsp: 23);
    _listaGrupos = new List();
    _carregaListaAlunos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double _heigth = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: _buildBody(_heigth, _width),
    );
  }

  Widget _buildBody(_heigth, _width) {
    return new ListView(
      children: <Widget>[
        new Container(
          margin: EdgeInsets.only(top: 20.0),
          alignment: Alignment.center,
          child: new RichText(
            text: TextSpan(
              text: '11',
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                  fontSize: 100.0,
                  letterSpacing: 0.1),
              children: <TextSpan>[
                TextSpan(
                    text: 'grupos',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 30.0,
                        fontWeight: FontWeight.w300)),
              ],
            ),
          ),
        ),
        new Container(
          margin: EdgeInsets.only(top: 30.0),
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new GestureDetector(
                onTap: () {},
                child: new Container(
                  margin: EdgeInsets.only(right: 10.0),
                  padding: EdgeInsets.all(10.0),
                  decoration:
                      BoxDecoration(color: Colors.blue, shape: BoxShape.circle),
                  child: new Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                ),
              ),
              new Container(
                child: new RichText(
                  text: TextSpan(
                    text: 'Novo',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                        fontSize: 30.0,
                        letterSpacing: 0.1),
                    children: <TextSpan>[
                      TextSpan(
                          text: 'Grupo',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 30.0,
                              fontWeight: FontWeight.w300)),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        new Container(height: _heigth / 3, child: _listaGrupo(_heigth, _width))
      ],
    );
  }

  Widget _listaGrupo(_heigth, _width) {
    return new ListView.builder(
      itemCount: 1,
      itemBuilder: (context, index) => _itemList(_heigth, _width, _listaGrupos),
    );
  }

  Widget _itemList(_heigth, _width, List<GrupoViewModel> grupo) {
    return new Container(
      child: new Column(
        children: <Widget>[
          new Row(
            children: <Widget>[
              new Container(
                margin: EdgeInsets.only(right: 10.0),
                padding: EdgeInsets.all(10.0),
                decoration:
                    BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                height: 20.0,
              ),
              new Container(
                  child: new Text(
                "Turma 01 - EP1",
                style: TextStyle(fontSize: 20.0),
              ))
            ],
          ),
          new Container(
            padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
            child: new Container(
              height: _heigth / 4.5,
              width: _width,
              child: new ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: grupo.length,
                  itemBuilder: (context, index) {
                    return new Container(
                      height: _heigth / 4.5,
                      width: _heigth / 4.5,
                      margin: EdgeInsets.only(left: 20.0),
                      child: new Material(

                          borderRadius: BorderRadius.circular(6.0),
                          color: Colors.white,
                          elevation: 4.0,
                          child: new ListView(
                            children: <Widget>[
                              new Container(
                                  child: new Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: _listPessoas(grupo[index]),
                                  )),
                            ],
                          )),
                    );
                  }),
            ),
          )
        ],
      ),
    );
  }

  List<Widget> _listPessoas(GrupoViewModel grupo) {
    var integrantes = grupo.integrantes;
    List<Widget> listaPessoa = new List();
    integrantes.forEach((item) {
      listaPessoa.add(new Container(
        margin: EdgeInsets.only(bottom: 4.0, top: 4.0),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Container(
              margin: EdgeInsets.only(left: 4.0, right: 4.0),
              child: new Text(
                item.nome,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            new Container(
              margin: EdgeInsets.only(left: 4.0, right: 4.0),
              child: new Text("${item.nUsp}"),
            )
          ],
        ),
      ));
    });
    return listaPessoa;
  }

  void _carregaListaAlunos() async {
    widget.serverSocket.buscarDados(_pessoaViewModel, (onData) {
      try {
        var l = (json.decode((utf8.decode(onData))) as List)
            .map((i) => new GrupoViewModel.fromJson(i));

        var list = l.toList();

        if (list != null) {
          setState(() {
            _listaGrupos = list;
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
