class Alarm {
  final String nome;
  final int hora;
  final int minutos;
  final String data;

  Alarm(
      {required this.nome,
      required this.hora,
      required this.minutos,
      required this.data});

  factory Alarm.fromMap(Map<String, dynamic> json) => Alarm(
      nome: json['nome'],
      hora: json['hora'],
      minutos: json['minutos'],
      data: json['data']);

  Map<String, dynamic> toJson() =>
      {"nome": nome, "hora": hora, "minutos": minutos, "data": data};
}
