import 'dart:typed_data';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class ImageClipBoard extends StatefulWidget {
  const ImageClipBoard(this.imageData, {super.key});

  final ImageData imageData;

  @override
  State<ImageClipBoard> createState() => _ImageClipBoardState();
}

class _ImageClipBoardState extends State<ImageClipBoard> {
  late FocusNode _focusNode;
  late FocusAttachment _focusAttachment;
  bool _focused = false;

  @override
  void initState() {
    _focusNode = FocusNode(debugLabel: 'Image Clip Board ${widget.key}');
    _focusNode.addListener(_handelFocus);
    _focusAttachment = _focusNode.attach(context, onKey: _handelKeyEvent);
    super.initState();
  }

  @override
  void dispose() {
    _focusNode.removeListener(_handelFocus);
    _focusNode.dispose();
    super.dispose();
  }

  void _handelFocus(){
    debugPrint('${_focusNode.hasFocus}');
    if(_focusNode.hasPrimaryFocus != _focused){
      setState(() {
        _focused = _focusNode.hasFocus;
      });
    }
  }

  void _handelPaste(){
    //TODO
  }

  void _handleDelete(){
    //TODO
  }

  KeyEventResult _handelKeyEvent(FocusNode node, RawKeyEvent keyEvent){
    if(keyEvent is RawKeyEvent){
      debugPrint(
        'Focus node ${node.debugLabel} got key event:${keyEvent.logicalKey}'
      );
    }
    return KeyEventResult.ignored;
  }

  @override
  Widget build(BuildContext context) {
    _focusAttachment.reparent();

    return GestureDetector(
      onTapDown: (details) {
        debugPrint('Click');
        if(_focused){
          _focusNode.unfocus();
        }else{
          _focusNode.requestFocus();
        }
      },
      child: DottedBorder(
        radius: const Radius.circular(10),
        padding: EdgeInsets.all(10),
        color: _focused? Colors.blue:Colors.grey,
        child: Align(
          alignment: Alignment.center,
          child: Placeholder()
        )),
    );
  }
}

class ImageData {
  const ImageData({this.imgPath});

  final String? imgPath;

  String base64String(){
    //TODO implement function
    return '';
  }

  Uint8List getImage(){
    //TODO implement data
    return Uint8List(2);
  }

  bool get isEmpty{
    return imgPath == null || imgPath!.isEmpty;
  } 

}