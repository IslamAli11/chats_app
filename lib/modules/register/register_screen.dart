
import 'package:chats_app/layout/cubit/cubit.dart';
import 'package:chats_app/modules/home_screen.dart';
import 'package:chats_app/modules/register/cubit/cubit.dart';
import 'package:chats_app/modules/register/cubit/states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../shared/component/component.dart';
import '../../shared/constante.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterStates>(
      listener: (context, state) {
      },
      builder: (context, state) {
        var cubit = RegisterCubit.get(context);
        return Scaffold(
          backgroundColor: backgroundColor,
          appBar: AppBar(
            backgroundColor: backgroundColor,
            elevation: 0.0,
          ),
          body: Form(
            key: formKey,
            child: ListView(
              padding: const EdgeInsets.all(20.0),
              children: [
                const Text(
                  'REGISTER',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 30.0,
                ),
                defaultTextFormField(
                    validate: (String? value) {
                      if(value!.isEmpty) {
                        return 'Name mus\'nt be empty ';
                      }
                    },
                    labelText: 'Name',
                    hintText: 'Enter your Name',
                    prefixIcon: Icons.person,
                    controller: nameController,
                    keyboardType: TextInputType.name),
                const SizedBox(
                  height: 20.0,
                ),
                defaultTextFormField(
                    validate: (String? value) {
                      if(value!.isEmpty) {
                        return 'Email mus\'nt be empty ';
                      }
                    },
                    labelText: 'Email',
                    hintText: 'Enter Your Email',
                    prefixIcon: Icons.email,
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress),
                const SizedBox(
                  height: 20.0,
                ),
                defaultTextFormField(
                    validate: (String? value) {
                      if(value!.isEmpty) {
                        return 'Password mus\'nt be empty ';
                      }
                    },
                    labelText: 'Password',
                    hintText: 'Enter Your Password',
                    prefixIcon: Icons.lock,
                    obscureText:cubit.obscureText,
                    suffixIcon: cubit.suffix,
                    onPressIcon:(){
                      cubit.eyePasswordChang();
                    },
                    controller: passwordController,
                    keyboardType: TextInputType.visiblePassword),
                const SizedBox(
                  height: 20.0,
                ),
                defaultTextFormField(
                    validate: (String? value) {
                      if(value!.isEmpty) {
                        return 'Phone mus\'nt be empty ';
                      }
                    },
                    labelText: 'Phone',
                    hintText: 'Enter Your Phone',
                    prefixIcon: Icons.phone,
                    controller: phoneController,
                    keyboardType: TextInputType.number),
                const SizedBox(
                  height: 20.0,
                ),
                if(state is LoadingRegisterState)
                  const Center(child: CircularProgressIndicator()),
                defaultTextButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        cubit.userRegister(
                            name: nameController.text,
                            email: emailController.text,
                            phone: phoneController.text,
                            password: passwordController.text);
                        ChatAppCubit.get(context).getUsers();
                         navigateAndRemove(context: context, widget:const HomeScreen());

                      }
                    },
                    text: 'REGISTER',
                    color: Colors.white,
                    textColor: Colors.black),
              ],
            ),
          ),
        );
      },
    );
  }
}
