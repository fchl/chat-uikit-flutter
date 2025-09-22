// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:tencent_cloud_chat_sdk/enum/V2TimSDKListener.dart';
import 'package:tencent_cloud_chat_sdk/enum/log_level_enum.dart';

import 'package:tencent_cloud_chat_sdk/models/v2_tim_conversation.dart'
if (dart.library.html) 'package:tencent_cloud_chat_sdk/web/compatible_models/v2_tim_conversation.dart';

import 'package:tencent_cloud_chat_sdk/tencent_im_sdk_plugin.dart';
import 'package:tencent_cloud_chat_uikit/tencent_cloud_chat_uikit.dart';

import 'TIMUIKitAddFriendExample.dart';
import 'TIMUIKitAddGroupExample.dart';
import 'TIMUIKitBlackListExample.dart';
import 'TIMUIKitChatExample.dart';
import 'TIMUIKitContactExample.dart';
import 'TIMUIKitConversationExample.dart';
import 'TIMUIKitGroupExample.dart';
import 'TIMUIKitGroupProfileExample.dart';
import 'TIMUIKitNewContactExample.dart';
import 'TIMUIKitProfileExample.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tencent IM UIKit',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Tencent Cloud Chat UIKit'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    _checkIfConnected();
  }

  CoreServicesImpl timCoreInstance = TIMUIKitCore.getInstance();

  int getSDKAPPID() {
    return const int.fromEnvironment('SDK_APPID', defaultValue: 1400538265);
  }

  String getUserID() {
    return const String.fromEnvironment('LOGINUSERID', defaultValue: "fchl");
   // return const String.fromEnvironment('LOGINUSERID', defaultValue: "J82");
    // return const String.fromEnvironment('LOGINUSERID', defaultValue: "J71");
    return const String.fromEnvironment('LOGINUSERID', defaultValue: "jack");
  }

  String getSecret() {
    return const String.fromEnvironment('SECRET', defaultValue: "998db5d97b0b019ceac4e53d5908d8f98b9b53d5a242bc78938d24650424115a");
  }

  String getUsersig() {
    return const String.fromEnvironment('USERSIG', defaultValue: "eJwtzE0LgkAUheH-MttCbzNzRxFa1SIslLAWgRtxxrpMfqBDBNF-z9TleQ68H3Y5Zd7L9Cxi3AO2njZp0ziqaOKqfDwXH7Qtuo40izYSAEXIFc6PeXfUm9ERkQPArI7qvwUYiiAMlFwqdB*zhoayamWW*wfYX2-HlRJYxE7Y*LxrEiwoGercT9sUrJFb9v0BO*8xCQ__");
  }

  Future<void> _checkIfConnected() async {
    final res = await TencentImSDKPlugin.v2TIMManager.getLoginUser();
    debugPrint("getLoginUser ${res.data}");
    if (res.data != null && res.data!.isNotEmpty) {
      return;
    } else if (res.data == null || res.data!.isEmpty) {
      await initTIMUIKIT();

      return;
    } else if (res.data!.isEmpty) {

      return;
    } else {
      return;
    }
  }

  initTIMUIKIT() async {
    int sdkappid = getSDKAPPID();
    String userid = getUserID();
    String secret = getSecret();
    String usersig = getUsersig();
    if (sdkappid == 0 || userid == '' || secret == '' || usersig == '') {
      print("The running parameters are abnormal, please check");
      return;
    }
    debugPrint("timCoreInstance init ");
    await timCoreInstance.init(
      sdkAppID: sdkappid,
      loglevel: LogLevelEnum.V2TIM_LOG_DEBUG,
      listener: V2TimSDKListener(
        onConnectFailed: (code, error) {
          debugPrint("tim  failed ${code}  error ${error}");
        },
        onConnectSuccess: () {
          debugPrint('tim  初始化成功 ');


        },
        onConnecting: () {
          debugPrint('tim  onConnecting ');
        },
        onKickedOffline: () {
          debugPrint('tim  onKickedOffline ');
        },
        onUserSigExpired: () {
          debugPrint('tim  onUserSigExpired ');
        },
      ),
    );
    var res =
        await timCoreInstance.login(userID: userid, userSig: usersig);
    debugPrint("timCoreInstance  login ");
    print(
        "Log in to Tencent Cloud Instant Messaging IM Return：${res.toJson()}");
  }

  getAPIWidget(String apiName) {
    var userId = "J82";
    switch (apiName) {
      case 'TIMUIKitConversation':
        return const TIMUIKitConversationExample();
      case 'TIMUIKitChat':

        return   TIMUIKitChatExample(selectedConversation: V2TimConversation(
            conversationID: "c2c_$userId",
            userID: userId,
            showName: "你的昵称",
            type: 1),);
      case 'TIMUIKitProfile':
        return TIMUIKitProfileExample(userID: userId,);
      case 'TIMUIKitAddFriend':
        return const TIMUIKitAddFriendExample();
      case 'TIMUIKitAddGroup':
        return const TIMUIKitAddGroupExample();
      case 'TIMUIKitBlackList':
        return const TIMUIKitBlackListExample();
      case 'TIMUIKitContact':
        return const TIMUIKitContactExample();
      case 'TIMUIKitGroup':
        return const TIMUIKitGroupExample();
      case 'TIMUIKitGroupProfile':
        return const TIMUIKitGroupProfileExample();
      case 'TIMUIKitNewContact':
        return const TIMUIKitNewContactExample();

    }
  }

  openExamplePage(String apiName) {
    if (apiConfig.contains(apiName)) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Scaffold(
            appBar: AppBar(
              title: Text(apiName),
            ),
            body: getAPIWidget(apiName),
          ),
        ),
      );
    } else {
      print("no such ket");
    }
  }

  List<String> apiConfig = [
    "TIMUIKitConversation",
    "TIMUIKitChat",
    "TIMUIKitProfile",
    "TIMUIKitAddFriend",
    "TIMUIKitAddGroup",
    "TIMUIKitBlackList",
    "TIMUIKitContact",
    "TIMUIKitGroup",
    "TIMUIKitGroupProfile",
    "TIMUIKitNewContact",
    "TIMUIKitSearch"
  ];
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Center(
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          child: Column(
            children: apiConfig
                .map(
                  (e) => Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            openExamplePage(e);
                          },
                          child: Text(e,style: TextStyle(color: Colors.red),),
                        ),
                      )
                    ],
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }
}
