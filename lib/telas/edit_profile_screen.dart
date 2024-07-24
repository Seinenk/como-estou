import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:provider/provider.dart';
import '../provedores/user_provider.dart';
import '../modelos/user_model.dart';

class EditProfileScreen extends StatefulWidget {
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _biographyController;
  final ImagePicker _picker = ImagePicker();
  XFile? _image;

  @override
  void initState() {
    super.initState();
    final userProfile = Provider.of<UserProvider>(context, listen: false).profile;
    _nameController = TextEditingController(text: userProfile.name);
    _biographyController = TextEditingController(text: userProfile.biography);
    _image = userProfile.imagePath.isNotEmpty ? XFile(userProfile.imagePath) : null;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _biographyController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final pickedImage = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = pickedImage;
    });
  }

  void _saveProfile() {
    if (_formKey.currentState!.validate()) {
      final userProfile = UserProfile(
        name: _nameController.text,
        biography: _biographyController.text,
        imagePath: _image?.path ?? '',
      );
      Provider.of<UserProvider>(context, listen: false).updateProfile(userProfile);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Editar Perfil')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Nome'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira seu nome';
                  }
                  return null;
                },
                textCapitalization: TextCapitalization.sentences,
              ),
              TextFormField(
                controller: _biographyController,
                decoration: InputDecoration(labelText: 'Biografia'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira sua biografia';
                  }
                  return null;
                },
                textCapitalization: TextCapitalization.sentences,
              ),
              SizedBox(height: 10),
              _image == null
                  ? Text('Nenhuma imagem selecionada.')
                  : Image.file(File(_image!.path)),
              ElevatedButton(
                onPressed: _pickImage,
                child: Text('Escolher Imagem'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.cyan,
                  foregroundColor: Colors.white,
                ),
              ),
              ElevatedButton(
                onPressed: _saveProfile,
                child: Text('Salvar Perfil'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.cyan,
                  foregroundColor: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}