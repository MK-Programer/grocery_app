import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/fetch_screen_data.dart';
import 'package:grocery_app/services/global_methods.dart';
import 'package:grocery_app/widgets/back_widget.dart';
import 'package:grocery_app/widgets/text_widget.dart';

import '../../consts/firebase_consts.dart';
import '../../widgets/auth_button.dart';
import '../loading_manager.dart';
import 'auth_helper.dart';

class RegisterScreen extends StatefulWidget {
  static const routeName = "/RegisterScreen";
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _fullNameTextController = TextEditingController();
  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();
  final _addressTextController = TextEditingController();
  final _passFocusNode = FocusNode();
  final _emailFocusNode = FocusNode();
  final _addressFocusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();
  bool _obsecureText = true;

  @override
  void dispose() {
    _fullNameTextController.dispose();
    _emailTextController.dispose();
    _passwordTextController.dispose();
    _addressTextController.dispose();
    _passFocusNode.dispose();
    _emailFocusNode.dispose();
    _addressFocusNode.dispose();
    super.dispose();
  }

  bool _isLoading = false;
  void _submitFormOnRegister() async {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {
      setState(() => _isLoading = true);
      _formKey.currentState!.save();
      try {
        await authInstance.createUserWithEmailAndPassword(
          email: _emailTextController.text.toLowerCase().trim(),
          password: _passwordTextController.text.trim(),
        );
        final user = authInstance.currentUser;
        final uid = user?.uid;
        user!.updateDisplayName(_fullNameTextController.text);
        user.reload();
        await FirebaseFirestore.instance.collection('users').doc(uid).set({
          'id': uid,
          'name': _fullNameTextController.text,
          'email': _emailTextController.text.toLowerCase(),
          'shippingAddress': _addressTextController.text,
          'userWish': [],
          'userCart': [],
          'createdAt': Timestamp.now(),
        });
        print('Successfully registered');
        // ignore: use_build_context_synchronously
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const FetchScreen(),
          ),
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const SizedBox(
                      height: 60.0,
                    ),
                    const BackWidget(
                      colorPassed: Colors.white,
                    ),
                    const SizedBox(
                      height: 40.0,
                    ),
                    TextWidget(
                      text: "Welcome",
                      color: Colors.white,
                      textSize: 30.0,
                      isTitle: true,
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    TextWidget(
                      text: "Sign up to continue",
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
                                .requestFocus(_emailFocusNode),
                            controller: _fullNameTextController,
                            keyboardType: TextInputType.name,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "This field is missing";
                              } else {
                                return null;
                              }
                            },
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                            decoration: AuthInputStyle.authInputDecoration
                                .copyWith(hintText: "Full name"),
                          ),
                          const SizedBox(
                            height: 12.0,
                          ),
                          TextFormField(
                            focusNode: _emailFocusNode,
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
                            textInputAction: TextInputAction.next,
                            onEditingComplete: () => FocusScope.of(context)
                                .requestFocus(_addressFocusNode),
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
                          const SizedBox(
                            height: 12.0,
                          ),
                          TextFormField(
                            focusNode: _addressFocusNode,
                            textInputAction: TextInputAction.done,
                            onEditingComplete: () {
                              _submitFormOnRegister();
                            },
                            controller: _addressTextController,
                            validator: (value) {
                              if (value!.isEmpty || value.length < 10) {
                                return "Please, enter a valid address";
                              } else {
                                return null;
                              }
                            },
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                            maxLines: 2,
                            textAlign: TextAlign.start,
                            decoration: AuthInputStyle.authInputDecoration
                                .copyWith(hintText: "Shipping address"),
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
                        _submitFormOnRegister();
                      },
                      buttonText: "Sign up",
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    RichText(
                      text: TextSpan(
                        text: "Already have an account?",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                        ),
                        children: [
                          TextSpan(
                            text: "  Sign in",
                            style: const TextStyle(
                              color: Colors.lightBlue,
                              fontSize: 18.0,
                              fontWeight: FontWeight.w600,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.canPop(context)
                                    ? Navigator.of(context).pop()
                                    : null;
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
