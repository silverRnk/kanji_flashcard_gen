import 'package:flutter/material.dart';
import 'package:kanji_flashcard_gen/page_add_on_reading.dart';

class OnReadingItem {

  String reading;
  String meaning;
  String kanji;

  OnReadingItem({required this.reading, required this.kanji, required this.meaning});
}

class OnReadingSection extends StatelessWidget {
  final List<OnReadingItem> items;

  const OnReadingSection({super.key, required this.items});

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
              Navigator.push(context, MaterialPageRoute(builder: (context) => AddOnReadingPage()));
            }, icon: Icon(Icons.add))
          ],
        ),
        
        SizedBox(height: 100,)
      ],
    );
  }
}