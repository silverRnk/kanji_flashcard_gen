import 'package:flutter/material.dart';
import 'package:kanji_flashcard_gen/widget/ClipboardBox.dart';

class AddVocabPage extends StatefulWidget {
  const AddVocabPage({super.key});

  @override
  State<AddVocabPage> createState() => _AddVocabPageState();
}

class _AddVocabPageState extends State<AddVocabPage> {
  String _word = '';
  String _reading = '';
  String _meaning = '';

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Text(
          'Add a vocabulary',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          'Word',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        TextField(onChanged: (value) {
          setState(() {
            _word = value;
          });
        },),
        SizedBox(
          height: 10,
        ),
        Text(
          'Reading',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        TextField(onChanged: (value) {
          setState(() {
            _reading = value;
          });
        },),
        SizedBox(
          height: 10,
        ),
        Text(
          'Meaning',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        TextField(onChanged: (value) {
          setState(() {
            _meaning = value;
          });
        },),
        SizedBox(
          height: 10,
        ),
        ClipBoardBox(
            data: _word,
            side: FlashCardSide.front,
            flashCardType: KanjiFlashCardType.vocab),
        SizedBox(height: 5,),
        ClipBoardBox(
            data: '$_reading ($_meaning)',
            side: FlashCardSide.back,
            flashCardType: KanjiFlashCardType.vocab),
        
      ],
    );
  }
}
