import 'package:flutter/material.dart';
import 'package:kanji_flashcard_gen/widget/kanji_reading.dart';
import 'package:kanji_flashcard_gen/widget/kunreading.dart';

class AddKunReadingPage extends StatelessWidget {
  final String kanji;
  final KunReadingItem? kunReading;
  final int? id;
  const AddKunReadingPage({super.key, required this.kanji, this.kunReading, this.id});

  @override
  Widget build(BuildContext context) {
    String meaning = kunReading?.meaning ?? "";
    String reading = kunReading?.reading ?? "";

    return Container(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: () {
          Navigator.pop(context);
        },),
        title: Text('add a kun reading'),),
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
                 KunReadingItem(reading: reading, kanji: kanji, meaning: meaning, id: id));
              }, child: Text('Add')),
              TextButton(onPressed: () {
                Navigator.pop(context);
              }, child: Text('Cancel'))
            ],
          )
        ])),
    );
  }
}