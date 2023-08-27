
import 'package:flutter/material.dart';
import 'package:kanji_flashcard_gen/widget/clipboardbox.dart';
import 'package:kanji_flashcard_gen/widget/kanji_reading.dart';

class CreateKanjiPage extends StatefulWidget {
  CreateKanjiPage({super.key});

  @override
  State<CreateKanjiPage> createState() => _CreateKanjiPage();
}

class _CreateKanjiPage extends State<CreateKanjiPage> {
  String _kanji = '';

  void _setKanji(String string) {
    setState(() {
      _kanji = string;
    });
  }

  @override
  Widget build(BuildContext context){

    return ListView(
                children: <Widget>[
                  const Text(
                    'Create a flash card',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900),
                  ),
                  const Text(
                    'Kanji Character',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  TextField(
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      _setKanji(value);
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Memonics and Picture',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  TextField(
                    textAlign: TextAlign.center,
                    decoration:
                        InputDecoration(label: Text('Paste your pic here')),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  ClipBoardBox(
                      data: _kanji,
                      side: FlashCardSide.front,
                      flashCardType: KanjiFlashCardType.memonicAndPic),
                  SizedBox(
                    height: 5,
                  ),
                  ClipBoardBox(
                      data: _kanji,
                      side: FlashCardSide.back,
                      flashCardType: KanjiFlashCardType.memonicAndPic),
                  Text(
                    'Stroke Pic',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  TextField(
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  ClipBoardBox(
                      data: _kanji,
                      side: FlashCardSide.front,
                      flashCardType: KanjiFlashCardType.stroke),
                  const SizedBox(
                    height: 5.0,
                  ),
                  ClipBoardBox(
                      data: '',
                      side: FlashCardSide.back,
                      flashCardType: KanjiFlashCardType.stroke),
                  const SizedBox(
                    height: 5.0,
                  ),
                  const Divider(
                    color: Colors.black,
                    height: 2.0,
                    thickness: 2.0,
                  ),
                  const Text(
                    'Add an On Reading',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  KanjiReading(
                      kanji: _kanji, readingType: KanjiReadingType.onReading),
                  const Divider(
                    color: Colors.black,
                    height: 2.0,
                    thickness: 2.0,
                  ),
                  const Text(
                    'Add an On Reading',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  KanjiReading(
                      kanji: _kanji, readingType: KanjiReadingType.kunReading),
                ],
              );
  }
}