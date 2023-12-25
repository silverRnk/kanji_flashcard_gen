import 'package:flutter/material.dart';
import 'package:kanji_flashcard_gen/pages/kanji_card/add_card.dart';
import 'package:kanji_flashcard_gen/widget/kanji_chips.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Wrap(
            spacing: 10,
            children: [
              KanjiChip(),
              KanjiChip(),
              MyInkWellChip()
            ],
          ),
        ),
        floatingActionButton: Builder(builder: (context) {
          return FloatingActionButton(onPressed: () {
            Navigator.push(context,MaterialPageRoute(builder: (context) {
                return CreateKanjiPage();
              },));
          }, child: const Icon(Icons.add),);
        }),
      ),
    );
  }
}

class ActionButton1 extends StatelessWidget {
  const ActionButton1({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(onPressed: () {
              Navigator.push(context,MaterialPageRoute(builder: (context) {
                return CreateKanjiPage();
              },));
            }, icon: Icon(Icons.add), tooltip: 'Create a new card',);
  }
}