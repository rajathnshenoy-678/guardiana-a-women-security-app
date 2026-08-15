import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:guardiana/components/PrimaryButton.dart';
import 'package:guardiana/components/SecondaryButton.dart';
import 'package:guardiana/components/custom_textfield.dart';
import 'package:guardiana/model/user_model.dart';
import 'package:guardiana/user/login_screen.dart';
import 'package:guardiana/utils/constants.dart';

class RegisterGuardianpage extends StatefulWidget {
  @override
  State<RegisterGuardianpage> createState() => _RegisterUserpageState();
}

class _RegisterUserpageState extends State<RegisterGuardianpage> {
  bool isPasswordShown = true;

  final _formKey = GlobalKey<FormState>();

  final _formData = Map<String, Object>();

  _onSubmit() {
    _formKey.currentState!.save();
    if (_formData['password'] != _formData['rpassword']) {
      dialogueBox(context, 'Re-type password and password should be equal');
    } else {
      progressIndicator(context);
      try {
        FirebaseAuth auth = FirebaseAuth.instance;
        auth
            .createUserWithEmailAndPassword(
                email: _formData['gemail'].toString(),
                password: _formData['password'].toString())
            .then((v) async {
          DocumentReference<Map<String, dynamic>> db =
              FirebaseFirestore.instance.collection('users').doc(v.user!.uid);
          final user = UserModel(
            name: _formData['name'].toString(),
            phone: _formData['phone'].toString(),
            userEmail: _formData['cemail'].toString(),
            guardianEmail:
                _formData['gemail'].toString(), 
            id: v.user!.uid,
            type: 'parent',
          );

          final jsonData = user.toJson();
          await db.set(jsonData).whenComplete(() {
            goTo(context, LoginPage());
          });
        });
      } on FirebaseAuthException catch (e) {
        dialogueBox(context, e.toString());
      } catch (e) {
        dialogueBox(context, e.toString());
      }
    }
    print(_formData['name']);
    print(_formData['cemail']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 140, 178),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
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
                Column(
                  children: [
                    Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CustomtextField(
                            hintText: 'enter name',
                            textInputAction: TextInputAction.next,
                            keyboardtype: TextInputType.name,
                            prefix: Icon(Icons.person),
                            onsave: (name) {
                              _formData['name'] = name ?? "";
                            },
                            validate: (email) {
                              if (email!.isEmpty || email.length < 3) {
                                return 'enter correct name';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 20),
                          CustomtextField(
                            hintText: 'enter phone',
                            textInputAction: TextInputAction.next,
                            keyboardtype: TextInputType.phone,
                            prefix: Icon(Icons.phone),
                            onsave: (phone) {
                              _formData['phone'] = phone ?? "";
                            },
                            validate: (phone) {
                              if (phone!.isEmpty || phone.length < 10) {
                                return 'enter correct phone';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 20),
                          CustomtextField(
                            hintText: 'enter Guardian email',
                            textInputAction: TextInputAction.next,
                            keyboardtype: TextInputType.emailAddress,
                            prefix: Icon(Icons.person),
                            onsave: (gemail) {
                              _formData['gemail'] = gemail ?? "";
                            },
                            validate: (gemail) {
                              if (gemail!.isEmpty ||
                                  gemail.length < 3 ||
                                  !gemail.contains("@")) {
                                return 'enter correct email';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 20),
                          CustomtextField(
                            hintText: 'enter user email',
                            textInputAction: TextInputAction.next,
                            keyboardtype: TextInputType.emailAddress,
                            prefix: Icon(Icons.person),
                            onsave: (email) {
                              _formData['cemail'] = email ?? "";
                            },
                            validate: (cemail) {
                              if (cemail!.isEmpty ||
                                  cemail.length < 3 ||
                                  !cemail.contains("@")) {
                                return 'enter correct email';
                              }
                            },
                          ),
                          SizedBox(height: 20),
                          CustomtextField(
                            hintText: 'enter password',
                            isPassword: isPasswordShown,
                            prefix: Icon(Icons.vpn_key_rounded),
                            validate: (password) {
                              if (password!.isEmpty || password.length < 7) {
                                return 'enter correct password';
                              }
                              return null;
                            },
                            onsave: (password) {
                              _formData['password'] = password ?? "";
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
                          CustomtextField(
                            hintText: 'enter password',
                            isPassword: isPasswordShown,
                            prefix: Icon(Icons.vpn_key_rounded),
                            validate: (password) {
                              if (password!.isEmpty || password.length < 7) {
                                return 'enter correct password';
                              }
                              return null;
                            },
                            onsave: (password) {
                              _formData['rpassword'] = password ?? "";
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
                          SizedBox(height: 20),
                          PrimaryButton(
                            title: "REGISTER",
                            onPressed: () {
                              if (_formKey.currentState!.validate())
                                _onSubmit();
                            },
                          ),
                          SecondaryButton(
                            title: 'Login with your account',
                            onPressed: () {
                              goTo(context, LoginPage());
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
