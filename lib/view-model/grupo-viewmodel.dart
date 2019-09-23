import 'package:cliente/view-model/pessoa-viewmodel.dart';

class GrupoViewModel {
  List<PessoaViewModel> integrantes;
  String nota;
  String tema;

  GrupoViewModel({this.integrantes, this.nota, this.tema});

  factory GrupoViewModel.fromJson(Map<String, dynamic> json) {
    return new GrupoViewModel(
        integrantes: (json['Integrantes'] != null)
            ? (json['Integrantes'] as List)
                .map((x) => PessoaViewModel.fromJson(x))
                .toList()
            : List(),
        nota: json['Nota'],
        tema: json['Tema']);
  }

  Map toMap() {
    return {
      "Integrantes": this.integrantes.map((x) => x.toMap()).toList(),
      "Nota": this.nota,
      "Tema": this.tema
    };
  }
}
