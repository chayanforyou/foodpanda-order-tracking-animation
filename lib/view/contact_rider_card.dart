import 'package:flutter/material.dart';

class ContactRiderCard extends StatelessWidget {
  const ContactRiderCard({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(3),
      ),
      leading: Image.asset('assets/images/avatar.png'),
      title: const Text('Contact your rider'),
      subtitle: const Text('Add delivery instructions'),
      trailing: const Icon(
        Icons.message_outlined,
        size: 30,
        color: Colors.pink,
      ),
      titleTextStyle: const TextStyle(
        fontSize: 18,
        color: Colors.black,
        fontWeight: FontWeight.w500,
      ),
      subtitleTextStyle: const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w300,
      ),
    );
  }
}
