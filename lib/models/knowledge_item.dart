import 'package:cloud_firestore/cloud_firestore.dart';

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
      uid: data['uid'] as String? ?? doc.id,
      userId: data['user_id'] as DocumentReference,
      tipo: data['tipo'] as String? ?? 'texto',
      conteudoOrigem: data['conteudo_origem'] as String? ?? '',
      titulo: data['titulo'] as String? ?? 'Sem título',
      dataCriacao: data['data_criacao'] as Timestamp? ?? Timestamp.now(),
      status: data['status'] as String? ?? 'cru',
      resumoIa: data['resumo_ia'] as String? ?? '',
      tagsGeradas: List<String>.from(data['tags_geradas'] as List? ?? const []),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'user_id': userId,
      'tipo': tipo,
      'conteudo_origem': conteudoOrigem,
      'titulo': titulo,
      'data_criacao': dataCriacao,
      'status': status,
      'resumo_ia': resumoIa,
      'tags_geradas': tagsGeradas,
    };
  }
}
