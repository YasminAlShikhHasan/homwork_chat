import 'package:chat_with_supabase/model/message.dart';
import 'package:chat_with_supabase/services/service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final getData = StreamProvider<List<MessageModel>>((ref) {
  return ref.read(message).getMessage();
});
final message = StateProvider<ServiceImp>((ref) {
  return ServiceImp();
});
