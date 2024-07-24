import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provedores/user_provider.dart';
import '../modelos/user_model.dart';
import '../widgets/bottom_nav_bar.dart';
import 'edit_profile_screen.dart';
import 'dart:io';
import 'package:google_fonts/google_fonts.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userProfile = Provider.of<UserProvider>(context).profile;

    return Scaffold(
      appBar: AppBar(title: Text('Perfil')),
      body: Stack(
        children: [
          Center(
            child: Text(
              'Como estou',
              style: GoogleFonts.pacifico(
                textStyle: TextStyle(
                  fontSize: 60,
                  color: Colors.cyan.withOpacity(0.1),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Center(
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: userProfile.imagePath.isNotEmpty
                        ? FileImage(File(userProfile.imagePath))
                        : null,
                    backgroundColor: Colors.cyan,
                    child: userProfile.imagePath.isEmpty
                        ? Icon(Icons.person, size: 50, color: Colors.white)
                        : null,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Nome: ${userProfile.name}',
                  style: TextStyle(fontSize: 18, color: Colors.cyan),
                ),
                SizedBox(height: 10),
                Text(
                  'Biografia: ${userProfile.biography}',
                  style: TextStyle(fontSize: 18, color: Colors.cyan),
                ),
                SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditProfileScreen(),
                        ),
                      );
                    },
                    child: Text('Editar Perfil'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.cyan,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavBar(),
      backgroundColor: Colors.white,
    );
  }
}