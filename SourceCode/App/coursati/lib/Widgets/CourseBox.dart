import 'package:coursati/Classes/BoxCourseLabelData.dart';
import 'package:coursati/Widgets/BoxCourseLabel.dart';
import 'package:flutter/material.dart';

class CourseBox extends StatefulWidget {
  const CourseBox({super.key, required this.bld});

  final BoxCourseLabelData bld;

  @override
  State<CourseBox> createState() => _CourseBoxState();
}

class _CourseBoxState extends State<CourseBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
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
            splashFactory: InkSplash.splashFactory,
            onTap: () => {
              //////////////////////////////////////////////////
              ///
              ///
              ///Here where you write your code on tap

              ///////////////////////////////////////////////////
              ///
              ///
              ///
            },
            splashColor: const Color(0xff1776e0),
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
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      const SizedBox(
                        width: 10,
                      ),
                      BoxCourseLabel(bld: widget.bld),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
