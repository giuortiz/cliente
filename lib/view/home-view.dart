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
  List<PessoaViewModel> _list;
  GrupoViewModel _grupoAdd;
  TextEditingController _controllerTema = new TextEditingController();
  GlobalKey listaKey = new GlobalKey();
  FocusNode _focusTema = new FocusNode();

  @override
  void initState() {
    _pessoaViewModel = new PessoaViewModel(nome: "lista grupos", nUsp: 23);
    _grupoAdd = new GrupoViewModel(integrantes: new List());
    _list = List<PessoaViewModel>();
    _listaGrupos = new List();
    _carregaGrupos();
    super.initState();

  }

  @override
  //metodo onde é montada a interface
  Widget build(BuildContext context) {
    double _heigth = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: CupertinoNavigationBar(
          leading: new GestureDetector(
            onTap: () {
              //clique do botao de voltar
              _counter = 0;
              _pessoaViewModel.nome = "lista grupos";
              _carregaGrupos();
            },
            child: new Container(
              padding: EdgeInsets.only(right: 20.0),
              color: Colors.transparent,
              child: new Icon(
                Icons.arrow_back_ios,
                size: 20.0,
                color: Colors.blue,
              ),
            ),
          ),
          trailing: (_counter == 0)
              ? new Container()
          //CLIQUE DO BOTAO CONFIRMAR, ONDE O OBJETO GRUPO É ALIMENTADO COM A LISTA DOS ALUNOS SELECIONADOS, ASSIM COMO O TEMA
              : new GestureDetector(
                  onTap: () {
                    _focusTema.unfocus();
                    listaKey = new GlobalKey();
                    _counter = 2;
                    for (int i = 0; i < _list.length; i++) {
                      if (_list[i].percenteGrupo == true) {
                        _grupoAdd.integrantes.add(_list[i]);
                      }
                    }
                    _grupoAdd.tema = _controllerTema.text;
                    _carregaGrupos();
                  },
                  child: new Container(
                    padding: EdgeInsets.only(right: 20.0),
                    color: Colors.transparent,
                    child: new Text(
                      "Confirmar",
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                )),
      backgroundColor: Colors.white,
      body: _body(_heigth, _width),
    );
  }

  Widget _body(_heigth, _width) {
    return (_counter == 0) ? _buildBody(_heigth, _width) : _buildBody2();
  }

  Widget _buildBody(_heigth, _width) {
    return new ListView(
      children: <Widget>[
        new Container(
          margin: EdgeInsets.only(top: 20.0),
          alignment: Alignment.center,
          child: new RichText(
            text: TextSpan(
              text: "${_listaGrupos.length}",
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
                onTap: () {
                  _counter = 1;
                  _pessoaViewModel.nome = "lista alunos";
                  _carregaGrupos();
                },
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
                    text: 'Novo ',
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
                margin: EdgeInsets.only(right: 10.0, top: 30.0),
                padding: EdgeInsets.all(10.0),
                decoration:
                    BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                height: 20.0,
              ),
              new Container(
                  margin: EdgeInsets.only(top: 30.0),
                  child: new Text(
                    "Turma 01 - EP1",
                    style: TextStyle(fontSize: 20.0),
                  ))
            ],
          ),
          new Container(
            padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
            child: (_listaGrupos.length == 0)
                ? new Container(
                    alignment: Alignment.center,
                    child: new Text(
                      "Nenhum grupo",
                      style: TextStyle(
                          color: Colors.grey.withOpacity(0.6), fontSize: 20.0),
                    ),
                  )
                : new Container(
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
                                      child: new Text(grupo[index].tema),
                                    ),
                                    new Container(
                                        child: new Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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

  Widget _buildBody2() {
    return new ListView.builder(
      key: listaKey,
        itemCount: _list.length,
        itemBuilder: (context, index) =>
            (_list.length < 1) ? new Container() : _itemList2(index));
  }

  Widget _itemList2(index) {
    var item = _list[index];
    return (index == 0)
        ? new Column(
            children: <Widget>[
              new Container(
                child: new Text(
                  "Nome do Grupo",
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
              new Container(
                padding: EdgeInsets.only(top: 10.0, bottom: 10.0, left: 10.0),
                margin: EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.0),
                  color: Colors.grey.withOpacity(0.4),
                ),
                child: new TextField(
                  focusNode: _focusTema,
                  controller: _controllerTema,
                  decoration: InputDecoration.collapsed(hintText: ""),
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
              new Container(
                child: new Text(
                  "Integrantes do Grupo",
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
              new CheckboxListTile(
                title: new Text(item.nome),
                value: item.percenteGrupo,
                onChanged: (value) {
                  setState(() {
                    item.percenteGrupo = !item.percenteGrupo;
                  });
                },
              )
            ],
          )
        : new CheckboxListTile(
            title: new Text(item.nome),
            value: item.percenteGrupo,
            onChanged: (value) {
              setState(() {
                item.percenteGrupo = !item.percenteGrupo;
              });
            },
          );
  }

  void _carregaGrupos() async {
//METODO RESPONSAVEL POR SELECIONAR QUAL FUNCAO SERA UTILIZADA DO SERVIDOR E REALIZA-LA
    if (_counter == 2) {
      _pessoaViewModel.nome = "criar";

      widget.serverSocket.enviaGrupo(_grupoAdd);
      _grupoAdd = new GrupoViewModel(integrantes: new List());

      _counter = 0;
      _pessoaViewModel.nome = "lista grupos";
      _carregaGrupos();
    } else {
      widget.serverSocket.buscarGrupos(_pessoaViewModel, (onData) {
        try {
          var l;
          if (_counter == 0) {

            l = (json.decode((utf8.decode(onData))) as List)
                .map((i) => new GrupoViewModel.fromJson(i));
          } else if (_counter == 1) {

            l = (json.decode((utf8.decode(onData))) as List)
                .map((i) => new PessoaViewModel.fromJson(i));
          }
          var list = l.toList();

          if (list != null) {
            setState(() {
              if (_counter == 0) {
                _listaGrupos = list;
              } else if (_counter == 1) {
                _list = list;
              }
            });
          } else {
            print("Erro, não foi possivel carregar a lista!");
          }
        } catch (e) {
          widget.serverSocket.abrirConexao();
          _carregaGrupos();
        }
      }, _grupoAdd, _counter);
    }
  }
}
