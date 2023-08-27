import 'dart:ffi';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:sidebarx/sidebarx.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'My Anki Kanjii Generator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  String _kanji = '';

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  void _setKanji(String string) {
    setState(() {
      _kanji = string;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Row(
        children: [
          SidebarX(
            controller: SidebarXController(selectedIndex: 0),
            items: const [
              SidebarXItem(label: 'Home', icon: Icons.home),
              SidebarXItem(label: 'Vocab', icon: Icons.abc)
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: ListView(
                // Column is also a layout widget. It takes a list of children and
                // arranges them vertically. By default, it sizes itself to fit its
                // children horizontally, and tries to be as tall as its parent.
                //
                // Column has various properties to control how it sizes itself and
                // how it positions its children. Here we use mainAxisAlignment to
                // center the children vertically; the main axis here is the vertical
                // axis because Columns are vertical (the cross axis would be
                // horizontal).
                //
                // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
                // action in the IDE, or press "p" in the console), to see the
                // wireframe for each widget.
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
                  const Text(
                    'Add an On Reading',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  KanjiReading(
                      kanji: _kanji, readingType: KanjiReadingType.onReading),
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
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

enum FlashCardSide { front, back }

enum KanjiFlashCardType { stroke, memonicAndPic, onReading, kunReading, vocab }

class ClipBoardBox extends StatelessWidget {
  ClipBoardBox(
      {super.key,
      required this.data,
      required this.side,
      required this.flashCardType});

  final String data;
  final FlashCardSide side;
  final KanjiFlashCardType flashCardType;

  /// return the Label for front of flash card
  String getFrontLabel() {
    var label;
    switch (flashCardType) {
      case KanjiFlashCardType.stroke:
        label = "Write";
        break;
      case KanjiFlashCardType.memonicAndPic:
        label = 'Memonics and Pics';
        break;
      case KanjiFlashCardType.onReading:
        label = 'On Reading';
        break;
      case KanjiFlashCardType.kunReading:
        label = 'Kun Reading';
        break;
      case KanjiFlashCardType.vocab:
        label = 'Vocabulary';
        break;
      default:
    }
    return label;
  }

  @override
  Widget build(BuildContext context) {
    dynamic clipBoardText;

    switch (side) {
      case FlashCardSide.front:
        clipBoardText =
            '<h1 style="text-align: center;">$data</h1><div style="text-align: center;">${getFrontLabel()}</div>';
        break;
      case FlashCardSide.back:
        clipBoardText = '<div style="text-align:center">$data</div>';
        break;
      default:
    }

    return Container(
      decoration: BoxDecoration(
          color: Color.fromRGBO(110, 110, 0, 100),
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
      clipBehavior: Clip.antiAlias,
      padding: EdgeInsetsDirectional.fromSTEB(10, 5, 5, 10),
      constraints: const BoxConstraints(maxWidth: 400.0, minWidth: 10.0),
      child: Flex(
        direction: Axis.horizontal,
        children: [
          Expanded(
              child: Text(
            clipBoardText,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          )),
          IconButton(
              onPressed: () {
                Clipboard.setData(new ClipboardData(text: clipBoardText));
              },
              icon: Icon(Icons.copy))
        ],
      ),
    );
  }
}

enum KanjiReadingType { onReading, kunReading }

class KanjiReading extends StatefulWidget {
  KanjiReading({required this.kanji, required this.readingType});

  final String kanji;
  final KanjiReadingType readingType;

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
          TextField(onChanged: (value) {
            setReading(value);
            print(_reading);
          },),
          Text('Meaning'),
          TextField(onChanged: (value) {
            setMeaning(value);
          },),
          SizedBox(
            height: 5,
          ),
          ReadingClipBoardBox(
              kanji: widget.kanji,
              reading: _reading,
              meaning: _meaning,
              side: FlashCardSide.front,
              flashCardType: type),
          SizedBox(
            height: 5,
          ),
          ReadingClipBoardBox(
              kanji: widget.kanji,
              reading: _reading,
              meaning: _meaning,
              side: FlashCardSide.back,
              flashCardType: type),
        ],
      ),
    );
  }
}

class ReadingClipBoardBox extends StatelessWidget {
  ReadingClipBoardBox(
      {super.key,
      required this.kanji,
      required this.reading,
      required this.meaning,
      required this.side,
      required this.flashCardType});

  final String kanji;
  final String reading;
  final String meaning;
  final FlashCardSide side;
  final KanjiFlashCardType flashCardType;

  /// return the Label for front of flash card
  String getFrontLabel() {
    String label;

    switch (flashCardType) {
      case KanjiFlashCardType.onReading:
        label = 'On Reading';
        break;
      case KanjiFlashCardType.kunReading:
        label = 'Kun Reading';
        break;
      default:
        label = '';
    }
    return label;
  }

  @override
  Widget build(BuildContext context) {
    dynamic clipBoardText;

    switch (side) {
      case FlashCardSide.front:
        clipBoardText =
            '<h1 style="text-align: center;">$kanji</h1><div style="text-align: center;">${getFrontLabel()}</div>';
        break;
      case FlashCardSide.back:
        clipBoardText =
            '<div style="text-align:center"><b>$reading</b> ($meaning)</div>';
        break;
      default:
    }

    return Container(
      decoration: BoxDecoration(
          color: Color.fromRGBO(110, 110, 0, 100),
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
      clipBehavior: Clip.antiAlias,
      padding: EdgeInsetsDirectional.fromSTEB(10, 5, 5, 10),
      constraints: const BoxConstraints(maxWidth: 400.0, minWidth: 10.0),
      child: Flex(
        direction: Axis.horizontal,
        children: [
          Expanded(
              child: Text(
            clipBoardText,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          )),
          IconButton(
              onPressed: () {
                Clipboard.setData(new ClipboardData(text: clipBoardText));
              },
              icon: Icon(Icons.copy))
        ],
      ),
    );
  }
}
