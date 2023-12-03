// import 'dart:html';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:kanji_flashcard_gen/widget/clipboardbox.dart';
import 'package:kanji_flashcard_gen/widget/image_clipboard.dart';
import 'package:kanji_flashcard_gen/widget/kunreading.dart';
import 'package:kanji_flashcard_gen/widget/onreading.dart';
// import 'package:path_provider/path_provider.dart';
import 'package:super_clipboard/super_clipboard.dart';

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
  String sampleImage = "";
  late ScrollController scrollController;
  // late QuillController  quillController;

  void _setKanji(String string) {
    setState(() {
      _kanji = string;
    });
  }

  void getImage() async{

    // var fileReader = File('images/Capture.JPG');
    // var stringHolder = await fileReader.readAsBytes();
    // setState(() {
    //   sampleImage = stringHolder[3].toString();
    // });
    
  }

  // void showClipBoardData() async {
  //   var reader = await ClipboardReader.readClipboard();

  //   if(reader.canProvide(Formats.plainText)){
  //     var text = "";
  //     var progress = await reader.getValue(Formats.plainText, (value) {
  //       text = value ?? "";
  //     });
  //     print("copied file $text");
  //   }else if(reader.canProvide(Formats.png)){
  //     print('You\'ve copied an png file');
  //   }else if(reader.canProvide(Formats.jpeg)){
  //     print('You\'ve copied an jpg file');
  //   }
  // }

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
    getImage();
    // quillController = QuillController.basic();
    // print("Init page1");
    super.initState();
  }

  Widget _divider(BuildContext context){
    return const Divider(
                          color: Colors.black,
                          height: 2.0,
                          thickness: 2.0,
                        );
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
                        _divider(context),
                        const Text(
                          'Memonics and Picture',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        ImageClipBoard(new ImageData()),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                          ClipBoardBox(
                            data: _kanji + sampleImage,
                            side: FlashCardSide.front,
                            flashCardType: KanjiFlashCardType.memonicAndPic),
                          ClipBoardBox(
                            data: _kanji,
                            side: FlashCardSide.back,
                            flashCardType: KanjiFlashCardType.memonicAndPic),
                          ],
                        ),
                        SizedBox(height: 10,),
                        _divider(context),
                        const Text(
                          'Stroke Pic',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
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
                          ],
                        ),
                        
                        const SizedBox(
                          height: 5.0,
                        ),
                        _divider(context),
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