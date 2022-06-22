import 'package:bloc/bloc.dart';
import 'package:chats_app/layout/cubit/cubit.dart';
import 'package:chats_app/modules/home_screen.dart';
import 'package:chats_app/modules/login/cubit/cubit.dart';
import 'package:chats_app/modules/login/login_screen.dart';
import 'package:chats_app/modules/register/cubit/cubit.dart';
import 'package:chats_app/shared/bloc_observer.dart';
import 'package:chats_app/shared/constante.dart';
import 'package:chats_app/shared/network/local/shared_preference.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Widget widget = Container(
    width: double.infinity,
    height: double.infinity,
  );

  await CacheHelper.init();
  uId = CacheHelper.getData(key: 'uId');
  if (uId != null) {
    widget = HomeScreen();
  } else {
    widget = LoginScreen();
  }
  BlocOverrides.runZoned(
    () {
      runApp(
        MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => RegisterCubit(),
            ),
            BlocProvider(
              create: (context) => LoginCubit(),
            ),
            BlocProvider(
                create: (context) => ChatAppCubit()
                  ..getUserData()
                  ..getUsers()
            ),
          ],
          child:  ChatApp(
            startWidget: widget,
          ),
        )
      );
    },
    blocObserver: SimpleBlocObserver(),
  );
  print(uId);
}

class ChatApp extends StatelessWidget {
  final Widget startWidget;

  const ChatApp({Key? key, required this.startWidget}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          appBarTheme: const AppBarTheme(
              iconTheme: IconThemeData(
                color: Colors.white,
              ))),
      home: startWidget,
    );
  }
}
