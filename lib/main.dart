import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_list/providers/tasks_provider.dart';
import 'package:todo_list/tasks/edit_task.dart';
import 'package:todo_list/widget/my_them.dart';
import 'package:todo_list/providers/app_config_provider.dart';
import 'package:todo_list/providers/user_provider.dart';
import 'auth/login/loogin.dart';
import 'auth/register/register.dart';
import 'auth/reset_pass/reset_pass.dart';
import 'firebase_options.dart';
import 'home/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
    // await FirebaseFirestore.instance.disableNetwork();
  );
  Settings(cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED);

  await FirebaseFirestore.instance.disableNetwork();
  FirebaseFirestore.instance.settings =
      const Settings(cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED);

  SharedPreferences prefs = await SharedPreferences.getInstance();
  final bool isDarkTheme = prefs.getBool("isDark") ?? false;
  final bool isEnglish = prefs.getBool("isEnglish") ?? false;

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
          create: (_) => AppConfigProvider(isDarkTheme, isEnglish)),
      ChangeNotifierProvider(create: (_) => TaskProvider()),
      ChangeNotifierProvider(create: (_) => AuthProviders()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    return MaterialApp(
      themeMode: provider.appTheme,
      darkTheme: MyTheme.darkTheme,
      locale: Locale(provider.appLanguage),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: MyTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      routes: {
        HomeScreen.routeName: (context) => const HomeScreen(),
        EditTask.routeName: (context) => const EditTask(),
        LoginScreen.routeName: (context) => const LoginScreen(),
        Register.routeName: (context) => Register(),
        ResetPassword.routeName: (context) => ResetPassword()
      },
      initialRoute: LoginScreen.routeName,
    );
  }
}
