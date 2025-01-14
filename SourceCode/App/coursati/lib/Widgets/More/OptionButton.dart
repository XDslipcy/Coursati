import 'package:flutter/material.dart';

import '../../Classes/GlobalVariables.dart';
import '../../main.dart';

class OptionButton extends StatefulWidget {
  OptionButton(
      {super.key,
      required String label,
      required AssetImage image,
      required Function onPressed})
      : _onPressed = onPressed,
        _image = image,
        _label = label;
  final String _label;

  final AssetImage _image;
  IconData _side = Icons.offline_bolt;
  final Function _onPressed;

  @override
  State<OptionButton> createState() => _OptionButtonState();
}

class _OptionButtonState extends State<OptionButton> {
  @override
  Widget build(BuildContext context) {
    if (languageType == 0) {
      widget._side = Icons.keyboard_arrow_left_sharp;
    } else {
      widget._side = Icons.keyboard_arrow_right_sharp;
    }

    return TextButton(
      onPressed: () {
        widget._onPressed();
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Image(
              image: widget._image,
              height: 30,
            ),
          ),
          Text(
            widget._label,
            textAlign: TextAlign.start,
            style: TextStyle(
              color: (Theme.of(context).brightness == Brightness.light)
                  ? const Color.fromARGB(255, 65, 65, 65)
                  : Colors.white,
              fontSize: 15,
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              widget._side,
              size: 40,
              color: (Theme.of(context).brightness == Brightness.light)
                  ? const Color.fromARGB(255, 65, 65, 65)
                  : Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
