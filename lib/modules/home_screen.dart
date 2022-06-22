import 'package:chats_app/layout/cubit/cubit.dart';
import 'package:chats_app/layout/states/states.dart';
import 'package:chats_app/models/user_model.dart';
import 'package:chats_app/modules/chat_screen.dart';
import 'package:chats_app/modules/login/cubit/states.dart';
import 'package:chats_app/modules/register/cubit/cubit.dart';
import 'package:chats_app/modules/register/cubit/states.dart';
import 'package:chats_app/modules/search_screen.dart';
import 'package:chats_app/modules/setting_screen.dart';
import 'package:chats_app/shared/component/component.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatAppCubit, ChatAppStates>(
      listener: (context, state) {
        if (state is UserLoginSuccessState) {
          ChatAppCubit.get(context).getUserData();
          ChatAppCubit.get(context).getUsers();
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.grey[400],
          appBar: AppBar(
            iconTheme: IconThemeData(
              color: Colors.white,
            ),
            backgroundColor: HexColor('#2B475E'),
            titleSpacing: 0.0,
            title: Row(
              children: [
                SizedBox(
                  width: 15.0,
                ),
                Text('Chat'),
                Spacer(),
                IconButton(
                    onPressed: () {
                      navigateTo(widget: SearchScreen(), context: context);
                    },
                    icon: Icon(Icons.search)),
                IconButton(
                    onPressed: () {
                      navigateTo(widget: SettingScreen(), context: context);
                    },
                    icon: Icon(Icons.more_vert)),
              ],
            ),
          ),
          body: ConditionalBuilder(
            condition: ChatAppCubit.get(context).users.isNotEmpty,
            builder: (context) {
              return ListView.separated(
                  itemBuilder: (context, index) =>
                      buildChatItem(ChatAppCubit.get(context).users[index] , context),
                  separatorBuilder: (context, index) => Container(
                        width: double.infinity,
                        height: 1.0,
                        color: Colors.grey,
                      ),
                  itemCount: ChatAppCubit.get(context).users.length);
            },
            fallback: (context) => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Center(
                  child: Text(
                    'Search about your friends',
                    style: TextStyle(fontSize: 20.0, color: Colors.grey),
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
                Center(
                  child: Image(
                    image: AssetImage('assets/images/app_icon.png'),
                    width: 150.0,
                    height: 150,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildChatItem(UserModel model, BuildContext context) => InkWell(
        onTap: () {
          navigateTo(widget: ChatScreen(userModel: model), context: context);
        },
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(model.image),
                radius: 40.0,
              ),
              SizedBox(
                width: 15.0,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      model.name,
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.bold),
                    ),
                    Text(
                        'sdsdsdsdsdsd',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis),
                  ],
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('5:30 pm'),
                  SizedBox(
                    height: 5.0,
                  ),
                  CircleAvatar(
                    backgroundColor: Colors.green,
                    child: Text(
                      '22',
                      style: TextStyle(color: Colors.white, fontSize: 10.0),
                    ),
                    radius: 10.0,
                  )
                ],
              ),
            ],
          ),
        ),
      );
}
