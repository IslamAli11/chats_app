import 'package:chats_app/layout/cubit/cubit.dart';
import 'package:chats_app/layout/states/states.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/user_model.dart';
import '../shared/constante.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchController = TextEditingController();

  Stream? userStream;

  onSearchButton() async {
     ChatAppCubit.get(context).searchUserByName(
      name: searchController.text,
    );
    print(userStream.toString());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatAppCubit, ChatAppStates>(
      listener: (context, state) => {},
      builder: (context, state) {
        var cubit = ChatAppCubit.get(context);
        return Scaffold(
          backgroundColor: Colors.grey[400],
          appBar: AppBar(
            backgroundColor: backgroundColor,
            title: Container(
              width: double.infinity,
              child: TextFormField(
                onFieldSubmitted: (value) {
                  onSearchButton();
                  print(value);
                },
                controller: searchController,
                decoration: InputDecoration(
                  hintText: 'Find your friends...... ',
                  border: InputBorder.none,
                  hintStyle: TextStyle(color: Colors.white),


                ),
                style: TextStyle(
                  color: Colors.white
                ),
              ),
            ),
          ),
          body: searchUserList(),
        );
      },
    );
  }

  Widget searchItem(UserModel model) =>
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.name,
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  ),

                ],
              ),
            ),

            CircleAvatar(
              radius: 28.0,
              child: Image.asset(model.image),
            )
          ],
        ),
      );

  Widget searchUserList() {
    return StreamBuilder(
        stream: userStream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot ds = snapshot.data.docs[index];
                    return searchItem(snapshot.data!.docs[index]);
                  })
              : const Center(child: CircularProgressIndicator());
        });
  }
}
