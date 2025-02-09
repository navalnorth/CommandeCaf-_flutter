import 'package:brew_crew/models/user.dart';
import 'package:brew_crew/services/database.dart';
import 'package:brew_crew/shared/constantes.dart';
import 'package:brew_crew/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  const SettingsForm({super.key});

  @override
  State<SettingsForm> createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> sugars = ['0','1','2','3','4',];

  String? _currentName;
  String? _currentSugars;
  int? _currentStrength;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserObject?>(context);

    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: user!.uid).userData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          UserData userData = snapshot.data!;
          
          return Form(
          key: _formKey,
          child: Column(
            children: [
              const Text(
                "Modifier les besoins",
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 20,),
        
              TextFormField(
                initialValue: userData.name,
                decoration: textInputDecoration,
                validator: (value) {
                  value!.isEmpty ? 'Entrez un nom' : null;
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    _currentName = value;
                  });
                },
              ),
              SizedBox(height: 20,),
        
              DropdownButtonFormField(
                value: _currentSugars ?? userData.sugars,
                items: sugars.map((sugar) {
                  return DropdownMenuItem(
                    value: sugar,
                    child: Text("$sugar sucres"),
                  );
                }).toList(), 
                onChanged: (value) {
                  setState(() {
                    _currentSugars = value;
                  });
                }
              ),
              SizedBox(height: 20,),
        
              Slider(
                min: 100.0,
                max: 900.0,
                divisions: 8,
                value: (_currentStrength ?? userData.strength).toDouble(), 
                activeColor: Colors.brown[_currentStrength ?? 100],
                onChanged: (value) {
                  setState(() {
                    _currentStrength = value.round();
                  });
                }
              ),
              SizedBox(height: 20,),
        
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(Colors.pink[400])
                ),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    DatabaseService(uid: user.uid).updateUserData(
                      _currentSugars ?? userData.sugars,
                      _currentName ?? userData.name,
                      _currentStrength ?? userData.strength
                    );
                    Navigator.pop(context);
                  }
                }, 
                child: Text(
                  'Changer',
                  style: TextStyle(color: Colors.white),
                  ),
              )
            ],
          )
        );
        } else {
          return Loading();
        }
        
      }
    );
  }
}