import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_custom_menu/constants/icon_cons.dart';

import 'custom_clippers/lift_up_clipper.dart';
import 'widgets/BBIconButton.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double value = 0;

  Color _blueColor = Colors.blue.shade400.withOpacity(0);
  double iconsSpacer = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    iconsSpacer = MediaQuery.of(context).size.width / 15;
  }

  @override
  Widget build(BuildContext context) {
    final availableHeight = MediaQuery.of(context).size.height -
        AppBar().preferredSize.height -
        MediaQuery.of(context).padding.top -
        80 -
        (value * 200 / 100).round().toDouble();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Kyla Clipper Design'),
        backgroundColor: Colors.blue,
      ),
      body: Stack(
        children: [
          SafeArea(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: iconsSpacer,
                      ),
                      BBIconButton(
                        onPressed: () {},
                        icon: Icons.calendar_today,
                      ),
                      SizedBox(
                        width: iconsSpacer,
                      ),
                      BBIconButton(
                        onPressed: () {},
                        icon: Icons.search,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      BBIconButton(
                        onPressed: () {},
                        icon: Icons.flash_on_sharp,
                      ),
                      SizedBox(
                        width: iconsSpacer,
                      ),
                      BBIconButton(
                        onPressed: () {},
                        icon: Icons.ac_unit,
                      ),
                      SizedBox(
                        width: iconsSpacer,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                height: availableHeight,
                color: _blueColor,
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _customClip(),
                    Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.rotationY(math.pi),
                      child: _customClip(),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SafeArea(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                height: 270,
                child: RotatedBox(
                  quarterTurns: -1,
                  child: SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      activeTrackColor: Colors.black.withOpacity(0),
                      inactiveTrackColor: Colors.black.withOpacity(0),
                      trackShape: const RectangularSliderTrackShape(),
                      trackHeight: 4.0,
                      thumbColor: Colors.blue,
                      thumbShape:
                          const RoundSliderThumbShape(enabledThumbRadius: 30.0),
                      overlayColor: Colors.black.withOpacity(0),
                      //overlayShape: const RoundSliderOverlayShape(overlayRadius: 28.0),
                    ),
                    child: Slider(
                      value: value,
                      onChanged: (newValue) {
                        setState(() {
                          debugPrint(
                              "Value: ${value.toString()}, newValue: $newValue");
                          value = newValue;
                          _blueColor =
                              Colors.blue.shade400.withOpacity(value / 100);
                        });
                      },
                      min: 0,
                      max: 100,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Image(
                    image: AssetImage(
                      IconConst.cancel,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _customClip() {
    return ClipPath(
      clipper: LiftUpClipper(controlX: value),
      child: Container(
        height: 80 + (value * 200 / 100).round().toDouble(),
        width: MediaQuery.of(context).size.width / 2 - 15,
        color: _blueColor,
      ),
    );
  }
}
