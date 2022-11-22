//Provider
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_firestore_stream/core/route_enum.dart';
import 'package:riverpod_firestore_stream/domain/chat/chat_firestore_repository.dart';
import 'package:riverpod_firestore_stream/dto/chat/chat_req_dto.dart';

final chatControllerProvider = Provider((ref) {
  return ChatController(ref);
});

class ChatController {
  Ref _ref;
  ChatController(this._ref);

  void insert(ChatInsertReqDto dto) {
    Future<DocumentReference> futureDoc =
        _ref.read(chatFirestoreRepositoryProvider).insert(dto);
    futureDoc.then(
      (value) {
        print("document id : ${value.id}");
        //여기서는 화면 이동
        //Navigator.pushNamed(context, Routes.login.path); //현재화면위에 또 띄움 (뒤로가기가 필요한 상황일때 사용)
        //Navigator.popAndPushNamed(context, Routes.login.path); //현재화면을 꺼내고 들어감 (로그인화면 다음화면같은 경우 사용)
        //Navigator.pop(context);//현재화면 빠져나오기(스택에서 제거)
        //Navigator.pushAndRemoveUntil(context, Routes.login.path, (route) => false); //새로운 화면을 꺼내면서 밑에있는건 다 날림
      },
    ).onError(
      (error, stackTrace) {
        print("error:${error}");
        //여기서는 경고창(에러메세지)
      },
    );
  }
}
