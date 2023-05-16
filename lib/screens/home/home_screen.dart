import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_custom_menu/screens/home/widgets/custom_text_button.dart';
import 'package:flutter_custom_menu/screens/home/widgets/menu_view.dart';

import 'custom_clippers/lift_up_clipper.dart';
import 'widgets/b_b_icon_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double value = 0;

  Color _blueColor = Colors.blue.shade400.withOpacity(0);
  double _iconsSpacer = 0;

  Timer? _timer;
  bool _falling = false;
  bool _menuIsShowing = false;

  double _enabledThumbRadius = 30;


  void _onSwipeUpMaxFinished() {
    _timer = Timer.periodic(
      const Duration(milliseconds: 2),
      (Timer t) {
        print("=>>> Value: $value");
        if (value > 1) {
          setState(() {
            value--;
          });
        } else {
         _timer?.cancel();
         _timer = null;
        }
      },
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _iconsSpacer = MediaQuery.of(context).size.width / 15;
  }

  @override
  Widget build(BuildContext context) {
    final availableHeight = MediaQuery.of(context).size.height -
        AppBar().preferredSize.height -
        MediaQuery.of(context).padding.top -
        (_falling ? 0 : 80) -
        (value * 200 / 100).round().toDouble();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Custom Menu Demo'),
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
                        width: _iconsSpacer,
                      ),
                      BBIconButton(
                        onPressed: () {},
                        icon: Icons.calendar_today,
                      ),
                      SizedBox(
                        width: _iconsSpacer,
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
                        width: _iconsSpacer,
                      ),
                      BBIconButton(
                        onPressed: () {},
                        icon: Icons.ac_unit,
                      ),
                      SizedBox(
                        width: _iconsSpacer,
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
          if (!_menuIsShowing) SafeArea(
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
                      thumbColor: Colors.blue.shade400,
                      thumbShape:
                          RoundSliderThumbShape(enabledThumbRadius: _enabledThumbRadius,),
                      overlayColor: Colors.black.withOpacity(0),
                      overlayShape: const RoundSliderOverlayShape(overlayRadius: 1.0),
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

                          if (value >= 100 && !_falling) {
                            _menuIsShowing = true;
                            _falling = true;
                            _onSwipeUpMaxFinished();
                          }
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
          if (_menuIsShowing) MenuView(
            onCanceled: () {
              setState(() {
                _menuIsShowing = false;
                _blueColor = Colors.blue.shade400.withOpacity(0);
                _falling = false;
              });
            },
            buttonsList: const [
              CustomTextButton(title: 'Menu 1'),
              CustomTextButton(title: 'Menu 2'),
              CustomTextButton(title: 'Menu 3'),
              // CustomTextButton(title: 'Menu 4'),
              // CustomTextButton(title: 'Menu 5'),
              // CustomTextButton(title: 'Menu 6'),
              // CustomTextButton(title: 'Menu 7'),
              // CustomTextButton(title: 'Menu 8'),
              // CustomTextButton(title: 'Menu 9'),
              // CustomTextButton(title: 'Menu 10'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _customClip() {

    return ClipPath(
      clipper: LiftUpClipper(controlX: value, falling: _falling),
      child: Container(
        height: (_falling ? 0 : 80) + (value * 200 / 100).round().toDouble(),
        width: MediaQuery.of(context).size.width / 2 - _enabledThumbRadius /2,
        color: _blueColor,
      ),
    );
  }
}
