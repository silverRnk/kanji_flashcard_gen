import 'package:flutter/material.dart';

class KanjiChip extends StatefulWidget{

  KanjiChip({super.key, required this.kanji});

  final String kanji;

  @override
  State<StatefulWidget> createState() =>  _KanjiChipState();
}

class _KanjiChipState extends State<KanjiChip> {
  OverlayPortalController _overlayPortalController = new OverlayPortalController();

  Widget _myInkWellContainer({required Widget child, Color? color, void Function()? onTap }){
    return Container(
      decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(blurRadius: 2.0)
          ]
        ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          child: child
        )), 
      );
  }

  @override
  Widget build(BuildContext context) {
    return _myInkWellContainer(
      color: Colors.white,
      onTap: () {
        debugPrint('Selected an kanji card');
      },
      child: Container(
        height: 65,
        width: 250,
        padding: const EdgeInsets.fromLTRB(10, 10, 5, 10),
        child: Row(
          children: [Expanded(child: Text(widget.kanji)), MenuAnchor(builder: (context, controller, child) {
            return IconButton(onPressed: () {
              if(!controller.isOpen){
                controller.open();
              }else{
                controller.close();
              }
            }, icon: Icon(Icons.more_vert), tooltip: 'Show more',);
          },menuChildren: List<MenuItemButton>.generate(3, 
          (index) => MenuItemButton(child: Text('Selection $index'), onPressed: () {},)))],
        ),
      ),
    );
  }
}


class MyInkWellChip extends StatelessWidget {
  const MyInkWellChip({super.key});

  @override
  Widget build(BuildContext context) {
    return  Container(
      child:  Material(
        child:  InkWell(
          onTap: (){print("tapped");},
          child: Container(
            width: 100.0,
            height: 100.0,
          ),
        ),
        color: Colors.transparent,
      ),
      color: Colors.orange,
    );
  }
}