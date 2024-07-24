import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:provider/provider.dart';
import '../provedores/entry_provider.dart';
import '../modelos/entry_model.dart';

class AddEditEntryScreen extends StatefulWidget {
  final Entry? entry;

  AddEditEntryScreen({this.entry});

  @override
  _AddEditEntryScreenState createState() => _AddEditEntryScreenState();
}

class _AddEditEntryScreenState extends State<AddEditEntryScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _moodController;
  late TextEditingController _descriptionController;
  final ImagePicker _picker = ImagePicker();
  XFile? _image;

  @override
  void initState() {
    super.initState();
    if (widget.entry != null) {
      _moodController = TextEditingController(text: widget.entry!.mood);
      _descriptionController = TextEditingController(text: widget.entry!.description);
      _image = widget.entry!.imagePath.isNotEmpty ? XFile(widget.entry!.imagePath) : null;
    } else {
      _moodController = TextEditingController();
      _descriptionController = TextEditingController();
    }
  }

  @override
  void dispose() {
    _moodController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final pickedImage = await _picker.pickImage(source: ImageSource.camera);
    setState(() {
      _image = pickedImage;
    });
  }

  void _saveEntry() {
    if (_formKey.currentState!.validate()) {
      final entry = Entry(
        id: widget.entry?.id ?? DateTime.now().toString(),
        mood: _moodController.text,
        description: _descriptionController.text,
        imagePath: _image?.path ?? '',
        date: widget.entry?.date ?? DateTime.now(),  // Adicionando o campo 'date'
      );
      if (widget.entry == null) {
        Provider.of<EntryProvider>(context, listen: false).addEntry(entry);
      } else {
        Provider.of<EntryProvider>(context, listen: false).updateEntry(entry);
      }
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.entry == null ? 'Adicionar Humor' : 'Editar Humor')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _moodController,
                decoration: InputDecoration(labelText: 'Humor'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira um humor';
                  }
                  return null;
                },
                textCapitalization: TextCapitalization.sentences,
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Descrição'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira uma descrição';
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
                child: Text('Adicionar imagem'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.cyan,
                  foregroundColor: Colors.white,
                ),
              ),
              ElevatedButton(
                onPressed: _saveEntry,
                child: Text('Salvar humor'),
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