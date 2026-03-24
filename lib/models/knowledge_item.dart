import 'package:cloud_firestore/cloud_firestore.dart';

import '../antigravity/antigravity_schema.dart';

class KnowledgeItem {
  final String uid;
  final DocumentReference userId;
  final String tipo;
  final String conteudoOrigem;
  final String titulo;
  final Timestamp dataCriacao;
  final String status;
  final String resumoIa;
  final List<String> tagsGeradas;

  const KnowledgeItem({
    required this.uid,
    required this.userId,
    required this.tipo,
    required this.conteudoOrigem,
    required this.titulo,
    required this.dataCriacao,
    required this.status,
    required this.resumoIa,
    required this.tagsGeradas,
  });

  factory KnowledgeItem.fromDoc(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data() ?? <String, dynamic>{};
    return KnowledgeItem(
      uid: data[AntigravitySchema.uid] as String? ?? doc.id,
      userId: data[AntigravitySchema.userId] as DocumentReference,
      tipo: data[AntigravitySchema.tipo] as String? ?? 'texto',
      conteudoOrigem: data[AntigravitySchema.conteudoOrigem] as String? ?? '',
      titulo: data[AntigravitySchema.titulo] as String? ?? 'Sem título',
      dataCriacao:
          data[AntigravitySchema.dataCriacao] as Timestamp? ?? Timestamp.now(),
      status: data[AntigravitySchema.status] as String? ?? 'cru',
      resumoIa: data[AntigravitySchema.resumoIa] as String? ?? '',
      tagsGeradas: List<String>.from(
        data[AntigravitySchema.tagsGeradas] as List? ?? const [],
      ),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      AntigravitySchema.uid: uid,
      AntigravitySchema.userId: userId,
      AntigravitySchema.tipo: tipo,
      AntigravitySchema.conteudoOrigem: conteudoOrigem,
      AntigravitySchema.titulo: titulo,
      AntigravitySchema.dataCriacao: dataCriacao,
      AntigravitySchema.status: status,
      AntigravitySchema.resumoIa: resumoIa,
      AntigravitySchema.tagsGeradas: tagsGeradas,
    };
  }
}
