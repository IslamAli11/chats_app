import 'package:chats_app/layout/cubit/cubit.dart';
import 'package:chats_app/layout/states/states.dart';
import 'package:chats_app/modules/register/cubit/cubit.dart';
import 'package:chats_app/modules/register/cubit/states.dart';
import 'package:chats_app/shared/component/component.dart';
import 'package:chats_app/shared/constante.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:cross_file_image/cross_file_image.dart';

class SettingScreen extends StatelessWidget {
  SettingScreen({Key? key}) : super(key: key);
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController imageController = TextEditingController();
  TextEditingController bioController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatAppCubit, ChatAppStates>(
      listener: (context, state) {
      if(state is RegisterSuccessState){
        ChatAppCubit.get(context).getUserData();
      }
      },
      builder: (context, state) {
        var userModel = ChatAppCubit.get(context).userModel;
        var imageProfile = ChatAppCubit.get(context).imageProfile;

        nameController.text = userModel!.name;
        phoneController.text = userModel.phone;
        imageController.text = userModel.image;
        bioController.text = userModel.bio;

        return Scaffold(
          backgroundColor: backgroundColor,
          appBar: AppBar(
            backgroundColor: backgroundColor,
            elevation: 0.0,
          ),
          body: ChatAppCubit.get(context).userModel!=null
              ? ListView(
                  padding: const EdgeInsets.all(20.0),
                  children: [
                    Center(
                      child: Stack(
                        alignment: AlignmentDirectional.bottomEnd,
                        children: [
                          CircleAvatar(
                            radius: 65.0,
                            backgroundImage: imageProfile == null
                                ? NetworkImage('${userModel.image}')
                                : XFileImage(imageProfile) as ImageProvider,
                          ),
                          IconButton(
                              onPressed: () {
                                ChatAppCubit.get(context).getImageProfile();
                              },
                              icon: const CircleAvatar(
                                radius: 20.0,
                                child:
                                    Icon(Icons.camera_alt_rounded, size: 18.0),
                              )),
                        ],
                      ),
                    ),
                    if (state is LoadingUpDateImageProfileState)
                      const Center(child: CircularProgressIndicator()),
                    if (imageProfile != null)
                      SizedBox(
                        height: 25.0,
                      ),
                    if (imageProfile != null)
                      defaultTextButton(
                        text: 'UpDate Image',
                        color: Colors.blue,
                        textColor: Colors.white,
                        onPressed: () {
                          ChatAppCubit.get(context).upLoadImageProfile(
                            name: nameController.text,
                            bio: bioController.text,
                            phone: phoneController.text,
                          );
                        },
                      ),
                    SizedBox(
                      height: 25.0,
                    ),
                    defaultTextFormField(
                        labelText: 'Name',
                        prefixIcon: Icons.person,
                        controller: nameController,
                        keyboardType: TextInputType.text),
                    const SizedBox(
                      height: 15.0,
                    ),
                    defaultTextFormField(
                        labelText: 'Phone',
                        prefixIcon: Icons.phone,
                        controller: phoneController,
                        keyboardType: TextInputType.name),
                    const SizedBox(
                      height: 15.0,
                    ),
                    defaultTextFormField(
                        labelText: 'Bio',
                        prefixIcon: Icons.text_format,
                        controller: bioController,
                        keyboardType: TextInputType.text),
                    const SizedBox(
                      height: 15.0,
                    ),
                    Row(
                      children: [
                        // if(state is LoadingUpDateImageProfileState)
                        //  const Center(child: CircularProgressIndicator()),
                        Expanded(
                          child: defaultTextButton(
                            color: Colors.blue,
                            textColor: Colors.white,
                            text: 'UpDate',
                            onPressed: () {
                              ChatAppCubit.get(context).upDateUser(
                                name: nameController.text,
                                bio: bioController.text,
                                phone: phoneController.text,

                              );
                            },
                          ),
                        ),
                        const SizedBox(
                          width: 5.0,
                        ),
                        Expanded(
                          child: defaultTextButton(
                            color: Colors.blue,
                            textColor: Colors.white,
                            text: 'Log Out',
                            onPressed: () {
                              ChatAppCubit.get(context).logOut(context);
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ):const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
