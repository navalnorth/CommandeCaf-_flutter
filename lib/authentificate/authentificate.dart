import 'package:brew_crew/authentificate/sign_in.dart';
import 'package:flutter/material.dart';

class Authentificate extends StatefulWidget {
  const Authentificate({super.key});

  @override
  State<Authentificate> createState() => _AuthentificateState();
}

class _AuthentificateState extends State<Authentificate> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SignIn(),
    );
  }
}