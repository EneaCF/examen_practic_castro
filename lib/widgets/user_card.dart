import 'package:examen_practic_castro/models/usuario.dart';
import 'package:flutter/material.dart';

class UserCard extends StatelessWidget {
  final Usuario usuario;
  const UserCard({Key? key, required this.usuario}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        margin: EdgeInsets.only(top: 30, bottom: 50),
        width: double.infinity,
        height: 150,
        decoration: _cardBorders(),
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: [
            _BackgroudWidget(url: usuario.photo),
            _UserDetails(
                name: usuario.name,
                email: usuario.email,
                subtitle: usuario.id!),
          ],
        ),
      ),
    );
  }

  BoxDecoration _cardBorders() => BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(0, 7),
            blurRadius: 10,
          ),
        ],
      );
}

class _BackgroudWidget extends StatelessWidget {
  final String? url;

  const _BackgroudWidget({Key? key, required this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(25),
      child: Container(
        width: double.infinity,
        height: 150,
      ),
    );
  }
}

class _UserDetails extends StatelessWidget {
  final String name, subtitle, email;

  const _UserDetails(
      {Key? key,
      required this.name,
      required this.subtitle,
      required this.email})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 50),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        width: double.infinity,
        height: 70,
        decoration: _buildBoxDecoration(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              email,
              style: TextStyle(
                  fontSize: 12,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  BoxDecoration _buildBoxDecoration() => BoxDecoration(
        color: Colors.indigo,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
      );
}
