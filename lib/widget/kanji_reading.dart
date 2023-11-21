
import 'package:flutter/material.dart';
import 'clipboardbox.dart';

enum KanjiReadingType { onReading, kunReading }

class KanjiReading extends StatefulWidget {
  KanjiReading({required this.kanji, required this.readingType,this.frontTF, this.backTF,
   this.onMeaningInput, this.onReadingInput});

  final String kanji;
  final String? frontTF;
  final String? backTF;
  final KanjiReadingType readingType;
  void Function(String)? onReadingInput;
  void Function(String)? onMeaningInput; 

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
  void initState() {
    if(widget.frontTF != null){
      setReading(widget.frontTF!);
    }

    if(widget.backTF != null){
      setMeaning(widget.backTF!);
    }
    super.initState();
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
            controller: TextEditingController.fromValue(TextEditingValue(text: _reading)),
            onChanged: (value) {
              setReading(value);
              widget.onReadingInput!(_reading);
            },
          ),
          Text('Meaning'),
          TextField(
            controller: TextEditingController.fromValue(TextEditingValue(text: _meaning)),
            onChanged: (value) {
              setMeaning(value);
              widget.onMeaningInput!(_meaning);
            },
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
            Column(
              children: [
                Text('Front'),
              ReadingClipBoardBox(
              kanji: widget.kanji,
              reading: _reading,
              meaning: _meaning,
              side: FlashCardSide.front,
              flashCardType: type),
              ],
            ),
            Column(
              children: [
                Text('Back'),
              ReadingClipBoardBox(
              kanji: widget.kanji,
              reading: _reading,
              meaning: _meaning,
              side: FlashCardSide.back,
              flashCardType: type),
              ],
            )
          ],),
          
          SizedBox(
            height: 5,
          ),
          
        ],
      ),
    );
  }
}
