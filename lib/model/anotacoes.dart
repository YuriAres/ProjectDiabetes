class Anotacao {
  final num indice;
  final String anotacao;
  final String data;

  Anotacao({required this.indice, required this.anotacao, required this.data});

  factory Anotacao.fromMap(Map<String, dynamic> json) => Anotacao(
      indice: json['indice'], anotacao: json['anotacoes'], data: json['data']);

  Map<String, dynamic> toJson() =>
      {"indice": indice, "anotacoes": anotacao, "data": data};
}
