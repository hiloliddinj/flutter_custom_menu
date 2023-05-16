import 'package:flutter/material.dart';

import '../../../constants/icon_cons.dart';

class MenuView extends StatelessWidget {
  const MenuView({
    Key? key,
    required this.onCanceled,
    required this.buttonsList,
    required this.opacity,
  }) : super(key: key);

  final void Function()? onCanceled;
  final List<Widget> buttonsList;
  final double opacity;

  @override
  Widget build(BuildContext context) {

    double internalOpacity = opacity;

    if (opacity < 0) {
      internalOpacity = 0;
    } else if (opacity > 1) {
      internalOpacity = 1;
    }

    return SafeArea(
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
              onPressed: onCanceled,
              icon: Image(
                image: AssetImage(
                  IconConst.cancel,
                ),
                opacity: AlwaysStoppedAnimation(internalOpacity),
              ),
            ),
            Column(
              children: buttonsList,
            ),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
