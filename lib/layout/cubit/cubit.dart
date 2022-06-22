import 'package:bloc/bloc.dart';
import 'package:chats_app/layout/states/states.dart';
import 'package:chats_app/models/message_model.dart';
import 'package:chats_app/models/user_model.dart';
import 'package:chats_app/modules/login/login_screen.dart';
import 'package:chats_app/shared/component/component.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../shared/constante.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'dart:io';

class ChatAppCubit extends Cubit<ChatAppStates> {
  ChatAppCubit() : super(InitialAppState());

  static ChatAppCubit get(context) => BlocProvider.of(context);

  UserModel? userModel;
  List<MessageModel> messages = [];
  List<UserModel> users = [];

  var picker = ImagePicker();
  XFile? imageProfile;
  File? file;

  Future getImageProfile() async {
    final pickerFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickerFile != null) {
      imageProfile = XFile(pickerFile.path);
      file = File(imageProfile!.path);
      emit(GetImageProfileSuccessState());
    } else {
      print('No Image selected');
      emit(GetImageProfileErrorState());
    }
  }

  void upLoadImageProfile({
    required String name,
    required String bio,
    required String phone,
  }) {
    emit(LoadingUpDateImageProfileState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(imageProfile!.path).pathSegments.last}')
        .putFile(file!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        upDateUser(
          name: name,
          bio: bio,
          phone: phone,
          image: value == null ? userModel!.image : value,
        );
      }).catchError((error) {
        emit(UploadImageProfileErrorState());
      });
    }).catchError((error) {
      emit(UploadImageProfileErrorState());
    });
  }

  void upDateUser({
    required String name,
    required String bio,
    required String phone,
    String? image,
  }) {
    emit(LoadingUpDateImageProfileState());

    UserModel model = UserModel(
        name: name,
        email: userModel!.email,
        phone: phone,
        uId: userModel!.uId,
        image: image ?? userModel!.image,
        bio: bio);
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .update(model.toMap())
        .then((value) {
      getUserData();
    }).catchError((error) {
      emit(UpDateImageProfileErrorState());
    });
  }

  void getUsers() {
    if (users.length == 0) {
      FirebaseFirestore.instance.collection('users').get().then((value) {
        value.docs.forEach((element) {
          if (element.data()['uId'] != userModel!.uId) {
            users.add(UserModel.fromJson(element.data()));
          }
        });
      }).catchError((error) {
        emit(GetUserErrorState());
      });
    }
  }

  void getUserData()  {
    emit(LoadingGetUserState());

    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .get()
        .then((value) {
      userModel = UserModel.fromJson(value.data()!);
      print(userModel!.email);
      emit(GetUserSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetUserErrorState());
    });
  }

  void sendMessage({
     String? senderId,
    required String receiverId,
    required String dateTime,
    required String text,
  }) {
    MessageModel messageModel = MessageModel(
        senderId: userModel!.uId,
        receiverId: receiverId,
        dateTime: dateTime,
        text: text);
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .add(messageModel.toMap())
        .then((value) {
      emit(SendMessageSuccessState());
    }).catchError((error) {
      emit(SendMessageErrorState());
    });

    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc(userModel!.uId)
        .collection('messages')
        .add(messageModel.toMap())
        .then((value) {
      emit(SendMessageSuccessState());
    }).catchError((error) {
      emit(SendMessageErrorState());
    });
  }

  void getMessage({
    required String receiverId,
  }) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .orderBy('dateTime', descending: true)
        .snapshots()
        .listen((event) {
      messages = [];
      event.docs.forEach((element) {
        messages.add(MessageModel.fromJson(element.data()));
      });
      emit(GetMessageSuccessState());
    });
  }

  void searchUserByName(
      {required String name, String? message , String? phone})  {
    emit(LoadingSearchState());
     FirebaseFirestore.instance
        .collection('users').orderBy('name')
        .where('name', isLessThanOrEqualTo: name)
        .snapshots().listen((event) {

    });
     emit(SearchSuccessState());
  }

  Future<void> logOut(context) async {
    await FirebaseAuth.instance.signOut().then((value) {
      emit(SignOutSuccessState());
     navigateAndRemove(context: context, widget: LoginScreen());
    }).catchError((error) {
      emit(SignOutErrorState());
    });

  }


}
