import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/auth/text_form_field.dart';
import 'package:todo_list/home/firebase_utils.dart';
import 'package:todo_list/home/home_screen.dart';
import 'package:todo_list/home/task%20_list/alertDialog.dart';
import 'package:todo_list/models/user_model.dart';
import 'package:todo_list/widget/my_them.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../providers/user_provider.dart';
import '../login/loogin.dart';

class Register extends StatefulWidget {
  static const String routeName = "Register";

  @override
  State<Register> createState() => _RegesterState();
}

class _RegesterState extends State<Register> {
  TextEditingController? userNameController = TextEditingController();

  TextEditingController? emailController = TextEditingController();

  TextEditingController? passwordController = TextEditingController();

  TextEditingController? confirmPasswordController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    AppLocalizations appLocalization = AppLocalizations.of(context)!;
    return Stack(
      children: [
        Container(
          color: MyTheme.whiteColor,
          child: Image(
            image: const AssetImage("assets/images/bg.png"),
            width: screenSize.width,
            height: screenSize.height,
            fit: BoxFit.fill,
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: Text(
              appLocalization.sign_up,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: MyTheme.whiteColor,
                  ),
            ),
            centerTitle: true,
            backgroundColor: Colors.transparent,
          ),
          body: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    height: screenSize.height * .25,
                  ),
                  CustomTextFormField(
                      title: appLocalization.first_name,
                      controller: userNameController,
                      validator: (text) {
                        if (text == null || text.trim().isEmpty) {
                          return appLocalization.error_user_name;
                        }
                        return null;
                      }),
                  CustomTextFormField(
                      title: appLocalization.e_mail,
                      keyboardType: TextInputType.emailAddress,
                      controller: emailController,
                      validator: (text) {
                        if (text == null || text.trim().isEmpty) {
                          return appLocalization.error_email;
                        }
                        bool emailValid = RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(text);
                        if (!emailValid) {
                          return appLocalization.error_email;
                        }

                        return null;
                      }),
                  CustomTextFormField(
                      title: appLocalization.password,
                      keyboardType: TextInputType.number,
                      controller: passwordController,
                      obscureText: true,
                      validator: (text) {
                        if (text == null || text.trim().isEmpty) {
                          return appLocalization.error_password;
                        }
                        if (text.length < 6) {
                          return appLocalization.password_should_be_6;
                        }
                        return null;
                      }),
                  CustomTextFormField(
                      title: appLocalization.confirm_password,
                      keyboardType: TextInputType.number,
                      obscureText: true,
                      controller: confirmPasswordController,
                      validator: (text) {
                        if (text == null || text.trim().isEmpty) {
                          return appLocalization.error_confirm_password;
                        }
                        if (text != passwordController!.text) {
                          return appLocalization.password_not_match;
                        }
                        return null;
                      }),
                  SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(Color(0xff3598DB)),
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18))),
                          fixedSize:
                              MaterialStateProperty.all(Size.fromHeight(60))),
                      onPressed: () {
                        register();
                      },
                      child: Text(appLocalization.sign_up,
                          style: Theme.of(context).textTheme.titleLarge),
                    ),
                  ),
                  SizedBox(height: screenSize.height * .03),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        appLocalization.already_have_account,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w400),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context)
                              .pushNamed(LoginScreen.routeName);
                        },
                        child: Text(
                          appLocalization.log_in,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  void register() async {
    AppLocalizations appLocalization = AppLocalizations.of(context)!;

    if (formKey.currentState?.validate() == true) {
      // todo : show loading
      DialogUtils.showLoading(
          context: context,
          loadingMessage: appLocalization.loading,
          isDismissible: false);
      await Future.delayed(Duration(seconds: 1));
//todo : hide msg
      DialogUtils.hideLoading(context);
      try {
        final credential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController!.text,
          password: passwordController!.text,
        );
        MyUser userModel = MyUser(
            email: emailController?.text,
            id: credential.user?.uid ?? "",
            name: userNameController?.text);

        await FirebaseUtils.addUserToFirestore(userModel);
        var authProvider = Provider.of<AuthProviders>(context, listen: false);
        authProvider.updateUser(userModel);

        Navigator.pushNamedAndRemoveUntil(
            context, HomeScreen.routeName, (Route<dynamic> route) => false);

        Fluttertoast.showToast(
          msg: "√ ${appLocalization.signed_up_success}",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.SNACKBAR,
          timeInSecForIosWeb: 1,
          backgroundColor: MyTheme.greyColor,
          textColor: MyTheme.blackDarkColor,
          fontSize: 16.0,
        );
        print("register successfully");
        print(credential.user?.uid ?? "");
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          DialogUtils.hideLoading(context);
          Navigator.pushNamedAndRemoveUntil(
              context, Register.routeName, (Route<dynamic> route) => false);
          Fluttertoast.showToast(
            msg: appLocalization.weak_password,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.SNACKBAR,
            timeInSecForIosWeb: 1,
            backgroundColor: MyTheme.greyColor,
            textColor: MyTheme.blackDarkColor,
            fontSize: 16.0,
          );
          print('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          DialogUtils.hideLoading(context);
          Navigator.pushNamedAndRemoveUntil(
              context, Register.routeName, (Route<dynamic> route) => false);
          Fluttertoast.showToast(
            msg: appLocalization.acc_already,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.SNACKBAR,
            timeInSecForIosWeb: 1,
            backgroundColor: MyTheme.greyColor,
            textColor: MyTheme.blackDarkColor,
            fontSize: 16.0,
          );
          print('The account already exists for that email.');
        }
      } catch (e) {
        DialogUtils.hideLoading(context);
        Navigator.pushNamedAndRemoveUntil(
            context, Register.routeName, (Route<dynamic> route) => false);
        Fluttertoast.showToast(
          msg: "${e.toString()}",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.SNACKBAR,
          timeInSecForIosWeb: 1,
          backgroundColor: MyTheme.greyColor,
          textColor: MyTheme.blackDarkColor,
          fontSize: 16.0,
        );
        print(e);
      }
    }
  }
}
