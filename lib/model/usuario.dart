class Usuario {
  final String email;
  final String nome;
  final int idade;
  final String sexo;
  String senha;
  final String tipo;

  Usuario(
      {required this.email,
      required this.nome,
      required this.idade,
      required this.sexo,
      required this.senha,
      required this.tipo});

  factory Usuario.fromMap(Map<String, dynamic> json) => Usuario(
      email: json['email'],
      nome: json['name'],
      idade: json['idade'],
      sexo: json['sexo'],
      senha: json['senha'],
      tipo: json['tipo']);

  Map<String, dynamic> toJson() => {
        "email": email,
        "name": nome,
        "idade": idade,
        "sexo": sexo,
        "senha": senha,
        "tipo": tipo
      };
}
