import 'package:flutter/material.dart';

class ControlWidget extends StatelessWidget {
  final void Function()? runAnimation;
  final void Function()? showButton;
  final bool isClick;
  final bool isButtonShow;
  const ControlWidget({super.key, this.runAnimation, this.showButton, required this.isClick, required this.isButtonShow});

  @override
  Widget build(BuildContext context) {
    return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: const ButtonStyle(
                    padding: MaterialStatePropertyAll(EdgeInsets.zero),
                    maximumSize: MaterialStatePropertyAll(Size(50, 50)),
                    minimumSize: MaterialStatePropertyAll(Size(50, 50)),
                    alignment: Alignment.center,
                    shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(12))))
                  ),
                  onPressed: runAnimation,
                  child: Center(
                    child: Text(
                      isClick ? 'Return': 'Play'
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 40),
                  child: ElevatedButton(
                    style: const ButtonStyle(
                      padding: MaterialStatePropertyAll(EdgeInsets.zero),
                      maximumSize: MaterialStatePropertyAll(Size(50, 50)),
                      minimumSize: MaterialStatePropertyAll(Size(50, 50)),
                      alignment: Alignment.center,
                      shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(12))))
                    ),
                    onPressed: showButton,
                    child: Center(
                      child: Text(
                        isButtonShow ? 'Hide': 'Show'
                      ),
                    ),
                  ),
                ),
              ],
            );
  }
}