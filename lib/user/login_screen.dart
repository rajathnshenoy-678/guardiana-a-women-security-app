import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:guardiana/components/PrimaryButton.dart';
import 'package:guardiana/components/SecondaryButton.dart';
import 'package:guardiana/components/custom_textfield.dart';
import 'package:guardiana/db/shared-pref.dart';
import 'package:guardiana/guardian/guardian_home_screen.dart';
import 'package:guardiana/user/bottom_page.dart';
import 'package:guardiana/user/bottom_page/home_screen.dart';
import 'package:guardiana/guardian/register_guardian.dart';
import 'package:guardiana/user/register_user.dart';
import 'package:guardiana/utils/constants.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isPasswordShown = true;
  final _formKey = GlobalKey<FormState>();
  final _formData = Map<String, Object>();

  _onSubmit() async {
    try {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();

        // ignore: unused_local_variable
        UserCredential userCredential =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _formData['email'].toString(),
          password: _formData['password'].toString(),
        );

        // Fetch user data from Firestore
        FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.user!.uid)
            .get()
            .then((value) {
          if (value.exists) {
            // User data found in Firestore
            if (value['type'] == 'parent') {
              print(value['type']);
              MySharedPreferences.saveUserType('parent');
              goTo(context, GuardianHomeScreen());
            } else {
              MySharedPreferences.saveUserType('user');
              goTo(context,BottomPage());
            }
          } else {
            // User data not found in Firestore
            print('User data not found in Firestore');
            // You may want to handle this case based on your application's requirements
          }
        });
      }
    } on FirebaseAuthException catch (e) {
      // Authentication failed, show an alert box
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Authentication Failed"),
            content: Text("Please register first."),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("OK"),
              ),
            ],
          );
        },
      );
      print("Authentication failed: ${e.message}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 250, 128, 169),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: 50,
                ),
                Icon(
                  Icons.lock_person,
                  size: 100,
                  color: Colors.white,
                ),
                SizedBox(
                  height: 50,
                ),
                Text(
                  "USER LOGIN",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 25),
                Container(
                  height: MediaQuery.of(context).size.height *
                      0.6, // Adjusted height
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CustomtextField(
                          hintText: "Enter Email",
                          textInputAction: TextInputAction.next,
                          keyboardtype: TextInputType.emailAddress,
                          prefix: Icon(Icons.person),
                          onsave: (email) {
                            _formData['email'] = email ?? "";
                          },
                          validate: (email) {
                            if (email!.isEmpty ||
                                email.length < 3 ||
                                !email.contains("@")) {
                              return "Enter correct email";
                            } else {
                              return null;
                            }
                          },
                        ),
                        CustomtextField(
                          hintText: "Enter Password",
                          isPassword: isPasswordShown,
                          prefix: Icon(Icons.password_rounded),
                          onsave: (password) {
                            _formData['password'] = password ?? "";
                          },
                          validate: (password) {
                            if (password!.isEmpty || password.length < 7) {
                              return "Enter correct password";
                            }
                            return null;
                          },
                          suffix: IconButton(
                            onPressed: () {
                              setState(() {
                                isPasswordShown = !isPasswordShown;
                              });
                            },
                            icon: isPasswordShown
                                ? Icon(Icons.visibility_off)
                                : Icon(Icons.visibility),
                          ),
                        ),
                        PrimaryButton(
                          title: "LOGIN",
                          onPressed: () {
                            if (_formKey.currentState!.validate()) _onSubmit();
                          },
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Forgot Password?",
                              style: TextStyle(fontSize: 18),
                            ),
                            SecondaryButton(
                              title: "Click Here",
                              onPressed: () {},
                            ),
                          ],
                        ),
                        SecondaryButton(
                          title: "REGISTER AS USER",
                          onPressed: () {
                            goTo(context, RegisterUserpage());
                          },
                        ),
                        SecondaryButton(
                          title: "REGISTER AS GUARDIAN",
                          onPressed: () {
                            goTo(context, RegisterGuardianpage());
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
