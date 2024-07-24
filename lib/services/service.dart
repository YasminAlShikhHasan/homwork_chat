import 'dart:ffi';

import 'package:chat_with_supabase/model/message.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

abstract class Service {
  Stream<List<MessageModel>> getMessage();
  Future<bool> addMessage(MessageModel message);
}

class ServiceImp extends Service {
  @override
  Future<bool> addMessage(MessageModel message) async {
    await supabase
        .from('chat')
        .insert({'message': message.message, 'isme': false}).select();
    return true;
  }

  @override
  Stream<List<MessageModel>> getMessage() {
     return supabase.from('Chat').stream(primaryKey: ['id']).map((data) {
      return data.map((map) => MessageModel.fromMap(map)).toList();
    });
  }
}
