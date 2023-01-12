import 'package:flutter/material.dart';

class PickFile extends StatelessWidget {
  final VoidCallback onPressed;
  const PickFile({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: onPressed,
        child: const Text('Pick File'),
      ),
    );
  }
}
