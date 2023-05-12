import 'package:blur/blur.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../Classes/GlobalVariables.dart';
import '../../Classes/TrainingCenter.dart';
import '../../Services/ScreenController.dart';
import '../../Widgets/Home/RoundedButton.dart';
import '../../Widgets/TrainingCenter/AllPersonalCourse.dart';
import '../../Widgets/TrainingCenter/PersonalCourseBox.dart';
import '../../Widgets/TrainingCenter/TrainerDetailedInfo.dart';
import '../../Widgets/TrainingCenter/TrainingCenterPersonalInfo.dart';

class TrainingCenterPersonal extends StatefulWidget {
  TrainingCenterPersonal({super.key, required this.tc});
  TrainingCenter tc;

  @override
  State<TrainingCenterPersonal> createState() => _TrainingCenterPersonalState();
}

class _TrainingCenterPersonalState extends State<TrainingCenterPersonal> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Align(
          alignment: AlignmentDirectional.bottomStart,
          child: Padding(
            padding: const EdgeInsets.only(right: 40, left: 40, bottom: 15),
            child: FloatingActionButton(
              backgroundColor: const Color(0xee1776e0),
              heroTag: "add",
              onPressed: () {
                showDialog(
                  context: context,
                  useSafeArea: true,
                  builder: (context) {
                    return AlertDialog(
                      content: Container(
                        height: 120,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          // color: Colors.amber,
                        ),
                        child: Column(children: [
                          OutlinedButton(
                            child: const Text(
                              "Add Course",
                              style: TextStyle(fontSize: 20),
                            ),
                            onPressed: () {},
                          ),
                          const Divider(),
                          OutlinedButton(
                            child: const Text(
                              "Add Trainer",
                              style: TextStyle(fontSize: 20),
                            ),
                            onPressed: () {},
                          )
                        ]),
                      ),
                    );
                  },
                );
              },
              materialTapTargetSize: MaterialTapTargetSize.padded,
              child: const Icon(
                Icons.add,
                size: 50,
                color: Colors.white,
              ),
            ),
          )),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(0, 0, 0, 0),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        elevation: 0,
        bottom: PreferredSize(
            preferredSize: const Size.fromHeight(4),
            child: Container(
              color: Colors.grey[400],
              height: 1,
            )),
        title: Text(
          (languageType == 0) ? "مركز التدريب" : "Training Center",
        ),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              //***** This is the image of the Training Center */
              SizedBox(
                height: 220,
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: CachedNetworkImageProvider(widget.tc.image),
                        fit: BoxFit.cover),
                  ),
                  child: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color(0xff000000),
                          Color(0x44000000),
                          Color(0x00000000),
                        ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                    ),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: SizedBox(
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 10, left: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(
                                  languageType == 0
                                      ? widget.tc.location.city_ar
                                      : widget.tc.location.city_en,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 32,
                                      shadows: [Shadow(color: Colors.black)]),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  languageType == 0
                                      ? "الفرع الرئيسي"
                                      : "Main Branch",
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      shadows: [Shadow(color: Colors.black)]),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              //**** This is the Data For The Training Center */
              Container(
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
                      child: Row(
                        children: [
                          Text(
                            languageType == 0
                                ? "مركز التدريب:"
                                : "Training Center:",
                            style: const TextStyle(fontSize: 18),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            widget.tc.name,
                            style: const TextStyle(fontSize: 18),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                      child: Row(
                        children: [
                          Text(
                            languageType == 0 ? "البريد الإلكتروني:" : "Email:",
                            style: const TextStyle(fontSize: 18),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            widget.tc.email,
                            style: const TextStyle(fontSize: 18),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                      child: Row(
                        children: [
                          Text(
                            languageType == 0 ? "رقم الهاتف:" : "Phone Number:",
                            style: const TextStyle(fontSize: 18),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            widget.tc.phoneNumber,
                            style: const TextStyle(fontSize: 18),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                      child: SizedBox(
                        width: 120,
                        child: TextButton(
                          style: TextButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(200),
                            ),
                          ),
                          onPressed: () {
                            Navigator.of(context).push(ScreenController()
                                .createRoute(
                                    const TrainingCenterParsonalInfo(), 1));
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                languageType == 0 ? "المزيد" : "More",
                                style: const TextStyle(
                                    fontSize: 20, color: Color(0xff1776e0)),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              const Icon(
                                Icons.more_horiz_outlined,
                                size: 30,
                                color: Color(0xff1776e0),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const Divider(),
              //**** Courses */
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          languageType == 0 ? "دورات" : "Courses",
                          style: const TextStyle(
                            color: Color(0xff1776e0),
                            fontSize: 26,
                            shadows: [Shadow(color: Color(0xff1776e0))],
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: Wrap(children: [
                        for (int i = 0; i < 4; i++)
                          PersonalCourseBox(
                            bld: courseBLDsmall[i],
                          ),
                      ]),
                    ),
                    RoundedButton(
                      icon: Icon(
                        (languageType == 0)
                            ? Icons.keyboard_arrow_left
                            : Icons.keyboard_arrow_right,
                        size: 40,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.of(context).push(
                          ScreenController()
                              .createRoute(const AllPersonalCourse(), 1),
                        );
                      },
                      size: 80,
                    ),
                  ],
                ),
              ),
              const Divider(),
              //*** This is the Trainers side */
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          languageType == 0 ? "المدربين" : "Trainers",
                          style: const TextStyle(
                            color: Color(0xff1776e0),
                            fontSize: 26,
                            shadows: [Shadow(color: Color(0xff1776e0))],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(200),
                          color: const Color(0x0c1776e0),
                        ),
                        child: InkWell(
                          onTap: () {},
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(20, 14, 20, 14),
                            child: Row(
                              children: [
                                Text(
                                  languageType == 0
                                      ? "ريان الفاندي"
                                      : "ryan elfandi",
                                  style: const TextStyle(fontSize: 20),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(200),
                          color: const Color(0x0c1776e0),
                        ),
                        child: InkWell(
                          onTap: () {},
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(20, 14, 20, 14),
                            child: Row(
                              children: [
                                Text(
                                  languageType == 0
                                      ? "ريان الفاندي"
                                      : "ryan elfandi",
                                  style: const TextStyle(fontSize: 20),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(200),
                          color: const Color(0x0c1776e0),
                        ),
                        child: InkWell(
                          onTap: () {},
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(20, 14, 20, 14),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  languageType == 0
                                      ? "ريان الفاندي"
                                      : "ryan elfandi",
                                  style: const TextStyle(fontSize: 20),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                      child: Stack(
                        children: [
                          Blur(
                            blur: 3,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(200),
                                color: const Color(0x0c1776e0),
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(20, 14, 20, 14),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      languageType == 0
                                          ? "ريان الفاندي"
                                          : "ryan elfandi",
                                      style: const TextStyle(fontSize: 20),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Center(
                            child: OutlinedButton(
                                child: const Padding(
                                  padding: EdgeInsets.fromLTRB(20, 8, 20, 8),
                                  child: Text(
                                    "more",
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.of(context).push(ScreenController()
                                      .createRoute(
                                          const TrainerDetailedInfo(), 1));
                                },
                                style: OutlinedButton.styleFrom(
                                    elevation: 3,
                                    shadowColor: const Color(0xff1776e0),
                                    backgroundColor: const Color(0xffffffff),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(200)))),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(),
              //** Statistics */
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          languageType == 0 ? "الإحصائيات" : "Statistics",
                          style: const TextStyle(
                            color: Color(0xff1776e0),
                            fontSize: 26,
                            shadows: [Shadow(color: Color(0xff1776e0))],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          const Text(
                            "ِActive courses: ",
                            style: TextStyle(fontSize: 18),
                          ),
                          const Text(
                            "10",
                            style: TextStyle(
                                color: Color(0xff1776e0), fontSize: 18),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          const Text(
                            "All courses: ",
                            style: TextStyle(fontSize: 18),
                          ),
                          const Text(
                            "34",
                            style: TextStyle(
                                color: Color(0xff1776e0), fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          const Text(
                            "ِTrainers: ",
                            style: TextStyle(fontSize: 18),
                          ),
                          const Text(
                            "15",
                            style: TextStyle(
                                color: Color(0xff1776e0), fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          const Text(
                            "Branches: ",
                            style: TextStyle(fontSize: 18),
                          ),
                          const Text(
                            "3",
                            style: TextStyle(
                                color: Color(0xff1776e0), fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          const Text(
                            "Rating: ",
                            style: TextStyle(fontSize: 18),
                          ),
                          const Text(
                            "4.5",
                            style: TextStyle(
                                color: Color(0xff1776e0), fontSize: 18),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              //*** This is the extra space down */
              const SizedBox(
                height: 70,
              )
            ],
          ),
        ),
      ),
    );
  }
}
