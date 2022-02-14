import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:clevertap_plugin/clevertap_plugin.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

const AndroidNotificationChannel notificationChannel =
    AndroidNotificationChannel('fluttertest', 'FlutterTest',
        importance: Importance.high, playSound: true);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('Handling a background message ${message.messageId}');
  print(message.data);
  print(message.data["wzrk_id"]);
  print(message.data["nt"]);
  print(message.data["nm"]);
  print("_firebaseMessagingBackgroundHandler");
  /*flutterLocalNotificationsPlugin.show(
      message.data.hashCode,
      message.data["nt"],
      message.data["nm"],
      NotificationDetails(
        android: AndroidNotificationDetails(
          notificationChannel.id,
          notificationChannel.name,
          importance: Importance.high,
          playSound: true,
          icon: '@mipmap/ic_launcher'
        ),
      ));*/


  callCTPlugin();
  CleverTapPlugin.createNotification(jsonEncode(message.data));
}

Future<void> initFirebaseForeground() async {
  await FirebaseMessaging.instance.getToken();
  FirebaseMessaging.onMessage.listen(receivedForegroundMessage);
}

void receivedForegroundMessage(RemoteMessage remoteMessage){
  print("Inside receivedForegroundMessage");
  callCTPlugin();
  CleverTapPlugin.createNotification(jsonEncode(remoteMessage.data));
}

void callCTPlugin() {
  print("Inside callCTPlugin");
  CleverTapPlugin _clevertapPlugin = CleverTapPlugin();
  _clevertapPlugin.setCleverTapPushClickedPayloadReceivedHandler(pushClickedPayloadReceivedHandler);
}

void pushClickedPayloadReceivedHandler(Map<String, dynamic> map){
  print("Inside pushClickedPayloadReceivedHandler");
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  /*await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(notificationChannel);*/




  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // late CleverTapPlugin _clevertapPlugin;
  int _counter = 0;
  String? token;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  void initState() {
    super.initState();
    /*var initialzationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettings =
    InitializationSettings(android: initialzationSettingsAndroid);
    flutterLocalNotificationsPlugin.initialize(initializationSettings);*/

    initPlatformState();
    // activateCleverTapFlutterPluginHandlers();
    // callCTPlugin();
    CleverTapPlugin.setDebugLevel(3);
    CleverTapPlugin.createNotificationChannel(
        "fluttertest", "Flutter Test", "Flutter Test", 3, true);


    FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
        alert: true, badge: true, sound: true);


    initFirebaseForeground();//Does the below function in this method.


    /*FirebaseMessaging.onMessage.listen((RemoteMessage message)  async {
      RemoteNotification? notification = message.notification;
      *//*AndroidNotification? android = message.notification?.android;
      // if (notification != null && android != null) {
      print(notification.hashCode);
      print(message.data["wzrk_id"]);*//*
      print(message.data["nt"]);
      print(message.data["nm"]);
      print("Inside onMessage");
      *//*flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            message.data["nt"],
            message.data["nm"],
            NotificationDetails(
              android: AndroidNotificationDetails(
                notificationChannel.id,
                notificationChannel.name,
                color: Colors.blue,
                importance: Importance.high,
                playSound: true,
                icon: '@mipmap/ic_launcher'
              ),
            ));*//*
      // callCTPlugin();
      *//*CleverTapPlugin _clevertapPlugin = CleverTapPlugin();
      _clevertapPlugin.setCleverTapPushClickedPayloadReceivedHandler(
          pushClickedPayloadReceived);*//*
      callCTPlugin();
      CleverTapPlugin.createNotification(jsonEncode(message.data));
      // }
    });
*/


    getToken();


    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print("Inside onMessageOpenedApp");
      // RemoteNotification? notification = message.notification;
      // AndroidNotification? android = message.notification?.android;
      // if (notification != null && android != null) {
        /*showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                title: Text(notification.title!),
                content: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Text(notification.body!)],
                  ),
                ),
              );
            });*/
        // activateCleverTapFlutterPluginHandlers();
        callCTPlugin();
        // CleverTapPlugin.createNotification(jsonEncode(message.data));
      // }
    });

    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) {
            print("Inside getInitialMessage()");
            // callCTPlugin();
            if (message != null) {
              print("Inside getInitialMessage()");
            }
    });


  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    if (!mounted) return;
  }

 /* void activateCleverTapFlutterPluginHandlers(){
    print("Inside activateCleverTapFlutterPluginHandlers");
    _clevertapPlugin = CleverTapPlugin();
    _clevertapPlugin.setCleverTapPushClickedPayloadReceivedHandler(
        pushClickedPayloadReceived);
  }*/

  void pushClickedPayloadReceived(Map<String, dynamic> map) {
    print("Inside pushClickedPayloadReceived called");
    setState(() async {
      var data = jsonEncode(map);
      print("on Push Click Payload = " + data.toString());
    });
  }

  /*void callCTPlugin1(){
    print("Inside callCTPlugin1");
    CleverTapPlugin _clevertapPlugin1 = CleverTapPlugin();
    _clevertapPlugin1.setCleverTapPushClickedPayloadReceivedHandler(pushClickedPayloadReceivedForegroundHandler);
  }*/
  /*void pushClickedPayloadReceivedForegroundHandler(Map<String, dynamic> map){
    print("Inside pushClickedPayloadReceivedForegroundHandler");
    setState(() async {
          var data = jsonEncode(map);
          print("on Push Click Payload = " + data.toString());
    });
  }*/

  void showNotification() {
    setState(() {
      _counter++;
    });
    /*flutterLocalNotificationsPlugin.show(
        0,
        "Testing Local Notification$_counter",
        "How you doin ?",
        NotificationDetails(
            android: AndroidNotificationDetails(notificationChannel.id, notificationChannel.name,
                importance: Importance.high,
                color: Colors.blue,
                playSound: true,
                icon: '@mipmap/ic_launcher')));*/
  }

  getToken() async {
    token = await FirebaseMessaging.instance.getToken();
    setState(() {
      token = token;
    });
    print(token);
  }

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
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: showNotification,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
