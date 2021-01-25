import 'package:Ecommerce/constatns.dart';
import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final bool login;
  final String hint;
  final String validationText;
  final bool isNameEdit;
  final bool isPassword;
  final TextEditingController controller;
  MyTextField(this.hint, this.controller, this.validationText,
      {this.login, this.isNameEdit, this.isPassword});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30.0),
      child: TextFormField(
        obscureText: isPassword == true ? true : false,
        style: isNameEdit == true
            ? myGoogleFont(Colors.white, 20, FontWeight.w600)
            : myGoogleFont(darkColor, 18, FontWeight.w500),
        controller: controller,
        validator: (val) {
          if (val.length == 0 && login != true) {
            return validationText;
          }
        },
        decoration: InputDecoration(
            // suffixIcon: isPassword == true
            //     ? Icon(
            //         Icons.remove_red_eye,
            //         color: Colors.grey[300],
            //       )
            //     : Container(),
            // icon: isPassword == true ? Icon(Icons.remove_red_eye) : Container(),
            disabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: darkColor, width: 1),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: darkColor, width: 1),
            ),
            hintText: hint,
            hintStyle: TextStyle(color: Colors.grey[400]),
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: yellowColor, width: 1)),
            errorBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.red, width: 1)),
            errorStyle: myGoogleFont(Colors.red, 14, FontWeight.w500)),
      ),
    );
  }
}
