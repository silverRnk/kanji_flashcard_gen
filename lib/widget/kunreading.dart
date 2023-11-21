import 'package:flutter/material.dart';
import 'package:kanji_flashcard_gen/pageAddKunReading.dart';
import 'package:kanji_flashcard_gen/widget/kunreadingcard.dart';
import 'package:kanji_flashcard_gen/widget/onreading.dart';
import 'package:kanji_flashcard_gen/widget/onreadingcard.dart';

class KunReadingItem extends ReadingItem {

  String kanji;

  KunReadingItem({
    required this.kanji,
    required String reading,
    required String meaning ,
    int? id}) : super(meaning: meaning, reading: reading, id: id);

  KunReadingItem copyWith({String? reading, String? meaning, String? kanji, int? id}){

    if(reading != null){
      this.reading = reading;
    }

    if(meaning != null){
      this.meaning = meaning;
    }

    if(kanji != null){
      this.kanji = kanji;
    }

    if(id != null){
      this.id = id;
    }

    return this;
  }

  @override
  String cardFront(){
    return '<h1 style="text-align: center;">$kanji</h1><div style="text-align: center;">On Reading</div>';
  }

  @override
  String cardBack(){
    return '<div style="text-align:center"><b>$reading</b> ($meaning)</div>';
  }
}

class KunReadingSection extends StatelessWidget {
  final List<KunReadingItem> items;
  final String kanji;
  void Function(KunReadingItem)? setKunReading;

  KunReadingSection({super.key, required this.items, required this.kanji, this.setKunReading});

  Future<void> _navigateToAddOnReading(BuildContext context, Function(KunReadingItem) addItem) async {
    final item = await Navigator.push(
      context, MaterialPageRoute(builder: (context) => AddKunReadingPage(kanji: kanji,)));

    print(item);

    if(item is KunReadingItem){
      addItem(item);
    }

    
  }

  Widget _wrapper(BuildContext context,{ Widget? child}){
    return ConstrainedBox(constraints: const BoxConstraints(
      minHeight: 100,
      minWidth: double.maxFinite
    ),
    child: child,);
  }

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        Row(
          children: [
            Expanded(child: Text(
              'Add an Kun Reading',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),),
            IconButton(onPressed: () {
              _navigateToAddOnReading(context, (item) => setKunReading!(item));
            }, icon: Icon(Icons.add))
          ],
        ),
        _wrapper(
          context,
          child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Wrap(
            spacing: 10.0,
            runSpacing: 10.0,
            children: List<Widget>.generate(items.length, (index) 
            {
              // return Placeholder(fallbackHeight: 75, fallbackWidth: 200,);

              return KunReadingCard(
                title: 'Kun Reading $index',
                readingItem: items[index],
                onTapDown: (item) async {
                  print(item.id);
                  final itemHolder = await Navigator.push(
                    context, MaterialPageRoute(builder: (context) => 
                    AddKunReadingPage(kanji: item.kanji, kunReading: item, id: item.id,)));
                  if(itemHolder is KunReadingItem){
                    setKunReading!(itemHolder);
                  }
                },
                );
                }),
          ),
        )),
        SizedBox(height: 100,)
      ],
    );
  }
}