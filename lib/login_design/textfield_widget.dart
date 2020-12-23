//this page for input fields

import 'package:flutter/material.dart';
import 'package:health_guard/globals.dart';
import 'package:health_guard/login_design/home_model.dart';
import 'package:provider/provider.dart';

class TextFieldWidget extends StatelessWidget {
  final String hintText;
  final IconData prefixIconData;
  final IconData suffixIconData;
  final bool obscureText;
  final Function onChanged;
  final TextEditingController controller;

  TextFieldWidget({
    this.hintText,
    this.prefixIconData,
    this.suffixIconData,
    this.obscureText,
    this.onChanged,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<HomeModel>(context);

    return TextField(
      controller: controller,
      onChanged: onChanged,
      obscureText: obscureText,
      cursorColor: Global.mediumGreen,
      style: TextStyle(
        color: Global.mediumGreen,
        fontSize: 15.0,
      ),
      decoration: InputDecoration(
        labelStyle: TextStyle(color: Global.mediumGreen),
        focusColor: Global.mediumGreen,
        filled: true,
        enabledBorder: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Global.mediumGreen),
        ),
        labelText: hintText,
        prefixIcon: Icon(
          prefixIconData,
          size: 20,
          color: Global.mediumGreen,
        ),
        suffixIcon: GestureDetector(
          onTap: () {
            model.isVisible = !model.isVisible;
          },
          child: Icon(
            suffixIconData,
            size: 18,
            color: Global.mediumGreen,
          ),
        ),
      ),
    );
  }
}