import 'package:brew_crew/home/brew_list.dart';
import 'package:brew_crew/home/settings_form.dart';
import 'package:brew_crew/models/brew.dart';
import 'package:brew_crew/services/auth.dart';
import 'package:brew_crew/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class Home extends StatelessWidget {
  Home({super.key});

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    void _showSettingsPannel() {
      showModalBottomSheet(
        context: context, 
        builder: (context) {
          return Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
            child: SettingsForm(),
          );
        }
      );
    }

    return StreamProvider<List<Brew>?>.value(
      value: DatabaseService().brews,
      initialData: null,
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          title: Text("Brew Crew", style: TextStyle(color: Colors.white),),
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
          actions: [
            IconButton(
              onPressed: () {
                _showSettingsPannel();
              }, 
              icon: Icon(Icons.settings, color: Colors.white,)
            ),

            IconButton(
              onPressed: () async {
                await _auth.signOut();
              }, 
              icon: Icon(Icons.logout, color: Colors.white,)
            ),
          ],
        ),

        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/coffee_bg.png"),
              fit: BoxFit.cover,
            )
          ),
          child: BrewList()
        ),
      ),
    );
  }
}