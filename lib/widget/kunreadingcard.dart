import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kanji_flashcard_gen/widget/kunreading.dart';

class KunReadingCard extends StatelessWidget {
  const KunReadingCard({super.key, required this.title, required this.readingItem, this.onTapDown});

  final String title;
  final KunReadingItem readingItem;
  final Function(KunReadingItem item)? onTapDown;

  void onCopyHandler(String copyString){
    Clipboard.setData(ClipboardData(text: copyString));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (details) {
        if((details.localPosition.distance > 214) &&
         (details.localPosition.direction > 0.08) && (details.localPosition.direction < 0.23)){
          return;
        }

        onTapDown!(readingItem);
      },
      child: Container(
        width: 300,
        height: 75,
        padding: EdgeInsets.symmetric(horizontal: 10),
        decoration: const BoxDecoration(
          color:Color(0xFAFAFAFF),
          borderRadius: BorderRadius.all(Radius.circular(5)),
          boxShadow: [BoxShadow(
            color: Colors.grey,
            blurRadius: 2.0
          )]
        ),
        child: Row(
          children: [
            Expanded(child: Text('$title: ${readingItem.reading}', maxLines: 1, overflow: TextOverflow.clip,)),
            IconButton(onPressed: () => onCopyHandler(readingItem.cardFront()), icon: Icon(Icons.copy), tooltip: "Front",),
            IconButton(onPressed: () => onCopyHandler(readingItem.cardBack()), icon: Icon(Icons.copy), tooltip: "Back",)
            
          ],
        ),
      ),
    );
  }
}