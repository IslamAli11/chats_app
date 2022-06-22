import 'package:chats_app/modules/register/cubit/states.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../models/user_model.dart';


class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(InitialRegisterState());

  static RegisterCubit get(context) => BlocProvider.of(context);
 UserModel? userModel;
  void userRegister({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) {
    emit(LoadingRegisterState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      userCreate(name: name, email: email, phone: phone, uId: value.user!.uid);
      emit(RegisterSuccessState());
    }).catchError((error) {
      emit(RegisterErrorState());
    });
  }

  void userCreate({
    required String name,
    required String email,
    required String phone,
    required String uId,
    String? image,
    String? bio,
  }) {
    UserModel userModel = UserModel(
        name: name,
        email: email,
        phone: phone,
        uId: uId,
        image: 'https://img.freepik.com/free-photo/cup-coffee-coffee-beans_164008-356.jpg?w=826',
        bio: 'Hi iam here....?!!');
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(userModel.toMap())
        .then((value) {
      emit(UserCreateSuccessState());
    }).catchError((error) {
      emit(UserCreateErrorState());
    });
  }

  bool obscureText = true;
  late IconData suffix = Icons.visibility_outlined;

  void eyePasswordChang() {

    obscureText =! obscureText;
   suffix = obscureText? Icons.visibility_outlined:Icons.visibility_off_outlined;
    emit(EyePasswordChangState());
    }



}
