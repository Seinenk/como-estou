import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provedores/entry_provider.dart';
import '../modelos/entry_model.dart';
import '../telas/add_edit_entry_screen.dart';
import '../widgets/bottom_nav_bar.dart';
import '../widgets/add_note_button.dart';
import 'package:google_fonts/google_fonts.dart';

class EntryListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final entryProvider = Provider.of<EntryProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Lista de humor')),
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
          ListView.builder(
            itemCount: entryProvider.entries.length,
            itemBuilder: (ctx, index) {
              final entry = entryProvider.entries[index];
              return ListTile(
                title: Text(entry.mood),
                subtitle: Text(entry.description),
                trailing: IconButton(
                  icon: Icon(Icons.delete, color: Colors.cyan),
                  onPressed: () {
                    entryProvider.deleteEntry(entry.id);
                  },
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddEditEntryScreen(entry: entry),
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
      floatingActionButton: AddNoteButton(),
      bottomNavigationBar: BottomNavBar(),
      backgroundColor: Colors.white,
    );
  }
}