class Alarm {
  final String nome;
  final int hora;
  final int minutos;

  Alarm({
    required this.nome,
    required this.hora,
    required this.minutos,
  });

  factory Alarm.fromMap(Map<String, dynamic> json) => Alarm(
        nome: json['nome'],
        hora: json['hora'],
        minutos: json['minutos'],
      );

  Map<String, dynamic> toJson() => {
        "nome": nome,
        "hora": hora,
        "minutos": minutos,
      };
}
