//classe do objeto pessoa
class PessoaViewModel {
  String nome;
  int nUsp;
  bool percenteGrupo;

  PessoaViewModel({this.nome, this.nUsp, this.percenteGrupo: false});
//metodo para deserealizar objeto
  factory PessoaViewModel.fromJson(Map<String, dynamic> json) {
    return new PessoaViewModel(
        nUsp: json['nUsp'],
        nome: json['Nome'],
        percenteGrupo: json["pertenceGrupo"]);
  }
//metodo para serealizar objeto
  Map toMap() {
    return {
      "Nome": this.nome,
      "nUsp": this.nUsp,
      "percenteGrupo": this.percenteGrupo
    };
  }
}
