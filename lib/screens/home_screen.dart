import 'package:examen_practic_castro/models/usuario.dart';
import 'package:examen_practic_castro/widgets/user_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/services.dart';
import 'screens.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final usuarioService = Provider.of<UsuarioService>(context);

    if (usuarioService.isLoading) return LoadingScreen();
    return Scaffold(
      appBar: AppBar(
        title: Text('Productes'),
      ),
      body: ListView.builder(
        itemCount: usuarioService.products.length,
        itemBuilder: (BuildContext context, int index) => GestureDetector(
          child: UserCard(usuario: usuarioService.products[index]),
          onTap: () {
            usuarioService.newPicture = null;
            usuarioService.selectedProduct =
                usuarioService.products[index].copy();
            Navigator.of(context).pushNamed('usuario');
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          usuarioService.newPicture = null;
          usuarioService.selectedProduct = Usuario(
              name: "name",
              email: "email",
              address: "address",
              phone: "phone",
              photo: "photo");
          Navigator.of(context).pushNamed('usuario');
        },
      ),
    );
  }
}
