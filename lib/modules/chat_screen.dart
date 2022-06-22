import 'package:chat_bubbles/bubbles/bubble_normal_audio.dart';
import 'package:chat_bubbles/bubbles/bubble_special_three.dart';
import 'package:chats_app/layout/cubit/cubit.dart';
import 'package:chats_app/layout/states/states.dart';
import 'package:chats_app/models/message_model.dart';
import 'package:chats_app/models/user_model.dart';
import 'package:chats_app/shared/constante.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';

class ChatScreen extends StatelessWidget {
  final UserModel userModel;
  ChatScreen({Key? key, required this.userModel}) : super(key: key);
  TextEditingController messageController = TextEditingController();
  var scrollController = ScrollController();

  void scrollEndOfListView(){

    scrollController.position.animateTo(
      0,
      duration:  const Duration(seconds: 1),
      curve: Curves.fastOutSlowIn,
    );

  }



  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        ChatAppCubit.get(context).getMessage(receiverId: userModel.uId);
        return BlocConsumer<ChatAppCubit, ChatAppStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return Scaffold(
              backgroundColor: Colors.grey[400],
              appBar: AppBar(
                titleSpacing: 0.0,
                backgroundColor: backgroundColor,
                title: Row(
                  children: [
                    CircleAvatar(
                      radius: 25.0,
                      backgroundImage: NetworkImage(userModel.image),
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                    Text(
                      userModel.name,
                      style: const TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
              body: ConditionalBuilder(
                condition: true,
                builder: (context) => Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.separated(
                          reverse: true,
                          controller: scrollController,
                          itemBuilder: (context, index) {
                            var message =
                                ChatAppCubit.get(context).messages[index];
                            if (ChatAppCubit.get(context).userModel!.uId ==
                                message.senderId) {
                              return senderMessage(message);
                            }
                            return receiverMessage(message);
                          },
                          separatorBuilder: (context, index) => const SizedBox(
                            height: 15.0,
                          ),
                          itemCount: ChatAppCubit.get(context).messages.length,
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadiusDirectional.circular(10.0),
                            border: Border.all(color: Colors.grey)),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              child: TextField(
                                controller: messageController,
                                keyboardType: TextInputType.text,
                                decoration: const InputDecoration(
                                  hintText: 'send your message ...',
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                            if(messageController.text=='')
                            IconButton(
                              onPressed: () {
                                ChatAppCubit.get(context).sendMessage(
                                text: messageController.text,
                                receiverId: userModel.uId,
                                dateTime: DateTime.now().toString(),
                              );
                                messageController.clear();
                                scrollEndOfListView();
                              },
                              icon: const Icon(
                                Icons.send,
                                color: Colors.blue,
                                size: 30.0,
                              ),
                            ),

                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                fallback: (context) =>
                    const Center(child: CircularProgressIndicator()),
              ),
            );
          },
        );
      },
    );
  }

  Widget receiverMessage(MessageModel model) => Align(
        alignment: AlignmentDirectional.centerStart,
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: 5.0,
            horizontal: 10.0,
          ),
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: const BorderRadiusDirectional.only(
                topStart: Radius.circular(10.0),
                topEnd: Radius.circular(10.0),
                bottomEnd: Radius.circular(10.0)),
          ),
          child: Text(model.text),
        ),
      );

  Widget senderMessage(MessageModel model) => Align(
        alignment: AlignmentDirectional.centerEnd,
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: 5.0,
            horizontal: 10.0,
          ),
          decoration: BoxDecoration(
            color: Colors.blue[100],
            borderRadius: const BorderRadiusDirectional.only(
              topStart: Radius.circular(10.0),
              topEnd: Radius.circular(10.0),
              bottomStart: Radius.circular(10.0),
            ),
          ),
          child: Text(
            model.text,
            style: const TextStyle(color: Colors.black),
          ),
        ),
      );
}
