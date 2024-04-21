import 'package:flutter/material.dart';

class ArrowButton extends StatelessWidget {
  final void Function()? onPressed;
  const ArrowButton({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: const ButtonStyle(
        padding: MaterialStatePropertyAll(EdgeInsets.zero),
        maximumSize: MaterialStatePropertyAll(Size(50, 50)),
        minimumSize: MaterialStatePropertyAll(Size(50, 50)),
        alignment: Alignment.center,
        shape: MaterialStatePropertyAll(RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)))),
        elevation: MaterialStatePropertyAll(16),
      ),
      onPressed: onPressed,
      child: const Center(
        child: Icon(
          Icons.expand_more_rounded,
          color: Colors.black,
          size: 20.0,
        ),
      ),
    );
  }
}
