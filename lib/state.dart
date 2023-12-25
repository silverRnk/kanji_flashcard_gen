
import 'package:flutter/material.dart';
import 'package:kanji_flashcard_gen/model/KanjiCard.dart';

class KanjiCardModel extends ChangeNotifier {

  final List<KanjiCard> _items = [];

  List<KanjiCard> get items => _items;

  add(KanjiCard item){
    _items.add(item);
    notifyListeners();
  }

  removeItem(KanjiCard item){
    _items.remove(item);
    notifyListeners();
  }
}