import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pocket_list/model/PocketList.dart';
import 'package:pocket_list/model/pocket.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:vibration/vibration.dart';

import 'add_note_page.dart';

class PocketlistPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _PocketlistPageState();
  }
}

class _PocketlistPageState extends State<PocketlistPage> {
  final TextEditingController txtController = TextEditingController();

  @override
  void dispose() {
    txtController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add to Pocketlist"),
      ),
      body: Center(
        child: Column(
          children: [
            pocketForm(context, txtController),
            Expanded(child: Pocketlisfghjt(context)),
          ],
        ),
      ),
    );
  }

  Widget pocketForm(
      BuildContext context, TextEditingController txtController) {
    var pockets = Provider.of<Pocketlist>(context);

    return Column(
      children: [
        TextField(
          controller: txtController,
          decoration: const InputDecoration(
              hintText: "--> Enter your wish here"),
        ),
        ElevatedButton(
          onPressed: () {
            if (txtController.text.isNotEmpty) {
              pockets.addPocket(txtController.text);
              txtController.text = "";
            }
          },
          child: Text("Add"),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddNotePage()),
          );
          },
          child: Text("Brainstorming Board"),
        ),
      ],
    );
  }

  Widget Pocketlisfghjt(BuildContext context) {
    var pockets = Provider.of<Pocketlist>(context);
    return Card(
      child: ListView.builder(
        itemCount: pockets.getPocketList().length,
        itemBuilder: (context, index) {
          final kind = pockets.getPocketList()[index];
          return Dismissible(
            key: Key(kind.uuid),
            background: Container(
              color: Colors.green,
              child: Align(
                child: Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Icon(Icons.favorite),
                ),
                alignment: Alignment.centerLeft,
              ),
            ),
            secondaryBackground: Container(
              color: Colors.red,
              child: Align(
                child: Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: Icon(Icons.delete),
                ),
                alignment: Alignment.centerRight,
              ),
            ),
            confirmDismiss: (direction) async {
              if (direction == DismissDirection.startToEnd) {
                kind.done = true;
                _performRightSwipeAction(kind, pockets);
                return false;
              } else {
                bool delete = true;
                final snackbarController = ScaffoldMessenger.of(context)
                    .showSnackBar(
                  SnackBar(
                    content: Text('Deleted ${kind.text}'),
                    action: SnackBarAction(
                        label: 'Undo', onPressed: () => delete = false),
                  ),
                );
                playSound();
                Vibration.vibrate(duration: 1000);
                HapticFeedback.heavyImpact();
                await snackbarController.closed;
                return delete;
              }
            },
            onDismissed: (_) {
              setState(() {
                pockets.getPocketList().removeAt(index);
              });
            },
            child: GestureDetector(
              onTap: (){
                setState(() {
                  print('todo -----------------------------------');
                });
              },
              child: Container(
                margin: EdgeInsets.all(6),
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  title: Text(kind.text),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _performRightSwipeAction(Pocket pocket, Pocketlist pockets) {
    setState(() {
      pocket.text = "Text wurde geändert";
      pockets.updatePocket(pocket);
    });
  }

  playSound() {
    AudioPlayer().play(AssetSource("blingbling.mp3"));
  }
}