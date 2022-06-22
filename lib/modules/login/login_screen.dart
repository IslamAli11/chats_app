
import 'package:chats_app/layout/cubit/cubit.dart';
import 'package:chats_app/modules/home_screen.dart';
import 'package:chats_app/modules/login/cubit/cubit.dart';
import 'package:chats_app/modules/register/cubit/cubit.dart';
import 'package:chats_app/modules/register/register_screen.dart';
import 'package:chats_app/shared/network/local/shared_preference.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../shared/component/component.dart';
import '../../shared/constante.dart';
import 'cubit/states.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginStates>(
      listener: (context, state) {

        if (state is UserLoginSuccessState) {
          ChatAppCubit.get(context).getUsers();
          ChatAppCubit.get(context).getUserData();
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            elevation: 3,
              content: Text(
            'SUCCESS',
          )));
          CacheHelper.saveData(key: 'uId', value:state.uId);
         navigateAndRemove(context: context, widget:const HomeScreen());
        }

      },
      builder: (context, state) {
        var cubit = LoginCubit.get(context);
        return Scaffold(
          backgroundColor: backgroundColor,
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formKey,
              child: ListView(
                children: [
                  const Image(
                    alignment: AlignmentDirectional.center,
                    image: AssetImage('assets/images/scholar.png'),
                    width: 300.0,
                    height: 100.0,
                  ),
                  const Center(
                    child: Text(
                      'Chat Me',
                      style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Pacifico',
                          color: Colors.white),
                    ),
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  const Text(
                    'Sign in',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 24.0),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  defaultTextFormField(
                      validate: (String? value) {
                        if (value!.isEmpty) {
                          return 'Email mus\'nt be empty';
                        }
                      },
                      labelText: 'Email',
                      prefixIcon: Icons.email,
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      hintText: 'Enter your Email'),
                  const SizedBox(
                    height: 20.0,
                  ),
                  defaultTextFormField(
                      validate: (String? value) {
                        if (value!.isEmpty) {
                          return 'Password mus\'nt be empty';
                        }
                      },
                      labelText: 'Password',
                      prefixIcon: Icons.lock,
                      obscureText: cubit.obscure,
                      onPressIcon: (){
                        cubit.eyeChange();
                      },
                      suffixIcon: cubit.suffixIcon,
                      controller: passwordController,
                      keyboardType: TextInputType.text,
                      hintText: 'Enter your Password'),
                  const SizedBox(
                    height: 15.0,
                  ),
                  if(state is LoadingLoginState)
                    const Center(child: CircularProgressIndicator()),
                  defaultTextButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          cubit.userLogin(
                            email: emailController.text,
                            password: passwordController.text,
                          );
                         ChatAppCubit.get(context).getUsers();
                        }
                      },
                      text: 'Sign in',
                      color: Colors.white,
                      textColor: Colors.black),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Do\'nt have an account ? ',
                        style: TextStyle(color: Colors.white),
                      ),
                      TextButton(
                          onPressed: () {
                            navigateTo(
                                widget: RegisterScreen(), context: context);
                          },
                          child: Text('REGISTER NOW')),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}