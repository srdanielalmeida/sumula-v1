import 'package:flutter/material.dart';

import '../models/knowledge_item.dart';
import '../services/auth_service.dart';
import '../services/knowledge_service.dart';
import 'details_page.dart';
import 'ingest_page.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({
    super.key,
    required this.authService,
    required this.knowledgeService,
  });

  final AuthService authService;
  final KnowledgeService knowledgeService;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('O Grafo · Dashboard'),
        actions: [
          IconButton(
            onPressed: authService.signOut,
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: StreamBuilder<List<KnowledgeItem>>(
        stream: knowledgeService.watchItemsForCurrentUser(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final items = snapshot.data!;
          if (items.isEmpty) {
            return const Center(child: Text('Nenhum item ainda. Use o + para criar.'));
          }

          return GridView.builder(
            padding: const EdgeInsets.all(12),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              mainAxisSpacing: 10,
              childAspectRatio: 2.2,
            ),
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              return Card(
                child: ListTile(
                  title: Text(item.titulo),
                  subtitle: Text('Status: ${item.status} • Tipo: ${item.tipo}'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => DetailsPage(
                          item: item,
                          knowledgeService: knowledgeService,
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => IngestPage(knowledgeService: knowledgeService),
          ),
        ),
        child: const Icon(Icons.add),
      ),
    );
  }
}
