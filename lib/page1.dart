import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_quill/flutter_quill.dart';
import 'package:kanji_flashcard_gen/widget/clipboardbox.dart';
import 'package:kanji_flashcard_gen/widget/kanji_reading.dart';
import 'package:kanji_flashcard_gen/widget/kunreading.dart';
import 'package:kanji_flashcard_gen/widget/onreading.dart';

class CreateKanjiPage extends StatefulWidget {
  CreateKanjiPage({super.key});

  @override
  State<CreateKanjiPage> createState() => _CreateKanjiPage();
}

class _CreateKanjiPage extends State<CreateKanjiPage> {
  String _kanji = '';
  List<OnReadingItem> onReadingItems = [];
  List<KunReadingItem> kunReadingItems = [];
  double _scrollHeight = 0.0;
  late ScrollController scrollController;
  // late QuillController  quillController;

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

  void _addOnReading(OnReadingItem onReading, {int? id}){
    setState(() {
      if(onReading.id != null){
        onReadingItems.replaceRange(onReading.id!, onReading.id!, [onReading]);
      }else{
        onReadingItems.add(onReading.copyWith(id: onReadingItems.length));
      }
    });
  }

  void _addKunReading(KunReadingItem kunReading, {int? id}){
    setState(() {
      if(kunReading.id != null){
        kunReadingItems.replaceRange(kunReading.id!, kunReading.id! + 1, [kunReading]);
      }else{
        kunReadingItems.add(kunReading.copyWith(id: kunReadingItems.length));
      }
    });
  }

  @override
  void initState() {
    scrollController = ScrollController(initialScrollOffset: 0.0, keepScrollOffset: true);
    // quillController = QuillController.basic();
    // print("Init page1");
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
          // print(_scrollHeight);
        }
      },
      child: MaterialApp(
        home: Scaffold(
          floatingActionButton: FloatingActionButton(onPressed: () {
            setState(() {
              _scrollHeight = 0;
            });
            scrollController.animateTo(_scrollHeight, duration: Durations.short4, curve: Curves.linear);
          }, child: Icon(Icons.arrow_upward),),
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
                        // QuillProvider(
                        //   configurations: QuillConfigurations(
                        //     controller: quillController, 
                        //     sharedConfigurations: const QuillSharedConfigurations(locale: Locale("en"))), 
                        //   child: Column(
                        //     children: [
                        //       const QuillToolbar()
                        //       ,QuillEditor.basic(
                        //       configurations: const QuillEditorConfigurations(
                        //         readOnly: false
                        //       ),
                        //     ),]
                        //   ) ),
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
                        KunReadingSection(items: kunReadingItems, kanji: _kanji, setKunReading: _addKunReading,)
                      ],
                    ),
        ),
      ),
    );
  }
}