class Anotacao {
  final num indice;
  final String anotacao;
  final String data;
  final String medicacao;

  Anotacao(
      {required this.indice,
      required this.anotacao,
      required this.data,
      required this.medicacao});

  factory Anotacao.fromMap(Map<String, dynamic> json) => Anotacao(
      indice: json['indice'],
      anotacao: json['anotacoes'],
      data: json['data'],
      medicacao: json['medicacoes']);

  Map<String, dynamic> toJson() => {
        "indice": indice,
        "anotacoes": anotacao,
        "data": data,
        "medicacoes": medicacao
      };
}
