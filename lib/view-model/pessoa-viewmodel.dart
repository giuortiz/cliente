class PessoaViewModel {
  String nome;
  int nUsp;

  PessoaViewModel({this.nome, this.nUsp});

  factory PessoaViewModel.fromJson(Map<String, dynamic> json) {
    return new PessoaViewModel(nUsp: json['nUsp'], nome: json['Nome']);
  }

  Map toMap() {
    return {"Nome": this.nome, "nUsp": this.nUsp};
  }
}
