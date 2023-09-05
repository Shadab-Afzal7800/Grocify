import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({super.key});

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

TextEditingController createName = TextEditingController();
TextEditingController createEmail = TextEditingController();
TextEditingController createPassword = TextEditingController();
TextEditingController confirmPassword = TextEditingController();

class _CreateAccountState extends State<CreateAccount> {
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
            title: const Text('Register Yourself'),
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
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextFormField(
                controller: createName,
                decoration: const InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black)),
                    icon: Icon(Icons.person),
                    iconColor: Colors.black,
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black)),
                    hintText: 'Name'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextFormField(
                controller: createEmail,
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
                controller: createPassword,
                decoration: const InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black)),
                    icon: Icon(Icons.lock),
                    iconColor: Colors.black,
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black)),
                    hintText: 'Password'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextFormField(
                controller: confirmPassword,
                decoration: const InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black)),
                    icon: Icon(Icons.check),
                    iconColor: Colors.black,
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black)),
                    hintText: 'Confirm Password'),
              ),
            ),
            Expanded(
                child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: CupertinoButton(
                  onPressed: () => createAccount(context),
                  color: Colors.black,
                  borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                  disabledColor: CupertinoColors.black,
                  child: const Text('CREATE'),
                ),
              ),
            ))
          ],
        ),
      ),
    );
  }
}

void createAccount(BuildContext context) async {
  String name = createName.text;
  String email = createEmail.text;
  String password = createPassword.text;
  String cpassword = confirmPassword.text;

  if (email == '' || password == '' || cpassword == '') {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Fields cannot be empty!')));
  } else if (password != cpassword) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Passwords do not match!')));
  } else {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await FirebaseAuth.instance.currentUser!.updateDisplayName(name);
      if (userCredential.user != null) {
        Navigator.pop(context);
      }
    } on FirebaseAuthException catch (ex) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(ex.code.toString())));
    }
  }
}
