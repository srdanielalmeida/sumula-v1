import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'pages/auth_gate_page.dart';
import 'services/auth_service.dart';
import 'services/knowledge_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const SumulaApp());
}

class SumulaApp extends StatelessWidget {
  const SumulaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SÚMULA.AI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF3B82F6)),
        useMaterial3: true,
      ),
      home: AuthGatePage(
        authService: AuthService(),
        knowledgeService: KnowledgeService(),
      ),
    );
  }
}
