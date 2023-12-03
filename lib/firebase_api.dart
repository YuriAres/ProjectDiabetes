// ignore_for_file: file_names
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_diabetes/model/alarm.dart';
import 'package:flutter_diabetes/model/anotacoes.dart';
import 'package:flutter_diabetes/model/usuario.dart';

class FirebaseAPI {
  Future createUser(
      {required String email,
      required String nome,
      required int idade,
      required String sexo,
      required String senha,
      required String tipo}) async {
    final usuario = Usuario(
        email: email,
        nome: nome,
        idade: idade,
        sexo: sexo,
        senha: senha,
        tipo: tipo);

    final json = usuario.toJson();

    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: senha);

    final DocUser = FirebaseFirestore.instance
        .collection('usuarios')
        .doc(FirebaseAuth.instance.currentUser!.uid);

    await DocUser.set(json);
  }

  Future createAnotacao(
      {required num indice,
      required String newAnotacao,
      required String id,
      required DateTime data,
      required String medicacao}) async {
    final anotacao = Anotacao(
        indice: indice,
        anotacao: newAnotacao,
        data: data.toString(),
        medicacao: medicacao);

    final json = anotacao.toJson();
    final docUser = FirebaseFirestore.instance
        .collection('usuarios')
        .doc(id)
        .collection('anotacoes')
        .doc("Anotacao $data");

    await docUser.set(json);
  }

  Future deleteAnotacao({required String name, required String id}) async {
    FirebaseFirestore.instance
        .collection('usuarios')
        .doc(id)
        .collection('anotacoes')
        .doc("Anotacao $name")
        .delete();
  }

  Future createAlarm(
      {required String nome,
      required int horas,
      required int minutos,
      required String id,
      required DateTime data}) async {
    final alarm =
        Alarm(nome: nome, hora: horas, minutos: minutos, data: data.toString());

    final json = alarm.toJson();
    final docUser = FirebaseFirestore.instance
        .collection('usuarios')
        .doc(id)
        .collection('alarmes')
        .doc("Alarme $nome - $data");

    await docUser.set(json);
  }

  Future deleteAlarm(
      {required String name, required String id, required String data}) async {
    FirebaseFirestore.instance
        .collection('usuarios')
        .doc(id)
        .collection('alarmes')
        .doc("Alarme $name - $data")
        .delete();
  }
}
