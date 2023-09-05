// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:grocery_list_app/listScreen.dart';

// class verifyOTP extends StatefulWidget {
//   final String verificationId;
//   const verifyOTP({super.key, required this.verificationId});

//   @override
//   State<verifyOTP> createState() => _verifyOTPState();
// }

// TextEditingController otpController = TextEditingController();

// void otpVerify(BuildContext context) async {
//   String otp = otpController.text.trim();

  
//   PhoneAuthCredential credential = PhoneAuthProvider.credential(
//       verificationId: verificationId, smsCode: otp);

//   try {
//     UserCredential userCredential =
//         await FirebaseAuth.instance.signInWithCredential(credential);
//     if (UserCredential != null) {
//       Navigator.push(
//           context, CupertinoPageRoute(builder: (context) => MyHomeScreen()));
//     }
//   } on FirebaseAuthException catch (ex) {
//     ScaffoldMessenger.of(context)
//         .showSnackBar(SnackBar(content: Text(ex.code.toString())));
//   }
// }

// class _verifyOTPState extends State<verifyOTP> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.greenAccent,
//         title: Text('Verify OTP'),
//       ),
//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(20.0),
//             child: TextFormField(
//               // focusNode: _focusNode,
//               controller: otpController,
//               maxLength: 6,
//               decoration: const InputDecoration(
//                   icon: Icon(Icons.phone),
//                   iconColor: Colors.black,
//                   counter: null,
//                   border: OutlineInputBorder(
//                       borderSide: BorderSide(color: Colors.black)),
//                   hintText: 'Enter OTP'),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.only(top: 20),
//             child: CupertinoButton(
//                 borderRadius: const BorderRadius.all(Radius.circular(10.0)),
//                 color: Colors.black,
//                 child: const Text('Login'),
//                 onPressed: () {}),
//           )
//         ],
//       ),
//     );
//   }
// }
