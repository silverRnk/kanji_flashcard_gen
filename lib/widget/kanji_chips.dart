import 'package:flutter/material.dart';

class KanjiChip extends StatelessWidget {
  const KanjiChip({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        debugPrint('Selected an kanji card');
      },
      child: Container(
        height: 65,
        width: 250,
        margin: EdgeInsets.all(10),
        padding: const EdgeInsets.fromLTRB(10, 10, 5, 10),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(blurRadius: 2.0)
          ]
        ),
        child: Row(
          children: [Expanded(child: Text('Kanji')), IconButton(onPressed: () {}, icon: Icon(Icons.more_vert))],
        ),
      ),
    );
  }
}