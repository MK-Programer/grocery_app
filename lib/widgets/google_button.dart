import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/consts/firebase_consts.dart';
import 'package:grocery_app/fetch_screen_data.dart';
import 'package:grocery_app/widgets/text_widget.dart';

import '../services/global_methods.dart';

class GoogleButton extends StatelessWidget {
  const GoogleButton({Key? key}) : super(key: key);

  Future<void> _googleSignIn(BuildContext context) async {
    // final googleSignIn = GoogleSignIn();
    // googleSignIn.signOut();
    final googleAccount = await googleSignIn.signIn();
    if (googleAccount != null) {
      final googleAuth = await googleAccount.authentication;
      if (googleAuth.accessToken != null && googleAuth.idToken != null) {
        try {
          final authResult = await authInstance.signInWithCredential(
            GoogleAuthProvider.credential(
              idToken: googleAuth.idToken,
              accessToken: googleAuth.accessToken,
            ),
          );
          if (authResult.additionalUserInfo!.isNewUser) {
            await FirebaseFirestore.instance
                .collection('users')
                .doc(authResult.user!.uid)
                .set({
              'id': authResult.user!.uid,
              'name': authResult.user!.displayName,
              'email': authResult.user!.email,
              'shippingAddress': '',
              'userWish': [],
              'userCart': [],
              'createdAt': Timestamp.now(),
            });
          }
          // ignore: use_build_context_synchronously
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => const FetchScreen(),
            ),
            ((route) => false),
          );
        } on FirebaseException catch (error) {
          GlobalMethods.errorDialog(
              subTitle: "${error.message}", context: context);
        } catch (error) {
          GlobalMethods.errorDialog(subTitle: "$error", context: context);
        } finally {}
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _googleSignIn(context);
      },
      child: Material(
        color: Colors.blue,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              color: Colors.white,
              child: Image.asset(
                "assets/images/google.png",
                width: 40.0,
              ),
            ),
            const SizedBox(
              width: 8.0,
            ),
            TextWidget(
              text: "Sign in with google",
              color: Colors.white,
              textSize: 18.0,
            ),
          ],
        ),
      ),
    );
  }
}
