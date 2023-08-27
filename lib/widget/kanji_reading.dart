
import 'package:flutter/material.dart';
import 'clipboardbox.dart';

enum KanjiReadingType { onReading, kunReading }

class KanjiReading extends StatefulWidget {
  KanjiReading({required this.kanji, required this.readingType});

  final String kanji;
  final KanjiReadingType readingType;

  @override
  State<KanjiReading> createState() => _KanjiReadingState();
}

class _KanjiReadingState extends State<KanjiReading> {
  String _reading = '';
  String _meaning = '';

  void setReading(String input) {
    setState(() {
      _reading = input;
    });
  }

  void setMeaning(String input) {
    setState(() {
      _meaning = input;
    });
  }

  @override
  Widget build(BuildContext context) {
    String label;
    KanjiFlashCardType type;

    switch (widget.readingType) {
      case KanjiReadingType.onReading:
        label = 'On Reading';
        type = KanjiFlashCardType.onReading;
        break;
      case KanjiReadingType.kunReading:
        label = 'Kun Reading';
        type = KanjiFlashCardType.kunReading;
        break;
      default:
        label = '';
        type = KanjiFlashCardType.vocab;
    }

    return Padding(
      padding: const EdgeInsets.fromLTRB(20.0, 0, 0, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 5,
          ),
          Text(
            label,
            textAlign: TextAlign.start,
          ),
          TextField(
            onChanged: (value) {
              setReading(value);
              print(_reading);
            },
          ),
          Text('Meaning'),
          TextField(
            onChanged: (value) {
              setMeaning(value);
            },
          ),
          SizedBox(
            height: 5,
          ),
          ReadingClipBoardBox(
              kanji: widget.kanji,
              reading: _reading,
              meaning: _meaning,
              side: FlashCardSide.front,
              flashCardType: type),
          SizedBox(
            height: 5,
          ),
          ReadingClipBoardBox(
              kanji: widget.kanji,
              reading: _reading,
              meaning: _meaning,
              side: FlashCardSide.back,
              flashCardType: type),
        ],
      ),
    );
  }
}
