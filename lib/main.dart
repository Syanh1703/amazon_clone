import 'package:amazon_clone/constants/global_var.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:amazon_clone/route.dart';
import 'package:amazon_clone/screens/admin_screen.dart';
import 'package:amazon_clone/screens/auth_screen.dart';
import 'package:amazon_clone/services/auth_service.dart';
import 'package:amazon_clone/widgets/bottom_bar.dart';
import 'package:amazon_clone/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (ctx) => UserProvider()),
    ],
      child: const MyApp(),
  )
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  final AuthService authService = AuthService();

  @override
  void initState() {
    super.initState();
    authService.getUserData(context);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Amazon clone',
      theme: ThemeData(
        scaffoldBackgroundColor: GlobalVars.backgroundColor,
        colorScheme: const ColorScheme.light(
          primary: GlobalVars.secondaryColor,
        ),
        appBarTheme: const AppBarTheme(
          elevation: 0,
          iconTheme: IconThemeData(color: GlobalVars.iconThemeColor),
        ),
        useMaterial3: true,
      ),
      onGenerateRoute: (routeSettings) => generateRoute(routeSettings),
      home: Provider.of<UserProvider>(context).user.token.isNotEmpty ?
      Provider.of<UserProvider>(context).user.type == 'user' ?
      const BottomBar() : const AdminScreen()
          : AuthScreen(),
    );
  }
}


