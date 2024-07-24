import 'package:chat_with_supabase/model/message.dart';
import 'package:chat_with_supabase/services/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatPage extends ConsumerStatefulWidget {
  ChatPage({super.key});

  @override
  ConsumerState<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends ConsumerState<ChatPage> {
  late TextEditingController message;

  @override
  void initState() {
    message = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    message.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final watch = ref.watch(getData);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            watch.when(
              data: (data) {
                return Expanded(
                    child: ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          return data[index].isMe as bool
                              ? SizedBox(
                                  width: 100,
                                  height: 60,
                                  child: Align(
                                    alignment: Alignment.topRight,
                                    child: Card(
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: Colors.blue,
                                            borderRadius: BorderRadius.only(
                                                bottomLeft: Radius.circular(20),
                                                topLeft: Radius.circular(20),
                                                topRight: Radius.circular(20))),
                                        width: 300,
                                        height: 100,
                                        child: Center(
                                          child: Text(
                                              data[index].message.toString()),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              : SizedBox(
                                  width: 100,
                                  height: 60,
                                  child: Align(
                                    alignment: Alignment.topLeft,
                                    child: Card(
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                                bottomRight:
                                                    Radius.circular(20),
                                                topLeft: Radius.circular(20),
                                                topRight: Radius.circular(20))),
                                        width: 300,
                                        height: 100,
                                        child: Center(
                                          child: Text(
                                              data[index].message.toString()),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                        }));
              },
              error: (error, stackTrace) {
                return Text("no data");
              },
              loading: () {
                return Center(child: CircularProgressIndicator());
              },
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                      width: MediaQuery.sizeOf(context).width * 0.8,
                      child: TextField(
                        controller: message,
                        decoration:
                            InputDecoration(border: OutlineInputBorder()),
                      )),
                ),
                IconButton(
                    onPressed: () async {
                      MessageModel messageModel = MessageModel(
                        message: message.text,
                      );
                      ref.read(messages).addMessage(messageModel);
                      message.clear();
                    },
                    icon: Icon(Icons.send))
              ],
            )
          ],
        ),
      ),
    );
  }
}
