import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/auth/register/register.dart';
import 'package:todo_list/home/home_screen.dart';
import 'package:todo_list/models/user_model.dart';
import 'package:todo_list/widget/my_them.dart';
import '../../home/task _list/alertDialog.dart';
import '../../providers/app_config_provider.dart';
import '../../providers/user_provider.dart';
import '../../widget/elevated_button.dart';
import '../register/text_form_field1.dart';
import 'login_abstract_navigator.dart';
import 'login_screen_view_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = "LoginScreen";

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LogInState();
}

class _LogInState extends State<LoginScreen> implements LoginNavigator {
  LoginViewModel viewModel = LoginViewModel();

  @override
  String appLocalizationErrorPassword() {
    // TODO: implement appLocalizationErrorPassword
    return AppLocalizations.of(context)!.error_password;

    // AppLocalizations.of(context)!.error_password;
  }

  @override
  void updateUserEmail(MyUser? user, String email) {
    Provider.of<AuthProviders>(context, listen: false).updateUser(user);
    Provider.of<AppConfigProvider>(context, listen: false).changeEmail(email);
  }

  @override
  String appLocalizationErrorWord() {
    // TODO: implement appLocalizationErrorWord
    return AppLocalizations.of(context)!.error_word;
  }

  @override
  String appLocalizationLoggedInSuccess() {
    // TODO: implement appLocalizationLoggedInSuccess
    return AppLocalizations.of(context)!.logged_in_success;
  }

  @override
  String appLocalizationOk() {
    // TODO: implement appLocalizationOk
    return AppLocalizations.of(context)!.ok;
  }

  @override
  String appLocalizationSigningIn() {
    // TODO: implement appLocalizationSigningIn
    return AppLocalizations.of(context)!.log_in;
  }

  @override
  void initState() {
    // TODO: implement initState
    viewModel.loginNavigator = this;
    viewModel.getEmailFromSharedPreference();
    super.initState();
  }

  @override
  void hideLoading() {
    // TODO: implement hideLoading
    DialogUtils.hideLoading(context);
  }

  @override
  String appLocalizationErrorEmail() {
    // TODO: implement appLocalizationErrorEmail
    return AppLocalizations.of(context)!.error_email;
  }

  @override
  void pushNamedAndRemoveUntilLogin() {
    // TODO: implement pushNamedAndRemoveUntilLogin
    Navigator.pushNamedAndRemoveUntil(
        context, HomeScreen.routeName, (Route<dynamic> route) => false);
  }

  @override
  void pushNamedSignup() {
    // TODO: implement pushNamedSignup
    Navigator.pushNamedAndRemoveUntil(
        context, Register.routeName, (Route<dynamic> route) => false);
  }

  @override
  void showMessage({String? message, String? title, String? posAction}) {
    // TODO: implement showMessage
    DialogUtils.showMessage(
      context: context,
      content: message ?? "",
      title: title,
      posActions: posAction,
    );
  }

  @override
  void showToast(String message) {
    // TODO: implement showToast
    Fluttertoast.showToast(
      msg: "√ $message",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.SNACKBAR,
      timeInSecForIosWeb: 1,
      backgroundColor: MyTheme.greenColor,
      textColor: MyTheme.blackDarkColor,
      fontSize: 16.0,
    );
  }

  @override
  void showLoadingSignIn(String message) {
    // TODO: implement showLoadingSignIn
    DialogUtils.showLoading(context: context, loadingMessage: message);
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    AppLocalizations appLocalization = AppLocalizations.of(context)!;

    return ChangeNotifierProvider<LoginViewModel>(
      create: (context) => viewModel,
      child: Stack(
        children: [
          Container(
            color: Colors.white,
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
                toolbarHeight: 150,
                automaticallyImplyLeading: true,
                title: Text(
                  appLocalization.log_in,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: MyTheme.whiteColor,
                      fontSize: 30,
                      fontFamily: "Poppins-Regular",
                      fontWeight: FontWeight.bold),
                ),
                centerTitle: true,
                backgroundColor: Colors.transparent),
            body: Padding(
              padding: const EdgeInsets.all(10.0),
              child: SingleChildScrollView(
                child: Column(children: [
                  SizedBox(
                    height: screenSize.height * .15,
                  ),
                  Form(
                    key: viewModel.formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          appLocalization.welcome,
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(
                                  color: Colors.black,
                                  fontSize: 30,
                                  fontFamily: "Poppins-Regular",
                                  fontWeight: FontWeight.bold),
                          textAlign: TextAlign.start,
                        ),
                        SizedBox(
                          height: screenSize.height * .02,
                        ),
                        CustomTextFormField1(
                          obscureText: false,
                          onChanged: (value) {
                            viewModel.checkEmailValidation(value);
                          },
                          label: appLocalization.e_mail,
                          validator: (value) {
                            return viewModel.emailValidator(value);
                          },
                          keyboardType: TextInputType.emailAddress,
                          controller: viewModel.emailTextController,
                          focusNode: viewModel.userEmailFocusNode,
                          showEmailSuffixIcon: viewModel.showValidEmailIcon,
                        ),
                        SizedBox(
                          height: screenSize.height * .02,
                        ),
                        CustomTextFormField1(
                          onChanged: (value) {},
                          keyboardType: TextInputType.number,
                          label: appLocalization.password,
                          validator: (value) {
                            return viewModel.passwordValidator(value);
                          },
                          controller: viewModel.passwordController,
                          focusNode: viewModel.passwordFocusNode,
                        ),
                        SizedBox(
                          height: screenSize.height * .02,
                        ),
                        // TextButton(
                        //   onPressed: () {
                        //     Navigator.pushNamed(
                        //         context, ResetPassword.routeName);
                        //   },
                        //   child: Text(
                        //     appLocalization.forget_password,
                        //     style: Theme.of(context)
                        //         .textTheme
                        //         .bodyLarge
                        //         ?.copyWith(
                        //         color: MyTheme.blackColor,
                        //         decoration: TextDecoration.underline),
                        //   ),
                        // ),
                        CustomElevatedButton(
                          enable: viewModel.checkTextField(),
                          onPressed: viewModel.logIn,
                          buttonText: appLocalization.log_in,
                        ),
                        TextButton(
                          onPressed: () {
                            pushNamedSignup();
                          },
                          child: Text(
                            appLocalization.create_new_account,
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(
                                    color: MyTheme.blackColor,
                                    decoration: TextDecoration.underline),
                          ),
                        ),
                      ],
                    ),
                  ),
                ]),
              ),
            ),
          )
        ],
      ),
    );
  }
}
