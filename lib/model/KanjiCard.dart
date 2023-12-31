
import 'package:kanji_flashcard_gen/widget/kunreading.dart';
import 'package:kanji_flashcard_gen/widget/onreading.dart';

class KanjiCard {

  KanjiCard({
    required this.kanji,
    this.strokeImgPath, 
    this.mnemonicPath,
    required this.onReadings,
    required this.kunReadings
    });

  final String kanji;
  final String? strokeImgPath;
  final String? mnemonicPath;
  final List<OnReadingItem> onReadings;
  final List<KunReadingItem> kunReadings; 
}