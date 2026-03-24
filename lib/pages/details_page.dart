import 'package:flutter/material.dart';

import '../models/knowledge_item.dart';
import '../services/knowledge_service.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({
    super.key,
    required this.item,
    required this.knowledgeService,
  });

  final KnowledgeItem item;
  final KnowledgeService knowledgeService;

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  late final TextEditingController _titleController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.item.titulo);
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  Future<void> _saveTitle() async {
    await widget.knowledgeService.updateTitle(
      itemId: widget.item.uid,
      title: _titleController.text.trim(),
    );
    if (!mounted) return;
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Título atualizado.')));
  }

  void _showPostDraft() {
    showModalBottomSheet<void>(
      context: context,
      builder: (_) => Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Rascunho gerado (MOCK)',
                style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(
              'Hoje aprendi: ${widget.item.resumoIa}\n\n'
              'CTA: Quer transformar conhecimento em conteúdo? #sumula_ai',
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detalhes e Conexões')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          TextField(
            controller: _titleController,
            decoration: const InputDecoration(labelText: 'Título editável'),
            onSubmitted: (_) => _saveTitle(),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(onPressed: _saveTitle, child: const Text('Salvar título')),
          ),
          const SizedBox(height: 8),
          Text('Resumo IA: ${widget.item.resumoIa}'),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: widget.item.tagsGeradas
                .map((tag) => Chip(label: Text(tag)))
                .toList(),
          ),
          const SizedBox(height: 16),
          const Text('Relacionados (Mock do Grafo)',
              style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          StreamBuilder<List<KnowledgeItem>>(
            stream:
                widget.knowledgeService.watchRelatedItems(excludeItemId: widget.item.uid),
            builder: (context, snapshot) {
              final related = snapshot.data ?? const <KnowledgeItem>[];
              if (related.isEmpty) {
                return const Text('Nenhum relacionado sugerido ainda.');
              }
              return Column(
                children: related
                    .map(
                      (item) => ListTile(
                        title: Text(item.titulo),
                        subtitle: Text(item.tipo),
                      ),
                    )
                    .toList(),
              );
            },
          ),
          const SizedBox(height: 20),
          FilledButton(
            onPressed: _showPostDraft,
            child: const Text('Gerar Post'),
          ),
        ],
      ),
    );
  }
}
