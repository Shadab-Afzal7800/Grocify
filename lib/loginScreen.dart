import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grocery_list_app/createAccount.dart';

import 'listScreen.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();

class _LoginState extends State<Login> {
  bool passwordVisible = true;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
              title: const Text('LOGIN'),
              flexibleSpace: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                      Color.fromARGB(255, 21, 72, 47),
                      Color.fromARGB(255, 41, 40, 40)
                    ])),
              )),
          body: Column(
            children: [
              Container(
                height: 300,
                width: MediaQuery.of(context).size.width * 1.0,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/loginBackground.jpg'),
                        fit: BoxFit.cover)),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                      icon: Icon(Icons.email),
                      iconColor: Colors.black,
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                      hintText: 'Email'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextFormField(
                    controller: passwordController,
                    obscureText: passwordVisible,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                      icon: Icon(Icons.lock),
                      iconColor: Colors.black,
                      suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              passwordVisible = !passwordVisible;
                            });
                          },
                          icon: Icon(passwordVisible
                              ? Icons.visibility
                              : Icons.visibility_off)),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                      hintText: 'Password',
                    )),
              ),
              CupertinoButton(
                onPressed: () => login(context),
                borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                color: Colors.black,
                child: const Text('LOGIN'),
              ),
              // Padding(
              //   padding: const EdgeInsets.only(top: 20),
              //   child: CupertinoButton(
              //       borderRadius: const BorderRadius.all(Radius.circular(10.0)),
              //       color: Colors.grey,
              //       child: Text('Login with Phone'),
              //       onPressed: () {
              //         Navigator.push(
              //             context,
              //             CupertinoPageRoute(
              //                 builder: (context) => const PhoneLogin()));
              //       }),
              // ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: TextButton.icon(
                      onPressed: () {
                        setState(() {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const CreateAccount()));
                        });
                      },
                      icon: const Icon(
                        Icons.create_new_folder,
                        color: Colors.black,
                      ),
                      label: const Text(
                        'Create account?',
                        style: TextStyle(color: Colors.black),
                      )),
                ),
              )
            ],
          )),
    );
  }
}

void login(BuildContext context) async {
  String emailLogin = emailController.text.trim();
  String passwordLogin = passwordController.text;

  if (emailLogin == '' || passwordLogin == '') {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Enter Valid Email and Password!')));
  } else {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: emailLogin, password: passwordLogin);

      Navigator.popUntil(context, (route) => route.isFirst);
      Navigator.pushReplacement(
          context, CupertinoPageRoute(builder: (context) => MyHomeScreen()));
    } on FirebaseAuthException catch (ex) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(ex.code.toString())));
    }
  }
}
