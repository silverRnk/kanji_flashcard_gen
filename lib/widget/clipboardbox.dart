import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
