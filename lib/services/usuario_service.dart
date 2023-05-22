import 'dart:convert';
import 'dart:io';

import 'package:examen_practic_castro/models/usuario.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UsuarioService extends ChangeNotifier {
  // Variables
  final String _baseUrl =
      'testpdm-f6e4f-default-rtdb.europe-west1.firebasedatabase.app';
  final List<Usuario> products = [];
  late Usuario selectedProduct;
  File? newPicture;
  bool isLoading = true;
  bool isSaving = false;

  UsuarioService() {
    this.loadUsuarios();
  }

  Future loadUsuarios() async {
    isLoading = true;
    notifyListeners();
    // Construimos la URL para obtener los productos
    final url = Uri.https(_baseUrl, 'usuarios.json');
    final resp = await http.get(url);
    // Decodificamos la respuesta JSON
    final Map<String, dynamic> usuariosMap = json.decode(resp.body);

    // Añadimos los productos a la lista
    usuariosMap.forEach((key, value) {
      final tempUser = Usuario.fromMap(value);
      tempUser.id = key;
      products.add(tempUser);
    });

    isLoading = false;
    notifyListeners();
  }

  Future saveProduct(Usuario usuario) async {
    isSaving = true;
    notifyListeners();

    // Si el producto no tiene ID, lo creamos
    if (usuario.id == null) {
      //Crear producto
      await createUser(usuario);
    }
    isSaving = false;
    notifyListeners();
  }

  // Función para crear un nuevo producto
  Future<String> createUser(Usuario usuario) async {
    // URL para crear un nuevo producto
    final url = Uri.https(_baseUrl, 'usuarios.json');
    // Petición POST con los datos del producto
    final resp = await http.post(url, body: usuario.toJson());
    final decodedData = json.decode(resp.body);
    usuario.id = decodedData['name'];

    // Añadimos el producto a la lista
    this.products.add(usuario);
    notifyListeners();
    return usuario.id!; // Devolvemos el ID del producto
  }

  void updateSelectedImage(String path) {
    this.newPicture = File.fromUri(Uri(path: path));
    this.selectedProduct.photo = path;
    notifyListeners();
  }

  // Función que sube una imagen a Cloudinary
  Future<String?> uploadImage() async {
    if (this.newPicture == null) return null;

    this.isSaving = true;
    notifyListeners();
    // URL de la API de Cloudinary
    final url = Uri.parse(
        'https://api.cloudinary.com/v1_1/dwhybgksl/image/upload?upload_preset=bvp6qmvx');

    // Crea una petición de envío
    final imageUploadRequest = http.MultipartRequest('POST', url);
    // Agrega la imagen a la petición
    final file = await http.MultipartFile.fromPath('file', newPicture!.path);
    imageUploadRequest.files.add(file);
    // Envía y respuesta
    final streamRespose = await imageUploadRequest.send();
    final resp = await http.Response.fromStream(streamRespose);

    // Si la respuesta no tiene código 200 o 201, muestra un mensaje de error y retorna null
    if (resp.statusCode != 200 && resp.statusCode != 201) {
      print('ERROR');
      print(resp.body);
      return null;
    }
    // Decodifica la respuesta para obtener la URL de la imagen
    this.newPicture = null;
    final decodeData = json.decode(resp.body);
    return decodeData['secure_url'];
  }
}
