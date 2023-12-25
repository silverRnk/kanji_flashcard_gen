import 'package:flutter/material.dart';
import 'package:kanji_flashcard_gen/page1.dart';
// import 'package:kanji_flashcard_gen/page2.dart';
import 'package:kanji_flashcard_gen/pages/kanji_card/home.dart';
import 'package:kanji_flashcard_gen/test_page.dart';

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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'My Anki Kanjii Generator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    Widget page;
    switch (_selectedIndex) {
      case 0:
        page = CreateKanjiPage();
      case 1:
        page = HomePage();
      case 2:
        page = QuillTestPage();
      default:
        page = Placeholder();
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        actions: [
          IconButton(onPressed: () {

          }, icon: Icon(Icons.ios_share), tooltip: 'Export',)
        ],
      ),
      body: Row(children: [
        SafeArea(
            child: NavigationRail(
                extended: true,
                selectedIndex: _selectedIndex,
                onDestinationSelected: (value) {
                  setState(() {
                    _selectedIndex = value;
                  });
                },
                destinations: const [
              NavigationRailDestination(
                  icon: Icon(Icons.home), label: Text('Create Kanji Card')),
              NavigationRailDestination(
                  icon: Icon(Icons.abc), label: Text('Create Vocab Card')),
              NavigationRailDestination(
                  icon: Icon(Icons.abc), label: Text('Quill')),
            ])),
        Expanded(
            child: Padding(padding: const EdgeInsets.all(15.0), child: page)),
      ]),
    );
  }
}
