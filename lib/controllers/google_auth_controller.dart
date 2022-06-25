import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloudy_nota/screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleAuthController {
  static final GoogleSignIn googleSignIn = GoogleSignIn();
  static final FirebaseAuth auth = FirebaseAuth.instance;
  static final CollectionReference users =
      FirebaseFirestore.instance.collection('users');

  static void signInWithGoogle(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();

      if (googleSignInAccount != null) {
        // take users important data to store it locally
        var userData = {
          'name': googleSignInAccount.displayName,
          'provider': 'google',
          'photoUrl': googleSignInAccount.photoUrl,
          'email': googleSignInAccount.email,
        };

        // authticate and fetching the access_token and id_token
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        // take google auth credntials to create the new user
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );

        // sign in to firebase with the google auth credntials u got by the provider
        final UserCredential authResult =
            await auth.signInWithCredential(credential);

        // get the user from authReulst
        final User? user = authResult.user;

        // check user collection if haveing this user_id or not
        // if exists updates userData
        // if not add this data
        if (user != null) {
          users.doc(user.uid).get().then(
            (doc) {
              doc.exists
                  ? doc.reference.update(userData)
                  : users.doc(user.uid).set(userData);

              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => HomeScreen(),
                ),
              );
            },
          );
        }
      }
    } catch (err) {
      if (kDebugMode) {
        print(err);
        print("Can't Sign In Successfully");
      }
    }
  }
}
