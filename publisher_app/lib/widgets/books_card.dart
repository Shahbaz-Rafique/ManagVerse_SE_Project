import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:publisher_app/utils/utils.dart';

import '../models/book.dart';

class BookCard extends StatefulWidget {
  const BookCard({
    super.key,
  });
  @override
  State<BookCard> createState() => BookCardState();
}

class BookCardState extends State<BookCard> {
  @override
  Widget build(BuildContext context) {
    final BookValue d = Provider.of<BookValue>(context);
    return Card(
      child: ListTile(
        leading: const CircleAvatar(),
        title: Text(d.name.toString()),
        subtitle: Text(d.author.toString()),
        trailing: PopupMenuButton(
          itemBuilder: (context) => [
            PopupMenuItem(
              child: const Text('Edit'),
              onTap: () async {},
            ),
            PopupMenuItem(
              child: Text(d.active! ? 'In Active' : 'Active'),
              onTap: () async {
                try {} catch (e) {
                  Utils().showToast(e.toString());
                }
              },
            ),
            PopupMenuItem(
              child: const Text('Remove'),
              onTap: () async {
                try {} catch (e) {
                  Utils().showToast(e.toString());
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
