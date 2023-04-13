import 'package:coursati/Classes/BoxCourseLabelData.dart';
import 'package:flutter/material.dart';

class BoxCourseLabel extends StatefulWidget {
  BoxCourseLabel({super.key, required this.bld});
  BoxCourseLabelData bld;

  @override
  State<BoxCourseLabel> createState() => _BoxCourseLabelState();
}

class _BoxCourseLabelState extends State<BoxCourseLabel> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 140,
            child: Text(
              softWrap: true,
              widget.bld.label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.start,
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 15,
              ),
              Container(
                child: Text(
                  "في مركز ${widget.bld.In}",
                  softWrap: true,
                  style: TextStyle(color: Colors.white, fontSize: 10),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
