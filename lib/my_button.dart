import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyButton extends StatelessWidget {
  const MyButton({required this.route, required this.text, super.key});

  final String route;
  final String text;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => Get.toNamed(route),
      style: ButtonStyle(
          elevation: MaterialStateProperty.all(6),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: const BorderSide(color: Colors.black, width: 4),
            ),
          )),
      child: Text(text, textAlign: TextAlign.center, style: const TextStyle(fontSize: 16)),
    );
  }
}
