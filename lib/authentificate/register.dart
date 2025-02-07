import 'package:brew_crew/services/auth.dart';
import 'package:brew_crew/shared/constantes.dart';
import 'package:brew_crew/shared/loading.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {

  final Function toggleView;

  const Register({
    super.key,
    required this.toggleView
  });

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  
  // textfield state
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text("S'inscrire à Brew Crew", style: TextStyle(color: Colors.white, fontSize: 20),),
        actions: [
          ElevatedButton.icon(
            style: const ButtonStyle(
              padding: WidgetStatePropertyAll(EdgeInsets.symmetric(horizontal: 10, vertical: 8))
            ),
            icon: Icon(
              Icons.person,
              size: 20,
            ),
            onPressed: () {
              widget.toggleView();
            },
            label: Text("Se connecter", style: TextStyle(fontSize: 13),),
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(height: 20,),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'Email'),
                validator: (value) => value!.isEmpty ? 'Entrer un email' : null,
                onChanged: (value) {
                  setState(() {
                    email = value;
                  });
                }
              ),
              
              SizedBox(height: 20,),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'Mot de Passe'),
                obscureText: true,
                validator: (value) => value!.length < 6 ? 'Entrer un Mot de passe de plus de 6 caractères' : null,
                onChanged: (value) {
                  setState(() {
                    password = value;
                  });
                },
              ),

              SizedBox(height: 20,),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    setState(() {
                      loading = true;
                    });
                    dynamic result = await _auth.registerWithEmalAndPassword(email, password);
                    if (result == null) {
                      setState(() {
                        error = 'Email ou mot de passe invalides';
                        loading = false;
                      });
                    }
                  }
                }, 
                child: Text(
                  "S'isncrire",
                  style: TextStyle(color: Colors.white),
                ),
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(Colors.pink[400]),
                  shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)))
                ),
              ),
              SizedBox(height: 12,),

              Text(
                error,
                style: TextStyle(
                  color: Colors.red, 
                  fontSize: 14
                ),
              )

            ],
          ),
        ),
      )
    );
  }
}