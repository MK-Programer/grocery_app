import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/fetch_screen_data.dart';
import 'package:grocery_app/screens/auth/register_screen.dart';
import 'package:grocery_app/screens/loading_manager.dart';
import 'package:grocery_app/services/global_methods.dart';
import 'package:grocery_app/widgets/text_widget.dart';

import '../../consts/firebase_consts.dart';
import '../../widgets/auth_button.dart';
import '../../widgets/google_button.dart';
import 'auth_helper.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();
  final _passFocusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();
  bool _obsecureText = true;

  @override
  void dispose() {
    _emailTextController.dispose();
    _passwordTextController.dispose();
    _passFocusNode.dispose();
    super.dispose();
  }

  final user = authInstance.currentUser;
  bool _isLoading = false;
  void _submitFormOnLogin() async {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {
      _formKey.currentState!.save();
      setState(() => _isLoading = true);

      try {
        await authInstance.signInWithEmailAndPassword(
          email: _emailTextController.text.toLowerCase().trim(),
          password: _passwordTextController.text.trim(),
        );
        print('Successfully logged in');
        // ignore: use_build_context_synchronously
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => const FetchScreen(),
          ),
          (route) => false,
        );
      } on FirebaseException catch (error) {
        setState(() => _isLoading = false);
        GlobalMethods.errorDialog(
            subTitle: "${error.message}", context: context);
      } catch (error) {
        setState(() => _isLoading = false);
        GlobalMethods.errorDialog(subTitle: "$error", context: context);
      } finally {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoadingManager(
        isLoading: _isLoading,
        child: Stack(
          children: [
            const AuthCarousel(),
            Container(
              color: Colors.black.withOpacity(0.7),
            ),
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const SizedBox(
                      height: 120.0,
                    ),
                    TextWidget(
                      text: "Welcome Back",
                      color: Colors.white,
                      textSize: 30.0,
                      isTitle: true,
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    TextWidget(
                      text: "Sign in to continue",
                      color: Colors.white,
                      textSize: 18.0,
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            textInputAction: TextInputAction.next,
                            onEditingComplete: () => FocusScope.of(context)
                                .requestFocus(_passFocusNode),
                            controller: _emailTextController,
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value!.isEmpty || !value.contains("@")) {
                                return "Please, enter a valid email address";
                              } else {
                                return null;
                              }
                            },
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                            decoration: AuthInputStyle.authInputDecoration
                                .copyWith(hintText: "Email"),
                          ),
                          const SizedBox(
                            height: 12.0,
                          ),
                          TextFormField(
                            textInputAction: TextInputAction.done,
                            onEditingComplete: () {
                              _submitFormOnLogin();
                            },
                            controller: _passwordTextController,
                            focusNode: _passFocusNode,
                            obscureText: _obsecureText,
                            keyboardType: TextInputType.visiblePassword,
                            validator: (value) {
                              if (value!.isEmpty || value.length < 7) {
                                return "Please, enter a valid password";
                              } else {
                                return null;
                              }
                            },
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                            decoration:
                                AuthInputStyle.authInputDecoration.copyWith(
                              hintText: "Password",
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  setState(
                                    () {
                                      _obsecureText = !_obsecureText;
                                      print(_obsecureText);
                                    },
                                  );
                                },
                                child: Icon(
                                  _obsecureText
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    const ForgetPasswordButton(),
                    const SizedBox(
                      height: 10.0,
                    ),
                    AuthButton(
                      fct: () {
                        _submitFormOnLogin();
                      },
                      buttonText: "Sign in",
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    const GoogleButton(),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      children: [
                        const Expanded(
                          child: Divider(
                            color: Colors.white,
                            thickness: 2.0,
                          ),
                        ),
                        const SizedBox(
                          width: 5.0,
                        ),
                        TextWidget(
                          text: "OR",
                          color: Colors.white,
                          textSize: 18.0,
                        ),
                        const SizedBox(
                          width: 5.0,
                        ),
                        const Expanded(
                          child: Divider(
                            color: Colors.white,
                            thickness: 2.0,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    AuthButton(
                      fct: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const FetchScreen(),
                          ),
                        );
                      },
                      buttonText: "Continue as a guest",
                      primary: Colors.black,
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    RichText(
                      text: TextSpan(
                        text: "Don't have an account?",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                        ),
                        children: [
                          TextSpan(
                            text: "  Sign up",
                            style: const TextStyle(
                              color: Colors.lightBlue,
                              fontSize: 18.0,
                              fontWeight: FontWeight.w600,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                GlobalMethods.navigateTo(
                                  ctx: context,
                                  routeName: RegisterScreen.routeName,
                                );
                              },
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
