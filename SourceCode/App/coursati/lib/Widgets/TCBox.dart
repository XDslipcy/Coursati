import 'package:coursati/Classes/BoxTCLabelData.dart';
import 'package:coursati/Widgets/BoxTCLabel.dart';
import 'package:flutter/material.dart';

//////////////////////////////////////////////////////////////
///
///
class TCBox extends StatefulWidget {
  const TCBox({
    super.key,
    required this.bld,
  });

  final BoxTCLabelData bld;

  @override
  State<TCBox> createState() => _TCBoxState();
}

class _TCBoxState extends State<TCBox> with TickerProviderStateMixin {
  late AnimationController _boxAnimationController;

  @override
  void initState() {
    // TODO: implement initState
    _boxAnimationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 150),
      value: 1.0,
      lowerBound: 1.0,
      upperBound: 1.05,
    );
    super.initState();
  }
////////////////////////////////////////////////////////////////////////////////
  ///
  ///

  @override
  Widget build(BuildContext context) {
    try {
      return ScaleTransition(
        scale: _boxAnimationController,
        child: Container(
          margin: const EdgeInsets.fromLTRB(15, 5, 0, 20),
          width: 170,
          height: 240,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Material(
            elevation: 5,
            shadowColor: const Color(0xff1776e0),
            borderRadius: BorderRadius.circular(20),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: const LinearGradient(
                  colors: [
                    Color(0xff000000),
                    Color(0x22ffffff),
                    Color(0x00000000),
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
              child: InkWell(
                borderRadius: BorderRadius.circular(20),
                highlightColor: null,
                splashFactory: InkSparkle.constantTurbulenceSeedSplashFactory,
                onTap: _onTap,
                //////////////////////////////////////////////////
                ///
                ///
                ///Here where you write your code on tap

                ///////////////////////////////////////////////////
                ///
                ///
                ///

                splashColor: const Color(0xdd1776e0),
                child: Ink(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                      image: NetworkImage(
                        widget.bld.image,
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image(
                          image: NetworkImage(widget.bld.logo),
                          height: 30,
                          width: 30,
                        ),
                      ),
                      const Spacer(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Row(
                            children: [
                              const SizedBox(
                                width: 10,
                              ),
                              BoxTCLabel(
                                bld: widget.bld,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    } catch (exception) {
      return Container();
    }
  }

  void _onTap() {
    _boxAnimationController.forward().then((value) => {
          _boxAnimationController.reverse(),
        });
  }
}
