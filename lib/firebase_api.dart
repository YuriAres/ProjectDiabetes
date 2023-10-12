// ignore_for_file: file_names
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
      required DateTime data}) async {
    final anotacao =
        Anotacao(indice: indice, anotacao: newAnotacao, data: data.toString());

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
}
