
import 'package:flutter/material.dart';
import 'package:pocket_list/model/pocket.dart';


class Pocketlist extends ChangeNotifier {
  
  final List<Pocket> _pockets = [
    Pocket("Vom Eifelturm springen"),
    Pocket("1 kg Sand am Meer essen"),
    Pocket("Familie gründen"),
  ];

  List<Pocket> getPocketList() {
    return _pockets;
  }

  void addPocket(String text) {
    _pockets.add(Pocket(text));
    notifyListeners();
  }

  void updatePocket(Pocket pocket) {}
}
