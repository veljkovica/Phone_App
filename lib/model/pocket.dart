import "package:uuid/uuid.dart";

class Pocket {
  String uuid;
  String text;
  bool done = false;

  Pocket(this.text) : uuid = const Uuid().v4();
}
