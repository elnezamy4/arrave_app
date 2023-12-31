// ignore_for_file: non_constant_identifier_names

import 'package:arrive_app/core/constant/app_assets.dart';
import 'package:arrive_app/core/constant/app_color.dart';
import 'package:arrive_app/widgets/home/build_title.dart';
import 'package:arrive_app/widgets/home/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart';

import '../../core/constant/animation_enum.dart';

class LoginScreen extends StatefulWidget {
  // ignore: constant_identifier_names
  static const ScreenRoute = 'login-screen';
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Artboard? riveArtboard;
  late RiveAnimationController controllerIdle;
  late RiveAnimationController controllerHandsUp;
  late RiveAnimationController controllerHandsDown;
  late RiveAnimationController controllerLookLeft;
  late RiveAnimationController controllerLookRight;
  late RiveAnimationController controllerSuccess;
  late RiveAnimationController controllerFail;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String Email = 'hassan@gmail.com';
  String Password = '12345';
  final PasswordFocusnode = FocusNode();
  bool isLookingLeft = false;
  bool isLookingRight = false;

  void removeAllControllers() {
    riveArtboard?.artboard.removeController(controllerIdle);
    riveArtboard?.artboard.removeController(controllerHandsUp);
    riveArtboard?.artboard.removeController(controllerHandsDown);
    riveArtboard?.artboard.removeController(controllerLookLeft);
    riveArtboard?.artboard.removeController(controllerLookRight);
    riveArtboard?.artboard.removeController(controllerSuccess);
    riveArtboard?.artboard.removeController(controllerFail);
    isLookingLeft = false;
    isLookingRight = false;
  }

  void addIdleController() {
    removeAllControllers();
    riveArtboard?.artboard.addController(controllerIdle);
    debugPrint("idleee");
  }

  void addHandsUpController() {
    removeAllControllers();
    riveArtboard?.artboard.addController(controllerHandsUp);
    debugPrint("hands up");
  }

  void addHandsDownController() {
    removeAllControllers();
    riveArtboard?.artboard.addController(controllerHandsDown);
    debugPrint("hands down");
  }

  void addSuccessController() {
    removeAllControllers();
    riveArtboard?.artboard.addController(controllerSuccess);
    debugPrint("Success");
  }

  void addFailController() {
    removeAllControllers();
    riveArtboard?.artboard.addController(controllerFail);
    debugPrint("Faillll");
  }

  void addLookRightController() {
    removeAllControllers();
    isLookingRight = true;
    riveArtboard?.artboard.addController(controllerLookRight);
    debugPrint("Righttt");
  }

  void addLookLeftController() {
    removeAllControllers();
    isLookingLeft = true;
    riveArtboard?.artboard.addController(controllerLookLeft);
    debugPrint("Leftttttt");
  }

  void checkForPasswordFocusNodeToChangeAnimationState() {
    PasswordFocusnode.addListener(() {
      if (PasswordFocusnode.hasFocus) {
        addHandsUpController();
      } else if (!PasswordFocusnode.hasFocus) {
        addHandsDownController();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    controllerIdle = SimpleAnimation(AnimationEnum.idle.name);
    controllerHandsUp = SimpleAnimation(AnimationEnum.Hands_up.name);
    controllerHandsDown = SimpleAnimation(AnimationEnum.hands_down.name);
    controllerLookRight = SimpleAnimation(AnimationEnum.Look_down_right.name);
    controllerLookLeft = SimpleAnimation(AnimationEnum.Look_down_left.name);
    controllerSuccess = SimpleAnimation(AnimationEnum.success.name);
    controllerFail = SimpleAnimation(AnimationEnum.fail.name);

    rootBundle.load(AppAssets.kLoginRive).then((data) {
      final file = RiveFile.import(data);
      final artboard = file.mainArtboard;
      artboard.addController(controllerHandsDown);
      setState(() {
        riveArtboard = artboard;
      });
    });

    checkForPasswordFocusNodeToChangeAnimationState();
  }

  void validateEmailAndPassword() {
    Future.delayed(const Duration(seconds: 1), () {
      if (formKey.currentState!.validate()) {
        addSuccessController();
        Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
      } else {
        addFailController();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        titleTextStyle: const TextStyle(
          color: AppColor.kCursorColor,
        ),
        title: buildTextTitle(
          'تسجيل الدخول',
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width / 20),
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            Column(
              children: [
                SizedBox(
                    height: MediaQuery.of(context).size.height / 3,
                    child: riveArtboard == null
                        ? const SizedBox.shrink()
                        : Rive(artboard: riveArtboard!)),
                Form(
                    key: formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: "البريد الاكتروني",
                            labelStyle: const TextStyle(
                                color: AppColor.kTextFiledBorderColor),
                            focusedBorder: buildBorder(
                                border: 25,
                                color: AppColor.kTextFiledBorderColor),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                          ),
                          validator: (m) => m != Email ? 'Wrong Email' : null,
                          onChanged: (value) {
                            if (value.isNotEmpty &&
                                value.length < 15 &&
                                !isLookingLeft) {
                              addLookLeftController();
                            } else if (value.isNotEmpty &&
                                value.length > 15 &&
                                !isLookingRight) {
                              addLookRightController();
                            }
                          },
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 25,
                        ),
                        TextFormField(
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: "كلمة المرور",
                            labelStyle: const TextStyle(
                                color: AppColor.kTextFiledBorderColor),
                            focusedBorder: buildBorder(
                                border: 25,
                                color: AppColor.kTextFiledBorderColor),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                          ),
                          focusNode: PasswordFocusnode,
                          validator: (m) =>
                              m != Password ? 'Wrong Password' : null,
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 18,
                        ),
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                            horizontal: MediaQuery.of(context).size.width / 8,
                          ),
                          child: TextButton(
                            style: TextButton.styleFrom(
                              shape: const StadiumBorder(),
                              backgroundColor: AppColor.kTextFiledBorderColor,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                            ),
                            onPressed: () {
                              PasswordFocusnode.unfocus();

                              validateEmailAndPassword();
                            },
                            child: const Text(
                              'Login',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            ),
                          ),
                        )
                      ],
                    ))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
