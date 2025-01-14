import 'package:blur/blur.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:coursati/Classes/AllTrainingCenterData.dart';
import 'package:coursati/Classes/BoxCourseLabelData.dart';

import 'package:coursati/Widgets/Home/BoxTCLabel.dart';
import 'package:coursati/Widgets/Home/CourseBox.dart';
import 'package:coursati/Widgets/TrainingCenter/AddTrainer.dart';
import 'package:coursati/Widgets/TrainingCenter/AllPersonalTrainers.dart';
import 'package:coursati/Widgets/TrainingCenter/TrainerDetiled/TrainerDetailedfetchData.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../Classes/BoxTCLabelData.dart';
import '../../Classes/GlobalVariables.dart';
import '../../Classes/TrainingCenter.dart';
import '../../Services/ScreenController.dart';
import '../../Widgets/Home/RoundedButton.dart';
import '../../Widgets/TrainingCenter/ADDCourse/AddCourse.dart';
import '../../Widgets/TrainingCenter/ADDCourse/ContainerForCourse.dart';
import '../../Widgets/TrainingCenter/AllPersonalCourse.dart';
import '../../Widgets/TrainingCenter/PersonalCourseBox.dart';
import '../../Widgets/TrainingCenter/TrainerDetiled/TrainerDetailedInfo.dart';
import '../../Widgets/TrainingCenter/TrainingCenterPersonalInfo.dart';

class TrainingCenterPersonal extends StatefulWidget {
  TrainingCenterPersonal(
      {super.key, required this.id, required this.mainBranch});
  String id;
  bool mainBranch;

  @override
  State<TrainingCenterPersonal> createState() => _TrainingCenterPersonalState();
}

class _TrainingCenterPersonalState extends State<TrainingCenterPersonal> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: getAllData(widget.id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data != null) {
              AllTrainingCenterData Data =
                  AllTrainingCenterData.fromJson(snapshot.data);
              List<BoxCourseLabelData> activeCourses = [];
              Data.courses.forEach((element) {
                if (element.state == 1) {
                  activeCourses.add(element);
                }
              });

              return Scaffold(
                floatingActionButton: Align(
                    alignment: AlignmentDirectional.bottomEnd,
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
                                    child: Text(
                                      languageType == 0
                                          ? "إضافة دورة"
                                          : "Add Course",
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    onPressed: () async {
                                      bool result = await Navigator.of(context)
                                          .push(ScreenController().createRoute(
                                              ContainerForCourse(
                                                trainingCenter: Data.tcData!,
                                              ),
                                              1));
                                      if (result) {
                                        setState(() {
                                          Navigator.pop(context);
                                        });
                                      }
                                    },
                                  ),
                                  const Divider(),
                                  OutlinedButton(
                                    child: Text(
                                      languageType == 0
                                          ? "إضافة مدرب"
                                          : "Add Trainer",
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    onPressed: () async {
                                      bool result = await Navigator.of(context)
                                          .push(ScreenController().createRoute(
                                              AddTrainer(
                                                  trainingCenter: Data.tcData!),
                                              1));
                                      if (result) {
                                        setState(() {
                                          Navigator.pop(context);
                                        });
                                      }
                                    },
                                  )
                                ]),
                              ),
                            );
                          },
                        );
                      },
                      // materialTapTargetSize: MaterialTapTargetSize.padded,
                      child: const Icon(
                        Icons.add,
                        size: 35,
                        color: Colors.white,
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
                                  image: CachedNetworkImageProvider(
                                      Data.tcData!.image),
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
                                    padding: const EdgeInsets.only(
                                        right: 10, left: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width -
                                                150,
                                            child: Text(
                                              Data.tcData!.name,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 32,
                                                  shadows: [
                                                    Shadow(color: Colors.black)
                                                  ]),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            widget.mainBranch
                                                ? languageType == 0
                                                    ? "الفرع الرئيسي"
                                                    : "Main Branch"
                                                : languageType == 0
                                                    ? "فرع"
                                                    : "Branch",
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 16,
                                                shadows: [
                                                  Shadow(color: Colors.black)
                                                ]),
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
                                padding:
                                    const EdgeInsets.fromLTRB(10, 20, 10, 10),
                                child: Row(
                                  children: [
                                    Text(
                                      languageType == 0
                                          ? "الموقع:"
                                          : "Location:",
                                      style: const TextStyle(fontSize: 18),
                                    ),
                                    const SizedBox(width: 10),
                                    Text(
                                      Data.tcData!.location.city!,
                                      style: const TextStyle(fontSize: 18),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 10, 10, 10),
                                child: Row(
                                  children: [
                                    Text(
                                      languageType == 0
                                          ? "البريد الإلكتروني:"
                                          : "Email:",
                                      style: const TextStyle(fontSize: 18),
                                    ),
                                    const SizedBox(width: 10),
                                    Text(
                                      Data.tcData!.email,
                                      style: const TextStyle(fontSize: 18),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 10, 10, 10),
                                child: Row(
                                  children: [
                                    Text(
                                      languageType == 0
                                          ? "رقم الهاتف:"
                                          : "Phone Number:",
                                      style: const TextStyle(fontSize: 18),
                                    ),
                                    const SizedBox(width: 10),
                                    Text(
                                      Data.tcData!.phoneNumber,
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
                                        borderRadius:
                                            BorderRadius.circular(200),
                                      ),
                                    ),
                                    onPressed: () {
                                      Navigator.of(context).push(
                                          ScreenController().createRoute(
                                              TrainingCenterParsonalInfo(
                                                  tc: Data.tcData!),
                                              1));
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          languageType == 0 ? "المزيد" : "More",
                                          style: const TextStyle(
                                              fontSize: 20,
                                              color: Color(0xff1776e0)),
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
                                      shadows: [
                                        Shadow(color: Color(0xff1776e0))
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Center(
                                child: Wrap(children: [
                                  for (int i = 0;
                                      i <
                                          ((Data.courses.length > 4)
                                              ? 4
                                              : Data.courses.length);
                                      i++)
                                    PersonalCourseBox(
                                      bld: Data.courses[i],
                                    ),
                                ]),
                              ),
                              Data.courses.length > 4
                                  ? RoundedButton(
                                      icon: Icon(
                                        (languageType == 0)
                                            ? Icons.keyboard_arrow_left
                                            : Icons.keyboard_arrow_right,
                                        size: 40,
                                        color: Colors.white,
                                      ),
                                      onPressed: () {
                                        Navigator.of(context).push(
                                          ScreenController().createRoute(
                                              AllPersonalCourse(
                                                  courses: Data.courses),
                                              1),
                                        );
                                      },
                                      size: 80,
                                    )
                                  : Container(),
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
                                      shadows: [
                                        Shadow(color: Color(0xff1776e0))
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              for (int i = 0;
                                  i <
                                      ((Data.trainers.length > 4)
                                          ? 3
                                          : Data.trainers.length);
                                  i++)
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 10, 10, 0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(200),
                                      color: const Color(0x0c1776e0),
                                    ),
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.of(context).push(
                                            ScreenController().createRoute(
                                                TrainerDetailedFetchData(
                                                    id: Data.trainers[i].id),
                                                1));
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            20, 14, 20, 14),
                                        child: Row(
                                          children: [
                                            Text(
                                              Data.trainers[i].id,
                                              style:
                                                  const TextStyle(fontSize: 20),
                                            ),
                                            const SizedBox(
                                              width: 20,
                                            ),
                                            Text(
                                              Data.trainers[i].name,
                                              style:
                                                  const TextStyle(fontSize: 20),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              (Data.trainers.length > 4)
                                  ? Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          10, 10, 10, 0),
                                      child: Stack(
                                        children: [
                                          Blur(
                                            blur: 2,
                                            blurColor: Colors.transparent,
                                            borderRadius:
                                                BorderRadius.circular(200),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(200),
                                                color: const Color(0x0c1776e0),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        20, 14, 20, 14),
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      Data.trainers[3].id,
                                                      style: const TextStyle(
                                                          fontSize: 20),
                                                    ),
                                                    const SizedBox(
                                                      width: 20,
                                                    ),
                                                    Text(
                                                      Data.trainers[3].name,
                                                      style: const TextStyle(
                                                          fontSize: 20),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          Center(
                                            child: OutlinedButton(
                                                onPressed: () {
                                                  // Navigator.of(context).push(
                                                  //     ScreenController()
                                                  //         .createRoute(
                                                  //             const AllPersonalTrainers(),
                                                  //             1));
                                                },
                                                style: OutlinedButton.styleFrom(
                                                    elevation: 3,
                                                    shadowColor:
                                                        const Color(0xff1776e0),
                                                    backgroundColor:
                                                        const Color(0xffffffff),
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        200))),
                                                child: const Padding(
                                                  padding: EdgeInsets.fromLTRB(
                                                      20, 8, 20, 8),
                                                  child: Text(
                                                    "more",
                                                    style:
                                                        TextStyle(fontSize: 20),
                                                  ),
                                                )),
                                          )
                                        ],
                                      ),
                                    )
                                  : Container(),
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
                                    languageType == 0
                                        ? "الإحصائيات"
                                        : "Statistics",
                                    style: const TextStyle(
                                      color: Color(0xff1776e0),
                                      fontSize: 26,
                                      shadows: [
                                        Shadow(color: Color(0xff1776e0))
                                      ],
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
                                    Text(
                                      activeCourses.length.toString(),
                                      style: TextStyle(
                                          color: Color(0xff1776e0),
                                          fontSize: 18),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    const Text(
                                      "All courses: ",
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    Text(
                                      Data.courses.length.toString(),
                                      style: TextStyle(
                                          color: Color(0xff1776e0),
                                          fontSize: 18),
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
                                    Text(
                                      Data.trainers.length.toString(),
                                      style: TextStyle(
                                          color: Color(0xff1776e0),
                                          fontSize: 18),
                                    ),
                                  ],
                                ),
                              ),
                              widget.mainBranch
                                  ? Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          const Text(
                                            "Branches: ",
                                            style: TextStyle(fontSize: 18),
                                          ),
                                          Text(
                                            Data.tcData!.branchCount.toString(),
                                            style: TextStyle(
                                                color: Color(0xff1776e0),
                                                fontSize: 18),
                                          ),
                                        ],
                                      ),
                                    )
                                  : Container(),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    const Text(
                                      "Rating: ",
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    Text(
                                      Data.tcData!.rating.toString(),
                                      style: const TextStyle(
                                          color: Color(0xff1776e0),
                                          fontSize: 18),
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
            } else {
              return const Center(child: Text("Your request took to long"));
            }
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Future getAllData(String id) async {
    var url = "/tc/mytc/info";
    try {
      var response = await dioTestApi.post(url, data: {"tcID": id});
      if (response.statusCode == 200) {
        return response.data;
      }
    } catch (exception) {
      if (kDebugMode) {
        print(exception);
      }
    }
  }
}
