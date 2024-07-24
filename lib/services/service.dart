import 'package:chat_with_supabase/model/message.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

abstract class Service {
  Stream<List<MessageModel>> getMessage();
  Future addMessage(MessageModel message);
}

class ServiceImp extends Service {
  @override
  Future addMessage(MessageModel message) async {
    await supabase
        .from('chat')
        .insert({'message': message.message, "isMe": false}).select();
  }

  @override
  Stream<List<MessageModel>> getMessage() {
   return supabase.from('Chat').stream(primaryKey: ['*']).map((data) {
      return data.map((map) => MessageModel.fromMap(map)).toList();
    });
   
    
  }
}
