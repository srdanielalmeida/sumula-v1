import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../services/auth_service.dart';
import '../services/knowledge_service.dart';
import 'auth_pages.dart';
import 'dashboard_page.dart';

class AuthGatePage extends StatelessWidget {
  const AuthGatePage({
    super.key,
    required this.authService,
    required this.knowledgeService,
  });

  final AuthService authService;
  final KnowledgeService knowledgeService;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: authService.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(body: Center(child: CircularProgressIndicator()));
        }

        if (snapshot.data != null) {
          return DashboardPage(
            authService: authService,
            knowledgeService: knowledgeService,
          );
        }

        return AuthPages(authService: authService);
      },
    );
  }
}
