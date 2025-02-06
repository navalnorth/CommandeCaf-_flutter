import 'package:brew_crew/authentificate/authentificate.dart';
import 'package:flutter/material.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    //retoune Home ou Authentificate
    return Authentificate();
  }
}