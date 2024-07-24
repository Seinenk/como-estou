import 'package:flutter/material.dart';
import '../modelos/user_model.dart';

class UserProvider with ChangeNotifier {
  UserProfile _profile = UserProfile(name: 'Nome', biography: 'Biografia', imagePath: '');

  UserProfile get profile => _profile;

  void updateProfile(UserProfile profile) {
    _profile = profile;
    notifyListeners();
  }
}