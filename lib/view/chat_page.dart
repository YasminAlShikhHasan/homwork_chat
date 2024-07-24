import 'package:chat_with_supabase/main.dart';
import 'package:chat_with_supabase/services/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatPage extends ConsumerStatefulWidget {
  const ChatPage({super.key});

  @override
  ConsumerState<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends ConsumerState<ChatPage> {
  late TextEditingController messageController;
  
  @override
  void initState() {
    messageController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final chatMessages = ref.watch(getData);

    return Scaffold(
      body: Center(
        child: chatMessages.when(
          data: (messages) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      final message = messages[index];
                      return Align(
                        alignment: message.isMe
                            ? Alignment.topRight
                            : Alignment.topLeft,
                        child: Card(
                          child: Container(
                            decoration: BoxDecoration(
                              color: message.isMe ? Colors.blue : null,
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(20),
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20),
                                bottomRight: message.isMe
                                    ? Radius.circular(0)
                                    : Radius.circular(20),
                              ),
                            ),
                            width: 300,
                            height: 50,
                            child: Center(
                              child: Text(message.message),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: MediaQuery.sizeOf(context).width * 0.8,
                        child: TextField(
                          controller: messageController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () async {
                        await supabase.from('Chat').insert({
                          "message": messageController.text,
                          "is_me": true,
                        });
                        messageController.clear();
                      },
                      icon: Icon(Icons.send),
                    ),
                  ],
                ),
              ],
            );
          },
          loading: () => CircularProgressIndicator(),
          error: (error, stack) => Text('Error: $error'),
        ),
      ),
    );
  }
}
  
