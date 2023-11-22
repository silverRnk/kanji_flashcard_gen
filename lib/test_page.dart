import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';


class QuillTestPage extends StatefulWidget {
  const QuillTestPage({super.key});

  @override
  State<QuillTestPage> createState() => _QuillTestPageState();
}

class _QuillTestPageState extends State<QuillTestPage> {
  QuillController _controller = QuillController.basic();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: QuillProvider(
      configurations: QuillConfigurations(
      controller: _controller,
      sharedConfigurations: const QuillSharedConfigurations(
        locale: Locale('de'),
      ),
      ),
      child: Column(
      children: [
        const QuillToolbar(),
        Expanded(
          child: QuillEditor.basic(
            configurations: const QuillEditorConfigurations(
              readOnly: false,
            ),
          ),
        )
      ],
      ),
    ),
    );
  }
}