import 'package:brew_crew/authentificate/authentificate.dart';
import 'package:brew_crew/home/home.dart';
import 'package:brew_crew/models/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserObject?>(context);

    //retoune Home ou Authentificate
    if (user == null) {
      return Authentificate();
    } else {
      return Home();
    }
  }
}