import 'package:flutter/material.dart';
import 'package:pocket_list/pages/add_note_page.dart';
import 'package:pocket_list/pages/pocket_list_page.dart';
import 'package:provider/provider.dart';

import 'model/PocketList.dart';

void main() {
  Pocketlist pockets = Pocketlist();

  runApp(PocketApp(pockets));
}

class PocketApp extends StatelessWidget {
  final Pocketlist pockets;

  PocketApp(this.pockets, {super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => pockets,
      child: MaterialApp(
        title: 'Pocket of the day',
        theme: ThemeData(
          primarySwatch: Colors.pink,
        ),
        home: PocketlistPage(),
      ),
    );
  }
}