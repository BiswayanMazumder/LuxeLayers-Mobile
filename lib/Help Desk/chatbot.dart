import 'package:flutter/material.dart';
class ChatBot extends StatefulWidget {
  final String name;
  final String imageUrl;
  // final String orderid;
  // final bool isdelivered;
  final int price;
  // final String productid;
  const ChatBot({
    Key? key,
    required this.name,
    // required this.orderid,
    required this.imageUrl,
    // required this.isdelivered,
    required this.price,
    // required this.productid
  }) : super(key: key);

  @override
  State<ChatBot> createState() => _ChatBotState();
}

class _ChatBotState extends State<ChatBot> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
