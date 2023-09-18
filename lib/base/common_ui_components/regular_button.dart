import 'package:flutter/material.dart';

class RegularButton extends StatelessWidget {
  const RegularButton({
    required this.title,
    required this.onPressed,
    this.style,
    super.key,
  });

  final String title;
  final VoidCallback onPressed;
  final ButtonStyle? style;

  @override
  Widget build(BuildContext context) => FilledButton(
        onPressed: onPressed,
        style: style,
        child: Text(
          title,
        ),
      );
}
