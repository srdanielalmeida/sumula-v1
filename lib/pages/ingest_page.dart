import 'package:flutter/material.dart';

import '../services/knowledge_service.dart';

class IngestPage extends StatefulWidget {
  const IngestPage({super.key, required this.knowledgeService});

  final KnowledgeService knowledgeService;

  @override
  State<IngestPage> createState() => _IngestPageState();
}

class _IngestPageState extends State<IngestPage> {
  final TextEditingController _contentController = TextEditingController();
  String _tipoSelecionado = 'url';
  bool _loading = false;

  @override
  void dispose() {
    _contentController.dispose();
    super.dispose();
  }

  Future<void> _sendToCrisol() async {
    setState(() => _loading = true);
    await widget.knowledgeService.ingestAndMockCrisol(
      tipo: _tipoSelecionado,
      conteudoOrigem: _contentController.text.trim(),
    );

    if (!mounted) return;
    setState(() => _loading = false);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Adicionar conhecimento')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            DropdownButtonFormField<String>(
              value: _tipoSelecionado,
              decoration: const InputDecoration(labelText: 'Tipo'),
              items: const [
                DropdownMenuItem(value: 'url', child: Text('URL')),
                DropdownMenuItem(value: 'texto', child: Text('Texto')),
              ],
              onChanged: (value) => setState(() => _tipoSelecionado = value ?? 'url'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _contentController,
              maxLines: 7,
              decoration: const InputDecoration(
                labelText: 'Conteúdo de origem',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            FilledButton.icon(
              onPressed: _loading ? null : _sendToCrisol,
              icon: const Icon(Icons.auto_awesome),
              label: Text(_loading ? 'Processando...' : 'Enviar para o Crisol'),
            ),
          ],
        ),
      ),
    );
  }
}
