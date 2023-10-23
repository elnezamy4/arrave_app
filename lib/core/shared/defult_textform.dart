import 'package:flutter/material.dart';

class CustomDefultTextForm extends StatelessWidget {
  const CustomDefultTextForm({
    super.key,
    required this.hintText,
    required this.lableText,
    required this.iconData,
    required this.myController,
    this.isNumber = false,
    required this.validator,
    this.isPassword = false,
    this.onTapIcon,
  });
  final String hintText;
  final String lableText;
  final IconData iconData;
  final TextEditingController myController;
  final bool? isNumber;
  final String? Function(String?) validator;
  final bool? isPassword;
  final void Function()? onTapIcon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      margin: const EdgeInsets.only(bottom: 20),
      child: TextFormField(
        obscureText: isPassword == null || isPassword == false ? false : true,
        validator: validator,
        keyboardType: isNumber as bool
            ? const TextInputType.numberWithOptions(decimal: true)
            : TextInputType.text,
        controller: myController,
        decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 5, horizontal: 30),
          label: Container(
              margin: const EdgeInsets.symmetric(horizontal: 9),
              child: Text(lableText)),
          hintText: hintText,
          hintStyle: const TextStyle(fontSize: 14),
          suffixIcon: InkWell(onTap: onTapIcon, child: Icon(iconData)),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
      ),
    );
  }
}
