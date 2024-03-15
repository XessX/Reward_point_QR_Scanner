
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:reward_app/screens/login_page.dart';
import 'package:reward_app/screens/main_page.dart';

import '../widgets/toast.dart';


class AuthChecker extends StatelessWidget {
  const AuthChecker({super.key});

  @override
  Widget build(BuildContext context) {

    return StreamBuilder<User?>(stream: FirebaseAuth.instance.authStateChanges(), builder: (context, snapshot) {
      if(snapshot.connectionState == ConnectionState.waiting){
        return CircularProgressIndicator();
      }
      else if(snapshot.hasData){
       return MainPage();
      }
      else if(snapshot.hasError){
        /// Todo Error widget
        return Text('Error occured!');
      }
      else{
        return LoginPage();
      }
    });
  }
}
