// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:todo_list/auth/register/register.dart';
// import 'package:todo_list/auth/text_form_field.dart';
// import 'package:todo_list/home/firebase_utils.dart';
// import 'package:todo_list/home/home_screen.dart';
// import 'package:todo_list/my_them.dart';
// import '../../home/task _list/alertDialog.dart';
// import '../../providers/user_provider.dart';
//
// class LoginScreen extends StatefulWidget {
//   static const String routeName = "LoginScreen";
//
//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }
//
// class _LoginScreenState extends State<LoginScreen> {
//   TextEditingController? emailController = TextEditingController();
//
//   TextEditingController? passwordController = TextEditingController();
//
//   var formKey = GlobalKey<FormState>();
//
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         Container(
//           color: MyTheme.whiteColor,
//           child: Image.asset("assets/images/bg.png",
//               height: double.infinity,
//               width: double.infinity,
//               fit: BoxFit.fill),
//         ),
//         Scaffold(
//           appBar: AppBar(
//             title: Text(
//               "Login",
//             ),
//             centerTitle: true,
//             backgroundColor: Colors.transparent,
//           ),
//           backgroundColor: Colors.transparent,
//           body: SingleChildScrollView(
//             child: Form(
//               key: formKey,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: [
//                   SizedBox(
//                     height: MediaQuery.of(context).size.height * .25,
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(10.0),
//                     child: Text("Welcome Back",
//                         style: Theme.of(context)
//                             .textTheme
//                             .titleLarge
//                             ?.copyWith(color: Colors.black)),
//                   ),
//                   SizedBox(height: 20),
//                   CustomTextFormField(
//                       title: "Email",
//                       keyboardType: TextInputType.emailAddress,
//                       controller: emailController,
//                       validator: (text) {
//                         if (text == null || text.trim().isEmpty) {
//                           return "Please enter the email";
//                         }
//                         bool emailValid = RegExp(
//                                 r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
//                             .hasMatch(text);
//                         if (!emailValid) {
//                           return " enter the valid email";
//                         }
//
//                         return null;
//                       }),
//                   CustomTextFormField(
//                       title: "Password",
//                       keyboardType: TextInputType.number,
//                       controller: passwordController,
//                       obscureText: false,
//                       validator: (text) {
//                         if (text == null || text.trim().isEmpty) {
//                           return "Please enter the password.";
//                         }
//                         if (text.length < 6) {
//                           return "Password should be at lest 6 character.";
//                         }
//                         return null;
//                       }),
//                   SizedBox(height: 15),
//                   Padding(
//                     padding: const EdgeInsets.all(10.0),
//                     child: ElevatedButton(
//                       style: ButtonStyle(
//                           backgroundColor:
//                               MaterialStatePropertyAll(Color(0xff3598DB)),
//                           shape: MaterialStateProperty.all(
//                               RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(18)))),
//                       onPressed: () {
//                         login();
//                       },
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Text("Login",
//                               style: Theme.of(context).textTheme.titleLarge),
//                           Container(
//                             padding: EdgeInsets.all(15),
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.end,
//                               children: [
//                                 Icon(
//                                   Icons.arrow_right_alt,
//                                   size: 30,
//                                 ),
//                               ],
//                             ),
//                           )
//                         ],
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: 20),
//                   Center(
//                     child: TextButton(
//                       onPressed: () {
//                         Navigator.of(context).pushNamed(Register.routeName);
//                       },
//                       child: Text(
//                         "Or Create Account",
//                         style: TextStyle(fontSize: 20, color: Colors.black),
//                       ),
//                     ),
//                   )
//                 ],
//               ),
//             ),
//           ),
//         )
//       ],
//     );
//   }
//
//   void login() async {
//     if (formKey.currentState?.validate() == true) {
//       Navigator.pushReplacementNamed(context, HomeScreen.routeName);
//         // todo : show loding
//         DialogUtils.showLoading(context: context, message: "Loading..");
//
//
//         await Future.delayed(Duration(seconds: 1));
// //todo : hide msg
//         DialogUtils.hideLoading(context);
//       try {
//
//         final credential =
//             await FirebaseAuth.instance.signInWithEmailAndPassword(
//           email: emailController!.text,
//           password: passwordController!.text,
//         );
//         var user = await FirebaseUtils.readUserFromFireStore(credential.user?.uid??"");
//         if (user == null){return ; }
//         var authProvider = Provider.of<AuthProviders>(context,listen : false);
//         authProvider.updateUser(user);
//       } on FirebaseAuthException catch (e) {
//         if (e.code == 'user-not-found') {
//           DialogUtils.hideLoading(context);
//
//           DialogUtils.showMessage(
//               context: context,
//               message:
//               "No user found for that email.",
//               // '${e.toString()}',
//               title: "No user found for that email.",
//               posActionName: "Ok");
//
//           print('No user found for that email.');
//         } else if (e.code == 'wrong-password') {
//           DialogUtils.hideLoading(context);
//
//           DialogUtils.showMessage(
//               context: context,
//               message: '${e.toString()}',
//               title: "Wrong password provided for that user.",
//               posActionName: "Ok");
//
//           print('Wrong password provided for that user.');
//         }
//       } catch (e) {
//         DialogUtils.hideLoading(context);
//
//         DialogUtils.showMessage(
//             context: context,
//             message: '${e.toString()}',
//             title: "Error",
//             posActionName: "Ok");
//         print(e.toString());
//       }
//     }
//   }
// }
