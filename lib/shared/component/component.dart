import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:chats_app/models/message_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



Widget defaultTextFormField({
  VoidCallback? onTap,
  Function? onPressIcon,
   String? Function(String?)? validate,
  required String? labelText,
  String? hintText,
  required IconData prefixIcon,
  IconData? suffixIcon,
  required TextEditingController controller,
  required TextInputType keyboardType,
  bool obscureText = false,
  Color? borderColor = Colors.white ,
  Color? prefixIconColor = Colors.white,
 floatingLabelColor = Colors.white,
}) =>
    TextFormField(
      validator: validate,
      onTap: () {
        onTap;
      },
      obscureText: obscureText,
      controller: controller,
      keyboardType: keyboardType,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
          labelText: labelText,
          labelStyle: TextStyle(color: Colors.grey),
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey),
          floatingLabelStyle: TextStyle(color: floatingLabelColor),
          prefixIcon: Icon(
            prefixIcon,
            color: prefixIconColor,
          ),
          suffixIcon: IconButton(
            icon: Icon(suffixIcon),
            onPressed: () {
              onPressIcon!();
            },
          ),
          prefixIconColor:prefixIconColor ,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: borderColor!),
            borderRadius: BorderRadius.all(Radius.circular(25.0)),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: borderColor),
              borderRadius: BorderRadius.all(Radius.circular(25.0)),
          ),

      ),
    );

Widget defaultTextButton({
  required Function? onPressed,
  required String text,
  Color? color,
  Color? textColor,
  double radius = 25.0,
  double fontSize = 20.0,
}) =>
    Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(radius),
      ),
      child: TextButton(
          onPressed: () {
            onPressed!();
          },
          child: Text(
            text,
            style: TextStyle(
                color: textColor,
                fontWeight: FontWeight.bold,
                fontSize: fontSize),
          )),
    );

navigateTo({
  required Widget widget,
  required BuildContext context,
}) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));

navigateAndRemove({
  required BuildContext context,
  required Widget widget,
}) =>
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (context) => widget), (route) => false);

Widget receiverMessage( MessageModel model) =>  BubbleSpecialThree(
    text: model.text,
    color: Color(0xFF1B97F3),
    tail: false,
    textStyle: TextStyle(color: Colors.white, fontSize: 16)
);
Widget senderMessage( MessageModel model)=>   BubbleSpecialThree(
    text: model.text,
    color: Color(0xFF1B97F3),
    tail: false,
    isSender: true,
    textStyle: TextStyle(color: Colors.white, fontSize: 16)
);
