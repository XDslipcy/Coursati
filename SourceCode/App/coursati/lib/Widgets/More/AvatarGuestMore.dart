import 'package:flutter/material.dart';

import '../../Classes/GlobalVariables.dart';
import '../../Screens/SubScreen/loginPage.dart';
import '../../Services/ScreenController.dart';

class AvatarGuestMore extends StatefulWidget {
  const AvatarGuestMore({super.key});

  @override
  State<AvatarGuestMore> createState() => _AvatarGuestMoreState();
}

class _AvatarGuestMoreState extends State<AvatarGuestMore> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(
          height: 20,
        ),
        Container(
          width: double.infinity,
          height: 200,
          child: Stack(children: [
            const Align(
              alignment: Alignment.center,
              child: CircleAvatar(
                backgroundColor: Colors.white,
                backgroundImage: AssetImage("Assets/Icons/user.png"),
                radius: 50,
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: TextButton(
                style: ButtonStyle(
                    backgroundColor: const MaterialStatePropertyAll(
                      Color(0x66000000),
                    ),
                    elevation: const MaterialStatePropertyAll(10),
                    minimumSize: const MaterialStatePropertyAll(
                      Size(170, 40),
                    ),
                    shape: MaterialStatePropertyAll(ContinuousRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ))),
                onPressed: () {
                  Navigator.of(context).push(
                    ScreenController().createRoute(
                      loginPage(
                        contextIn: context,
                      ),
                      0,
                    ),
                  );
                },
                child: Text(
                  (languageType == 0) ? "تسجيل الدخول" : "Sign in",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
            )
          ]),
        ),
      ],
    );
  }
}
