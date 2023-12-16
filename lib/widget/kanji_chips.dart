import 'package:flutter/material.dart';

class KanjiChip extends StatelessWidget {
  const KanjiChip({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 150,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        boxShadow: [
          BoxShadow(blurRadius: 2.0)
        ]
      ),
      child: Row(
        children: [Expanded(child: Text('Kanji')), IconButton(onPressed: () {}, icon: Icon(Icons.more_vert))],
      ),
    );
  }
}