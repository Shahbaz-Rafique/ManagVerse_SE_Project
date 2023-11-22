import 'package:flutter/material.dart';
import 'package:publisher_app/models/book.dart';
import 'package:publisher_app/res/routes/route_name.dart';

class ViewBookDetailed extends StatefulWidget {
  const ViewBookDetailed({super.key});

  @override
  State<ViewBookDetailed> createState() => _ViewBookDetailedState();
}

class _ViewBookDetailedState extends State<ViewBookDetailed> {
  @override
  Widget build(BuildContext context) {
    BookValue? bVal = ModalRoute.of(context)!.settings.arguments as BookValue?;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(bVal!.name.toString()),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(RouteName.addChapter);
            },
            icon: const Icon(Icons.add),
            tooltip: 'Add Chapters',
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.edit),
            tooltip: 'Edit Book Details',
          ),
        ],
      ),
    );
  }
}
