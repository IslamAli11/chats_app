import 'package:chats_app/modules/login/cubit/states.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../register/cubit/states.dart';

class LoginCubit extends Cubit<LoginStates>{
  LoginCubit() : super(InitialLoginState());


  static LoginCubit get(context)=>BlocProvider.of(context);

  void userLogin({
    required String email,
    required String password,
  })  {
    emit(LoadingLoginState());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      print(value.user!.email);
      emit(UserLoginSuccessState(value.user!.uid));
    }).catchError((error) {
      emit(UserLoginErrorState());
    });
  }


  bool obscure = true;
  IconData suffixIcon = Icons.visibility_outlined;
  void eyeChange(){
    emit(EyeChangState());
    obscure =! obscure;
    suffixIcon = obscure? Icons.visibility_outlined:Icons.visibility_off_outlined;
    emit(EyeChangState());

  }

}