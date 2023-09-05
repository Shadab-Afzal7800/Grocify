// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:grocery_list_app/enterOTP.dart';

// class PhoneLogin extends StatefulWidget {
//   const PhoneLogin({super.key});

//   @override
//   State<PhoneLogin> createState() => _PhoneLoginState();
// }

// TextEditingController phoneNumberController = TextEditingController();

// void sendOTP(BuildContext context) async {
//   String phone = '+91' + phoneNumberController.text.trim();
//   await FirebaseAuth.instance.verifyPhoneNumber(
//       phoneNumber: phone,
//       verificationCompleted: (phoneAuthCredential) {},
//       codeSent: (verificationId, forceResendingToken) {
//         Navigator.push(
//             context,
//             CupertinoPageRoute(
//                 builder: (context) => verifyOTP(
//                       verificationId: verificationId,
//                     )));
//       },
//       verificationFailed: (ex) {
//         ScaffoldMessenger.of(context)
//             .showSnackBar(SnackBar(content: Text('Verification Failed')));
//       },
//       codeAutoRetrievalTimeout: (verificationId) {},
//       timeout: Duration(seconds: 30));
// }

// class _PhoneLoginState extends State<PhoneLogin> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Login through Phone'),
//         backgroundColor: Colors.greenAccent,
//       ),
//       body: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(20.0),
//             child: TextFormField(
//               // focusNode: _focusNode,
//               controller: phoneNumberController,
//               decoration: const InputDecoration(
//                   icon: Icon(Icons.phone),
//                   iconColor: Colors.black,
//                   border: OutlineInputBorder(
//                       borderSide: BorderSide(color: Colors.black)),
//                   hintText: 'Phone Number'),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.only(top: 20),
//             child: CupertinoButton(
//                 borderRadius: const BorderRadius.all(Radius.circular(10.0)),
//                 color: Colors.black,
//                 child: const Text('SignUp'),
//                 onPressed: () => sendOTP(context)),
//           )
//         ],
//       ),
//     );
//   }
// }
