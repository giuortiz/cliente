class PessoaViewModel {
  String nome;
  int nUsp;
  bool percenteGrupo;

  PessoaViewModel({this.nome, this.nUsp, this.percenteGrupo: false});

  factory PessoaViewModel.fromJson(Map<String, dynamic> json) {
    return new PessoaViewModel(
        nUsp: json['nUsp'],
        nome: json['Nome'],
        percenteGrupo: json["pertenceGrupo"]);
  }

  Map toMap() {
    return {
      "Nome": this.nome,
      "nUsp": this.nUsp,
      "percenteGrupo": this.percenteGrupo
    };
  }
}
