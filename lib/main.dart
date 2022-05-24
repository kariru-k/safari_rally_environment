// ignore_for_file: must_be_immutable, use_key_in_widget_constructors, empty_constructor_bodies, duplicate_ignore, unnecessary_this
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'auth/secrets.dart';
import 'screens/login_screen.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options:  FirebaseOptions(
      apiKey: apikey,
      appId: appID,
      messagingSenderId: messagingID,
      projectId: projectID,
    ),
  );
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: SplashScreen(duration: 3, goToPage: const LoginScreen()),
  ));
}

// ignore: use_key_in_widget_constructors
class IconFont extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return  Image.asset('assets/images/arc-logo.png');
  }
}

class SplashScreen extends StatelessWidget {
  int duration = 0;
  Widget goToPage;

  SplashScreen({ required this.goToPage, required this.duration});

  @override
  Widget build(BuildContext context){
    
    Future.delayed(Duration(seconds: this.duration), () {
      Navigator.push(context, MaterialPageRoute(builder: (context) => this.goToPage)
      );
    });
    return Scaffold(
      body: Container(
        color: Colors.black,
        alignment: Alignment.center,
        child: IconFont()
        ),
      );
  }
}





