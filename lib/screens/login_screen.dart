import 'package:cloudy_nota/controllers/google_auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:lottie/lottie.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF3F4E4F),
      appBar: AppBar(
        backgroundColor: const Color(0xFF2C3639),
        elevation: 0,
        title: const Text(
          'Cloudy Nota',
          style: TextStyle(
            color: Color(0xFFDCD7C9),
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Expanded(child: Container()),
            const Text(
              "Cloudy Nota where you can create and Manage your Notes",
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFFDCD7C9),
              ),
              textAlign: TextAlign.center,
            ),
            Expanded(child: Container()),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                height: 300,
                child: Lottie.asset(
                  "assets/lotties/note.json",
                ),
              ),
            ),
            Expanded(child: Container()),
            SignInButton(
              onPressed: () => GoogleAuthController.signInWithGoogle(context),
              Buttons.GoogleDark,
            ),
            Expanded(child: Container()),
          ],
        ),
      ),
    );
  }
}
