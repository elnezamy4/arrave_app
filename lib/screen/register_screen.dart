import 'package:arrive_app/core/constant/app_assets.dart';
import 'package:arrive_app/core/shared/defult_textform.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  // ignore: constant_identifier_names
  static const ScreenRoute = 'register_screen';

  const RegisterPage({super.key});
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> key = GlobalKey<FormState>();
  late String? tripname;

  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  @override
  // void initState() {
  //   usernameController.text = tripTitle;
  //   super.initState();
  // }

  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    final tripTitle = routeArgs["name"].toString();
    // final tripcat = routeArgs["cat"].toString();
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: key,
          child: Column(children: [
            Container(
              height: 150,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 114, 2, 71),
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.elliptical(30, 30),
                  bottomLeft: Radius.elliptical(30, 30),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10.0, top: 10.0),
                child: Center(child: Image.asset(AppAssets.image)),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            CustomDefultTextForm(
              hintText: "ادخل اسم المستخدم",
              iconData: Icons.person,
              lableText: "اسم المستخدم",
              validator: (val) {
                if (val == "") {
                  return "Wrong User Name";
                }
                return null;
              },
              myController: usernameController,
            ),
            CustomDefultTextForm(
              hintText: "ادخل رقم الهاتف",
              iconData: Icons.phone,
              lableText: "رقم الهاتف",
              isPassword: false,
              isNumber: true,
              validator: (val) {
                if (val == "") {
                  return "Wrong Phone Number";
                }
                return null;
              },
              myController: passwordController,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "اسم الرحلة : ",
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    tripTitle,
                    style: const TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                ],
              ),
            ),
            Container(
              height: 60,
              width: 300,
              decoration: const BoxDecoration(),
              child: TextButton(
                onPressed: () {
                  if (key.currentState!.validate()) {
                    Navigator.of(context).pushNamed('/');
                  }
                },
                child: const Text(
                  "Register",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}

class DefultTextForm extends StatelessWidget {
  const DefultTextForm(
      {super.key,
      required this.hintxt,
      required this.title,
      required this.validator});
  final String hintxt;
  final String title;
  final String? Function(String?) validator;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(40, 5, 20, 10),
      child: Row(
        children: [
          Text(
            "$title : ",
            style: const TextStyle(fontSize: 18),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ]),
              child: TextFormField(
                validator: validator,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.only(left: 14),
                  hintText: hintxt,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
