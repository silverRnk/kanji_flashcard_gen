import 'package:flutter/material.dart';
import 'package:kanji_flashcard_gen/page1.dart';
import 'package:kanji_flashcard_gen/page2.dart';

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
        page = AddVocabPage();
      default:
        page = Placeholder();
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
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
                  icon: Icon(Icons.abc), label: Text('Create Vocab Card'))
            ])),
        Expanded(
            child: Padding(padding: const EdgeInsets.all(15.0), child: page)),
      ]),
    );
  }
}
