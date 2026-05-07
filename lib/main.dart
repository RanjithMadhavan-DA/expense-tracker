import 'package:flutter/material.dart';
import 'screens/expense_list_screen.dart';
import 'package:provider/provider.dart';
import '../provider/expense_provider.dart';
// import 'package:firebase_core/firebase_core.dart';
// import '../firebase_options.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();

  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ExpenseProvider()..loadexpense()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const ExpenseListScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
