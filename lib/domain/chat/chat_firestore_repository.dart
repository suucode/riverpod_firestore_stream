//Provider

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_firestore_stream/domain/chat/chat.dart';
import 'package:riverpod_firestore_stream/dto/chat/chat_req_dto.dart';

//리턴 : Stream<List<Chat>> - 계속 수신받을 수 있음
final chatStreamProvider = StreamProvider<List<Chat>>((ref) {
  final db = FirebaseFirestore.instance;
  Stream<QuerySnapshot<Map<String, dynamic>>> stream =
      db.collection("chat").snapshots();
  return stream.map((snapshot) =>
      snapshot.docs.map((doc) => Chat.fromJson(doc.data())).toList());
});

final chatFirestoreRepositoryProvider = Provider((ref) {
  return ChatFirestoreRepository();
});

class ChatFirestoreRepository {
  //통신은 여기서
  final db = FirebaseFirestore.instance;

  // Stream<QuerySnapshot<Map<String, dynamic>>> findAllStream() {
  //   //db.collection("chat").orderBy("createdAt").snapshots()
  //   return db.collection("chat").snapshots();
  // }

  Future<DocumentReference> insert(ChatInsertReqDto dto) {
    return db.collection("chat").add(dto.toJson());
  }

  // void findAllStream() {
  //   //지속적으로 db를 읽어옴
  //   //db.collection("chat").orderBy(필드명 ex)"createdAt").snapshots(); //정렬하고싶다면 다음과 같이 쓴다
  //   db.collection("chat").snapshots().map((event) {});
  // }
}
