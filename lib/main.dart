import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './provedores/entry_provider.dart';
import './provedores/user_provider.dart';
import './telas/entry_list_screen.dart';

void main() {
  runApp(MoodJournalApp());
}

class MoodJournalApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => EntryProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: MaterialApp(
        title: 'Mood Journal',
        theme: ThemeData(
          primarySwatch: Colors.cyan,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: EntryListScreen(),
      ),
    );
  }
}