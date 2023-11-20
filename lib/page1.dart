import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:kanji_flashcard_gen/widget/clipboardbox.dart';
import 'package:kanji_flashcard_gen/widget/kanji_reading.dart';
import 'package:kanji_flashcard_gen/widget/onreading.dart';

class CreateKanjiPage extends StatefulWidget {
  CreateKanjiPage({super.key});

  @override
  State<CreateKanjiPage> createState() => _CreateKanjiPage();
}

class _CreateKanjiPage extends State<CreateKanjiPage> {
  String _kanji = '';
  List<OnReadingItem> onReadingItems = [];
  double _scrollHeight = 0.0;
  late ScrollController scrollController;

  void _setKanji(String string) {
    setState(() {
      _kanji = string;
    });
  }

  void _setHeight(double offset) {
    setState(() {
      _scrollHeight = _scrollHeight + offset;
    });
  }

  void _addOnReading(OnReadingItem onReading){
    setState(() {
      onReadingItems.add(onReading);
    });
  }

  @override
  void initState() {
    scrollController = ScrollController(initialScrollOffset: 0.0, keepScrollOffset: true);
    print("Init page1");
    super.initState();
  }


  @override
  Widget build(BuildContext context){

    // final item = Navigator.push(context, MaterialPageRoute(builder: (context) => Placeholder())) as OnReadingItem;

    return Listener(
      onPointerSignal: (event) {
        if(_scrollHeight > scrollController.position.maxScrollExtent){
          return;
        }

        if(event is PointerScrollEvent){
          _setHeight(event.scrollDelta.dy);
          scrollController.animateTo(_scrollHeight, duration: Durations.short4, curve: Curves.linear);
          print(_scrollHeight);
        }
      },
      child: MaterialApp(
        home: Scaffold(
          body: ListView(
                      controller: scrollController,
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
                        OnReadingSection(items: onReadingItems, kanji: _kanji, setOnReading: _addOnReading,),
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
                    ),
        ),
      ),
    );
  }
}