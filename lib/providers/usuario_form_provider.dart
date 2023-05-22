import 'package:examen_practic_castro/models/usuario.dart';
import 'package:flutter/material.dart';

class UsuarioFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = new GlobalKey<FormState>();

  Usuario tempUsuario;

  UsuarioFormProvider(this.tempUsuario);

  bool isValidForm() {
    print(tempUsuario.name);
    print(tempUsuario.email);
    return formKey.currentState?.validate() ?? false;
  }
}
