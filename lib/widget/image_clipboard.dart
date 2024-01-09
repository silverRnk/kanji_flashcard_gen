import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:super_clipboard/super_clipboard.dart';

class ImageClipBoard extends StatefulWidget {
  const ImageClipBoard(this.imageData, {super.key, required this.onPaste, this.onDelete});

  final ImageData imageData;
  final Function(String path) onPaste;
  final Function? onDelete;

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

  void _handelPaste() async{
    final reader = await ClipboardReader.readClipboard();

    if(reader.canProvide(Formats.png)){
      var format = Formats.png;
      reader.getFile(format, (value) {
        handleTempSaving('png',value);
      });
    }else if(reader.canProvide(Formats.jpeg)){
      var format = Formats.jpeg;
      reader.getFile(format, (value) {
        handleTempSaving('jpeg', value);
      });
    }else if(reader.canProvide(Formats.tiff)){
      var format = Formats.tiff;
      reader.getFile(format, (value) {
        handleTempSaving('tiff', value);
      });
    }
  }

  void handleTempSaving(String format, DataReaderFile data) async{
    debugPrint('Copied File Formats: $format');
    final stream = data.getStream();
    final img = await stream.first;

    String currentDirectory = Directory.current.path;
    
    Directory(currentDirectory + '/temp').createSync();

    debugPrint(currentDirectory);
    File file = File('$currentDirectory/temp/' + DateTime.now().millisecondsSinceEpoch.toString() + '.$format');
    file.writeAsBytes(img);
    widget.onPaste(file.path);
    // debugPrint(file.path + 'on $currentDirectory');
  }

  void _handleDelete(){
    widget.onDelete!();
  }

  KeyEventResult _handelKeyEvent(FocusNode node, RawKeyEvent keyEvent){

    // debugPrint(
    //   'Focus node ${node.debugLabel} got key event:${keyEvent.logicalKey}'
    // );

    if(keyEvent is RawKeyDownEvent){
      if(keyEvent.logicalKey == LogicalKeyboardKey.keyV && keyEvent.isControlPressed){
        _handelPaste();
      }
    }

    return KeyEventResult.ignored;
  }

  bool isImageDataEmpty(){
    return widget.imageData.isEmpty;
  }

  @override
  Widget build(BuildContext context) {
    _focusAttachment.reparent();

    return GestureDetector(
      onTapDown: (event) {
          _focusNode.requestFocus();
          debugPrint('Click inside the widget');
      },
      child: Container(
        height: 200,
        padding: EdgeInsets.all(10),
        child: DottedBorder(
          borderType: BorderType.RRect,
          radius: const Radius.circular(10),
          padding: EdgeInsets.all(10),
          strokeWidth: 2,
          color: _focused? Colors.blue:Colors.grey,
          dashPattern: [4, 3],
          child: Align(
            alignment: Alignment.center,
            child: isImageDataEmpty()? SizedBox(height: 200,):
             Image.file(File(widget.imageData.imgPath!))
            // FutureBuilder(
            //   future: widget.imageData.getImage(),
            //   builder: (context, snapshot) {
            //     // if(snapshot.hasData){
            //     // return Image.memory(snapshot.data ?? Uint8List(1), height: 200, fit: BoxFit.cover,);
            //     // }
            //     return Image.memory(Uint8List(1));
            //     // return const SizedBox(height: 200,);
            //   },
            // )
          )),
      ),
    );
  }
}

class ImageData {
  ImageData({this.imgPath, this.type});

  String? imgPath;
  String? type;

  Future<String> base64String() async{
    if(imgPath != null){
      var dotIndex = imgPath!.indexOf('.');
      type = imgPath!.substring(dotIndex + 1);
    }

    if(imgPath != null && imgPath!.isNotEmpty){
      Uint8List bytes = await getImage();
      return 'data:image/$type;base64,' + base64Encode(bytes);
    }
    return '';
  }

  Future<Uint8List> getImage() async{
    if(imgPath != null && imgPath!.isNotEmpty){
      File file = File(imgPath!);
      return await file.readAsBytes();
    }

    return Uint8List(1);
  }

  set setImgPath(String path){
    imgPath = path;
  }

  bool get isEmpty{
    return imgPath == null || imgPath!.isEmpty;
  } 

}