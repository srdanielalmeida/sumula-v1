import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../antigravity/antigravity_schema.dart';
import '../models/knowledge_item.dart';

class KnowledgeService {
  KnowledgeService({FirebaseFirestore? firestore, FirebaseAuth? auth})
      : _firestore = firestore ?? FirebaseFirestore.instance,
        _auth = auth ?? FirebaseAuth.instance;

  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  CollectionReference<Map<String, dynamic>> get _items =>
      _firestore.collection(AntigravitySchema.knowledgeCollection);
  CollectionReference<Map<String, dynamic>> get _connections =>
      _firestore.collection(AntigravitySchema.connectionsCollection);

  DocumentReference get _currentUserRef =>
      _firestore.collection(AntigravitySchema.usersCollection).doc(_auth.currentUser!.uid);

  Stream<List<KnowledgeItem>> watchItemsForCurrentUser() {
    return _items
        .where(AntigravitySchema.userId, isEqualTo: _currentUserRef)
        .orderBy(AntigravitySchema.dataCriacao, descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs.map(KnowledgeItem.fromDoc).toList());
  }

  Future<DocumentReference<Map<String, dynamic>>> ingestAndMockCrisol({
    required String tipo,
    required String conteudoOrigem,
  }) async {
    final doc = _items.doc();

    await doc.set(
      buildKnowledgeSeedPayload(
        uid: doc.id,
        userRef: _currentUserRef,
        tipo: tipo,
        conteudoOrigem: conteudoOrigem,
      ),
    );

    await doc.update(buildMockCrisolPayload(tipo: tipo));
    return doc;
  }

  Future<void> updateTitle({required String itemId, required String title}) async {
    await _items.doc(itemId).update({AntigravitySchema.titulo: title});
  }

  Stream<List<KnowledgeItem>> watchRelatedItems({required String excludeItemId}) {
    return _items
        .where(AntigravitySchema.userId, isEqualTo: _currentUserRef)
        .orderBy(AntigravitySchema.dataCriacao, descending: true)
        .limit(5)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .where((d) => d.id != excludeItemId)
              .map(KnowledgeItem.fromDoc)
              .toList(),
        );
  }

  Future<void> createMockConnection({
    required String itemAId,
    required String itemBId,
    String tipoConexao = 'relacionado',
  }) async {
    final doc = _connections.doc();
    await doc.set({
      AntigravitySchema.uid: doc.id,
      AntigravitySchema.userId: _currentUserRef,
      AntigravitySchema.itemAId: _items.doc(itemAId),
      AntigravitySchema.itemBId: _items.doc(itemBId),
      AntigravitySchema.tipoConexao: tipoConexao,
    });
  }
}
