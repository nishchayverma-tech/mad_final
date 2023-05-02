import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mad_final/config/routes.dart';
import 'package:mad_final/controller/product_notifier.dart';
import 'package:mad_final/screens/login.dart';
import 'package:provider/provider.dart';

void main() async {
  // ensures that widget gets loaded first and then firebase gets initialized.
  WidgetsFlutterBinding.ensureInitialized();
  // initialize the firebase --> returns a future object --> waits till the time application gets initialized.
  await Firebase.initializeApp();
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => ProductNotifier())
    ],
    child: MyApp(),)
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: AppBarTheme(color: Colors.indigo),
        primarySwatch: Colors.indigo,
      ),
      initialRoute: '/',
      routes: getRoutes(),
    );
  }
}
