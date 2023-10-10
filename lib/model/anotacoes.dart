class Anotacao {
  final num indice;
  final String anotacao;

  Anotacao({required this.indice, required this.anotacao});

  factory Anotacao.fromMap(Map<String, dynamic> json) =>
      Anotacao(indice: json['indice'], anotacao: json['anotacao']);

  Map<String, dynamic> toJson() => {
        "indice": indice,
        "anotacoes": anotacao,
      };
}
