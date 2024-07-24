import 'package:flutter/material.dart';
import '../telas/entry_list_screen.dart';
import '../telas/profile_screen.dart';

class BottomNavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.list, color: Colors.cyan),
          label: 'Lista',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person, color: Colors.cyan),
          label: 'Perfil',
        ),
      ],
      currentIndex: 0,
      selectedItemColor: Colors.cyan,
      onTap: (index) {
        if (index == 0) {
          Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (_, __, ___) => EntryListScreen(),
              transitionsBuilder: (_, animation, __, child) {
                return SlideTransition(
                  position: Tween<Offset>(begin: Offset(-1, 0), end: Offset(0, 0))
                      .animate(animation),
                  child: child,
                );
              },
            ),
          );
        } else if (index == 1) {
          Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (_, __, ___) => ProfileScreen(),
              transitionsBuilder: (_, animation, __, child) {
                return SlideTransition(
                  position: Tween<Offset>(begin: Offset(1, 0), end: Offset(0, 0))
                      .animate(animation),
                  child: child,
                );
              },
            ),
          );
        }
      },
    );
  }
}