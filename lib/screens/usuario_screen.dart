import 'package:examen_practic_castro/providers/usuario_form_provider.dart';
import 'package:examen_practic_castro/services/usuario_service.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../ui/input_decorations.dart';
import '../widgets/usuario_image.dart';

class UsuarioScreen extends StatelessWidget {
  const UsuarioScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final usuarioService = Provider.of<UsuarioService>(context);

    return ChangeNotifierProvider(
        create: (_) => UsuarioFormProvider(usuarioService.selectedProduct),
        child: _UsuarioScreenBody(usuarioService: usuarioService));
  }
}

class _UsuarioScreenBody extends StatelessWidget {
  const _UsuarioScreenBody({
    Key? key,
    required this.usuarioService,
  }) : super(key: key);

  final UsuarioService usuarioService;

  @override
  Widget build(BuildContext context) {
    final productForm = Provider.of<UsuarioFormProvider>(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                UsuarioImage(url: usuarioService.selectedProduct.photo),
                Positioned(
                  top: 60,
                  left: 20,
                  child: IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: Icon(
                      Icons.arrow_back_ios_new,
                      size: 30,
                      color: Colors.white,
                    ),
                  ),
                ),
                Positioned(
                  top: 60,
                  right: 20,
                  child: IconButton(
                    onPressed: () async {
                      //instancia de ImagePicker
                      final ImagePicker picker = ImagePicker();
                      // Muestra un diálogo que permite al usuario seleccionar una fuente de imagen
                      await showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("Selecciona una fuente"),
                            actions: [
                              TextButton(
                                child: Text("Cámara"),
                                onPressed: () {
                                  // Devuelve imagen de la cámara
                                  Navigator.pop(context, ImageSource.camera);
                                },
                              ),
                              TextButton(
                                child: Text("Galería"),
                                onPressed: () {
                                  // Devuelve imagen de la galería
                                  Navigator.pop(context, ImageSource.gallery);
                                },
                              ),
                            ],
                          );
                        },
                      ).then((source) async {
                        if (source != null) {
                          // Obtiene la imagen utilizando la fuente seleccionada.
                          final XFile? photo =
                              await picker.pickImage(source: source);
                          // Actualiza la imagen
                          usuarioService.updateSelectedImage(photo!.path);
                        }
                      });
                    },
                    icon: Icon(
                      Icons.camera_alt_outlined,
                      size: 30,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            _UserForm(),
            SizedBox(
              height: 100,
            )
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
          child: usuarioService.isSaving
              ? CircularProgressIndicator(color: Colors.white)
              : Icon(Icons.save_outlined),
          onPressed: usuarioService.isSaving
              ? null
              : (() async {
                  productForm.isValidForm();
                  if (!productForm.isValidForm()) return;
                  final String? imageUrl = await usuarioService.uploadImage();
                  if (imageUrl != null)
                    productForm.tempUsuario.photo = imageUrl;
                  usuarioService.saveProduct(productForm.tempUsuario);
                })),
    );
  }
}

class _UserForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userForm = Provider.of<UsuarioFormProvider>(context);
    final tempProduct = userForm.tempUsuario;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        decoration: _buildBoxDecoration(),
        child: Form(
          key: userForm.formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              SizedBox(height: 10),
              TextFormField(
                initialValue: tempProduct.name,
                onChanged: (value) => tempProduct.name = value,
                validator: (value) {
                  if (value == null || value.length < 1)
                    return 'Nombre obligatorio';
                },
                decoration: InputDecorations.authInputDecoration(
                    hintText: 'Nom del producte',
                    labelText: 'Nom del producte'),
              ),
              SizedBox(height: 30),
              TextFormField(
                initialValue: tempProduct.email,
                onChanged: (value) => tempProduct.email = value,
                validator: (value) {
                  if (value == null || value.length < 1)
                    return 'email obligatorio';
                },
                decoration: InputDecorations.authInputDecoration(
                    hintText: 'email', labelText: 'email'),
              ),
              SizedBox(height: 30),
              TextFormField(
                initialValue: tempProduct.address,
                onChanged: (value) => tempProduct.address = value,
                validator: (value) {
                  if (value == null || value.length < 1)
                    return 'adress obligatorio';
                },
                decoration: InputDecorations.authInputDecoration(
                    hintText: 'adress', labelText: 'adress'),
              ),
              SizedBox(height: 30),
              TextFormField(
                initialValue: tempProduct.phone,
                onChanged: (value) => tempProduct.phone = value,
                validator: (value) {
                  if (value == null || value.length < 1)
                    return 'phone obligatorio';
                },
                decoration: InputDecorations.authInputDecoration(
                    hintText: 'phone', labelText: 'phone'),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  // Lógica para iniciar sesión
                  Navigator.pushNamed(context, "home");
                },
                child: Text('Eliminar usuario'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  BoxDecoration _buildBoxDecoration() => BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(25),
          bottomLeft: Radius.circular(25),
        ),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.05),
              offset: Offset(0, 5),
              blurRadius: 5),
        ],
      );
}
