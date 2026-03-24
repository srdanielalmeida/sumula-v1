import 'package:cloud_firestore/cloud_firestore.dart';

/// Contratos centralizados para facilitar programação no Antigravity.
///
/// A ideia é manter nomes de coleções/campos em um único lugar para que
/// ações visuais (workflows) e código Dart compartilhem a mesma estrutura.
abstract final class AntigravitySchema {
  static const usersCollection = 'users';
  static const knowledgeCollection = 'items_conhecimento';
  static const connectionsCollection = 'conexoes';

  // users
  static const userName = 'nome';
  static const userEmail = 'email';
  static const userPhoto = 'foto';
  static const userCreatedAt = 'created_at';

  // items_conhecimento
  static const uid = 'uid';
  static const userId = 'user_id';
  static const tipo = 'tipo';
  static const conteudoOrigem = 'conteudo_origem';
  static const titulo = 'titulo';
  static const dataCriacao = 'data_criacao';
  static const status = 'status';
  static const resumoIa = 'resumo_ia';
  static const tagsGeradas = 'tags_geradas';

  // conexoes
  static const itemAId = 'item_a_id';
  static const itemBId = 'item_b_id';
  static const tipoConexao = 'tipo_conexao';
}

Map<String, dynamic> buildMockCrisolPayload({required String tipo}) {
  return {
    AntigravitySchema.status: 'destilado',
    AntigravitySchema.titulo: 'Insight sobre ${tipo.toUpperCase()} recebido',
    AntigravitySchema.resumoIa:
        'Resumo MOCK do Crisol: os pontos principais foram extraídos para apoiar criação de conteúdo, reaproveitamento e conexões de ideias.',
    AntigravitySchema.tagsGeradas: ['insight', 'conteudo', 'sumula_ai'],
  };
}

Map<String, dynamic> buildKnowledgeSeedPayload({
  required String uid,
  required DocumentReference userRef,
  required String tipo,
  required String conteudoOrigem,
}) {
  return {
    AntigravitySchema.uid: uid,
    AntigravitySchema.userId: userRef,
    AntigravitySchema.tipo: tipo.toLowerCase(),
    AntigravitySchema.conteudoOrigem: conteudoOrigem,
    AntigravitySchema.titulo: 'Processando...',
    AntigravitySchema.dataCriacao: Timestamp.now(),
    AntigravitySchema.status: 'cru',
    AntigravitySchema.resumoIa: '',
    AntigravitySchema.tagsGeradas: <String>[],
  };
}
