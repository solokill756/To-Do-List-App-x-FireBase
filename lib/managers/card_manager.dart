import 'package:todolist/models/item.dart';

class CardManager {
  final List<Item> items = [];
  void addItem(String content) {
    Item newItem = Item(id: DateTime.now().toString(), content: content);
    items.add(newItem);
  }

  void deleteCard(String id) {
    items.removeWhere((item) => item.id == id);
  }
}
