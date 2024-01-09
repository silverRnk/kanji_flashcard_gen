import 'package:flutter/material.dart';
import 'package:kanji_flashcard_gen/page_add_on_reading.dart';
import 'package:kanji_flashcard_gen/widget/onreadingcard.dart';

abstract class ReadingItem{
  int? id;
  String reading;
  String meaning;

  ReadingItem({required this.reading, required this.meaning, this.id});

  String cardFront();
  String cardBack();
}

class OnReadingItem extends ReadingItem {

  String kanji;

  OnReadingItem({
    required this.kanji,
    required String reading,
    required String meaning ,
    int? id}) : super(meaning: meaning, reading: reading, id: id);

  OnReadingItem copyWith({String? reading, String? meaning, String? kanji, int? id}){

    if(reading != null){
      reading = reading;
    }

    if(meaning != null){
      meaning = meaning;
    }

    if(kanji != null){
      meaning = meaning;
    }

    if(id != null){
      meaning = meaning;
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

class OnReadingSection extends StatelessWidget {
  final List<OnReadingItem> items;
  final String kanji;
  void Function(OnReadingItem)? setOnReading;

  OnReadingSection({super.key, required this.items, required this.kanji, this.setOnReading});

  Future<void> _navigateToAddOnReading(BuildContext context, Function(OnReadingItem) addItem) async {
    final item = await Navigator.push(
      context, MaterialPageRoute(builder: (context) => AddOnReadingPage(kanji: kanji,)));

    if(item is OnReadingItem){
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
              'Add an On Reading',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),),
            IconButton(onPressed: () {
              _navigateToAddOnReading(context, (item) => setOnReading!(item));
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
              return ReadingCards(
                title: 'On Reading $index',
                readingItem: items[index],
                onTapDown: (item) async {
                  
                  final itemHolder = await Navigator.push(
                    context, MaterialPageRoute(builder: (context) => 
                    AddOnReadingPage(kanji: item.kanji, onReading: item, id: item.id,)));
                  if(itemHolder is OnReadingItem){
                    setOnReading!(itemHolder);
                  }
                },);}),
          ),
        )),
        SizedBox(height: 100,)
      ],
    );
  }
}