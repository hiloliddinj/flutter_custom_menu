import 'package:flutter/material.dart';

import '../../../constants/icon_cons.dart';

class MenuView extends StatelessWidget {
  const MenuView({
    Key? key,
    required this.onCanceled,
    required this.buttonsList,
  }) : super(key: key);

  final void Function()? onCanceled;
  final List<Widget> buttonsList;

  @override
  Widget build(BuildContext context) {
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
