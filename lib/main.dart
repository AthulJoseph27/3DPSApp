import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'Auth/Wrapper.dart';
import 'Screens/Login.dart';

/*
The requirements

1. Filament types, colour to choose from

2. Customer should be able to upload their designs either from phone or app.

3. Should show the estimate.

4. Printing status

5. Automated billing and in app payment
*/
Future<void> main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Wrapper(),
    );
  }
}
