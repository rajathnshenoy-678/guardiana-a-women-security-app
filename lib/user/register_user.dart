import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:guardiana/components/PrimaryButton.dart';
import 'package:guardiana/components/SecondaryButton.dart';
import 'package:guardiana/components/custom_textfield.dart';
import 'package:guardiana/model/user_model.dart';
import 'package:guardiana/user/login_screen.dart';
import 'package:guardiana/utils/constants.dart';

class RegisterUserpage extends StatefulWidget {
  @override
  State<RegisterUserpage> createState() => _RegisterUserpageState();
}

class _RegisterUserpageState extends State<RegisterUserpage> {
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
                email: _formData['cemail'].toString(),
                password: _formData['password'].toString())
            .then((v) async {
          DocumentReference<Map<String, dynamic>> db =
              FirebaseFirestore.instance.collection('users').doc(v.user!.uid);
          final user = UserModel(
            name: _formData['name'].toString(),
            phone: _formData['phone'].toString(),
            userEmail: _formData['cemail'].toString(),
            guardianEmail:
                _formData['gemail'].toString(), // Save guardian's email
            id: v.user!.uid,
            type: 'user',
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
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: SafeArea(
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
                  "REGISTER USER",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 25),
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
                        hintText: 'enter email',
                        textInputAction: TextInputAction.next,
                        keyboardtype: TextInputType.emailAddress,
                        prefix: Icon(Icons.person),
                        onsave: (email) {
                          _formData['cemail'] = email ?? "";
                        },
                        validate: (email) {
                          if (email!.isEmpty ||
                              email.length < 3 ||
                              !email.contains("@")) {
                            return 'enter correct email';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      CustomtextField(
                        hintText: 'enter guardian email',
                        textInputAction: TextInputAction.next,
                        keyboardtype: TextInputType.emailAddress,
                        prefix: Icon(Icons.person),
                        onsave: (gemail) {
                          _formData['gemail'] = gemail ?? "";
                        },
                        validate: (email) {
                          if (email!.isEmpty ||
                              email.length < 3 ||
                              !email.contains("@")) {
                            return 'enter correct email';
                          }
                          return null;
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
                      SizedBox(height: 20),
                      CustomtextField(
                        hintText: 'Re-type password',
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
                          //progressIndicator(context);
                          if (_formKey.currentState!.validate()) _onSubmit();
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
            ),
          ),
        ),
      ),
    );
  }
}
