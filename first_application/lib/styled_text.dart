import 'package:flutter/material.dart';

class StyledText extends StatelessWidget {
  final String content;

  const StyledText(this.content, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(content, style: TextStyle(color: Colors.white, fontSize: 28.5));
  }
}
