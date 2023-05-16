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
  double _value = 0;

  ///Manu background color
  final _constMenuBackgroundColor = Colors.blue.shade400;

  ///Button Size
  final double _enabledThumbRadius = 30;

  Color _menuBackgroundColor = Colors.blue.shade400.withOpacity(0);
  Color _whiteCircleColor = Colors.white;
  double _iconsSpacer = 0;

  Timer? _timer;
  bool _falling = false;
  bool _menuIsShowing = false;

  void _onSwipeUpMaxFinished({required bool finished}) {
    _menuIsShowing = finished;
    _falling = true;
    _timer = Timer.periodic(
      const Duration(milliseconds: 1),
      (Timer t) {
        //print("=>>> Value: $_value");
        if (_value > 1) {
          setState(() {
            _value--;
            if (_value < 10) {
              _whiteCircleColor = Colors.white.withOpacity(_value / 10);
            }
          });
        } else {
          setState(() {
            _whiteCircleColor = Colors.white.withOpacity(0);
            if (!finished) {
              _reset();
            }
          });
          _timer?.cancel();
          _timer = null;
        }
      },
    );
  }

  void _reset() {
    setState(() {
      _menuIsShowing = false;
      _menuBackgroundColor =
          _constMenuBackgroundColor.withOpacity(0);
      _falling = false;
      _whiteCircleColor = Colors.white;
    });
  }

  @override
  void initState() {
    super.initState();
    _menuBackgroundColor = _constMenuBackgroundColor.withOpacity(0);
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
        (_value * 200 / 100).round().toDouble();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Custom Menu Demo'),
        backgroundColor: _constMenuBackgroundColor,
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
                color: _menuBackgroundColor,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Transform.translate(
                    offset: Offset(0, _enabledThumbRadius / 2),
                    child: Container(
                      width: _enabledThumbRadius,
                      height: _enabledThumbRadius,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _whiteCircleColor,
                      ),
                    ),
                  ),
                ),
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
          if (!_menuIsShowing)
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
                        thumbColor: _constMenuBackgroundColor,
                        thumbShape: RoundSliderThumbShape(
                          enabledThumbRadius: _enabledThumbRadius,
                        ),
                        overlayColor: Colors.black.withOpacity(0),
                        overlayShape:
                            const RoundSliderOverlayShape(overlayRadius: 1.0),
                      ),
                      child: Slider(
                        value: _value,
                        onChanged: (newValue) {
                          setState(() {
                            // debugPrint(
                            //     "Value: ${_value.toString()}, newValue: $newValue");
                            _value = newValue;
                            _menuBackgroundColor = _constMenuBackgroundColor
                                .withOpacity(_value / 100);

                            if (_value >= 100 && !_falling) {
                              _onSwipeUpMaxFinished(finished: true);
                            }
                          });
                        },
                        onChangeEnd: (value) {
                          _onSwipeUpMaxFinished(finished: false);
                        },
                        min: 0,
                        max: 100,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          if (_menuIsShowing)
            MenuView(
              opacity: 1 - _value / 100,
              onCanceled: _reset,
              buttonsList: [
                CustomTextButton(
                  title: 'Menu 1',
                  opacity: 1 - _value / 100,
                ),
                CustomTextButton(
                  title: 'Menu 2',
                  opacity: 1 - _value / 100,
                ),
                CustomTextButton(
                  title: 'Menu 3',
                  opacity: 1 - _value / 100,
                ),
                // CustomTextButton(
                //   title: 'Menu 4',
                //   opacity: 1 - _value / 100,
                // ),
                // CustomTextButton(
                //   title: 'Menu 5',
                //   opacity: 1 - _value / 100,
                // ),
                // CustomTextButton(
                //   title: 'Menu 6',
                //   opacity: 1 - _value / 100,
                // ),
                // CustomTextButton(
                //   title: 'Menu 7',
                //   opacity: 1 - _value / 100,
                // ),
                // CustomTextButton(
                //   title: 'Menu 8',
                //   opacity: 1 - _value / 100,
                // ),
                // CustomTextButton(
                //   title: 'Menu 9',
                //   opacity: 1 - _value / 100,
                // ),
                // CustomTextButton(
                //   title: 'Menu 10',
                //   opacity: 1 - _value / 100,
                // ),
              ],
            ),
        ],
      ),
    );
  }

  Widget _customClip() {
    double height = (_falling ? 0 : 80) + (_value * 200 / 100).round().toDouble() - 2;
    if (height < 0) {
      height = 0;
    }
    //print('Container Height: ${(_falling ? 0 : 80) + (_value * 200 / 100).round().toDouble()}, _value: $_value');
    return ClipPath(
      clipper: LiftUpClipper(controlX: _value, falling: _falling),
      child: Container(
        height: height,
        width: MediaQuery.of(context).size.width / 2 - _enabledThumbRadius / 2,
        color: _menuBackgroundColor,
      ),
    );
  }
}
