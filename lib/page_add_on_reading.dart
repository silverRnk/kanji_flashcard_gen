import 'package:flutter/material.dart';
import 'package:kanji_flashcard_gen/widget/kanji_reading.dart';
import 'package:kanji_flashcard_gen/widget/onreading.dart';

class AddOnReadingPage extends StatelessWidget {
  final String kanji;
  final OnReadingItem? onReading;
  final int? id;
  const AddOnReadingPage({super.key, required this.kanji, this.onReading, this.id});

  @override
  Widget build(BuildContext context) {
    String meaning = onReading?.meaning ?? "";
    String reading = onReading?.reading ?? "";

    return Container(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: () {
          Navigator.pop(context);
        },),
        title: Text('add an on reading'),),
        body: Column(children: [
          KanjiReading(
            kanji: kanji, readingType: KanjiReadingType.onReading,
            frontTF: reading,
            backTF: meaning,
            onMeaningInput: (input) {
            meaning = input;
          },
          onReadingInput: (input) {
            reading = input;
          },),
          SizedBox(height: 20,),
          Row(
            children: [
              Expanded(child: SizedBox()),
              TextButton(onPressed: () {
                Navigator.pop(context, 
                 OnReadingItem(reading: reading, kanji: kanji, meaning: meaning, id: id));
              }, child: Text(onReading != null? 'Edit':'Add')),
              TextButton(onPressed: () {
                Navigator.pop(context);
              }, child: Text('Cancel'))
            ],
          )
        ])),
    );
  }
}