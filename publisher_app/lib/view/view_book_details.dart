import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:publisher_app/models/book.dart';
import 'package:publisher_app/res/routes/route_name.dart';
import 'package:publisher_app/view%20Model/API/api_calls.dart';
import 'package:publisher_app/widgets/chapter_card.dart';
import 'package:publisher_app/widgets/custum_tile.dart';

class ViewBookDetailed extends StatefulWidget {
  const ViewBookDetailed({super.key});

  @override
  State<ViewBookDetailed> createState() => _ViewBookDetailedState();
}

class _ViewBookDetailedState extends State<ViewBookDetailed> {
  int idx = 0;
  @override
  Widget build(BuildContext context) {
    BookValue? bVal = ModalRoute.of(context)!.settings.arguments as BookValue?;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(bVal!.name.toString()),
          bottom: const TabBar(
            indicatorSize: TabBarIndicatorSize.tab,
            tabs: [
              Tab(
                icon: Icon(Icons.info_outline),
                child: Text("Details"),
              ),
              Tab(
                icon: Icon(Icons.book_outlined),
                child: Text("Books"),
              ),
            ],
          ),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.of(context)
                    .pushNamed(RouteName.addChapter, arguments: bVal.sId);
              },
              icon: const Icon(Icons.add),
              tooltip: 'Add Chapters',
            ),
            IconButton(
              onPressed: () {
                Navigator.of(context)
                    .pushNamed(RouteName.addBook, arguments: bVal);
              },
              icon: const Icon(Icons.edit),
              tooltip: 'Edit Book Details',
            ),
          ],
        ),
        body: TabBarView(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: ListView(
                children: [
                  Container(
                    width: double.infinity,
                    height: 200,
                    decoration: const BoxDecoration(
                        // color: Colors.black,
                        ),
                    child: bVal.images!.isEmpty
                        ? Image.asset(
                            'assets/images/Group.png',
                            fit: BoxFit.contain,
                            color: Colors.black,
                          )
                        : Image.network(
                            bVal.images![idx].toString(),
                            fit: BoxFit.contain,
                            // color: Colors.black,
                          ),
                  ),
                  const Gap(10),
                  SizedBox(
                    height: 70,
                    child: ListView.builder(
                      itemCount: bVal.images!.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            idx = index;
                            setState(() {});
                          },
                          child: Container(
                            width: 50,
                            margin: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: index == idx
                                  ? Border.all(width: 2, color: Colors.red)
                                  : Border.all(width: 1, color: Colors.black),
                            ),
                            child: bVal.images!.isEmpty
                                ? Image.asset(
                                    'assets/images/Group.png',
                                    color: Colors.black,
                                  )
                                : ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(
                                      bVal.images![index].toString(),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                          ),
                        );
                      },
                    ),
                  ),
                  CustomTile(
                    title: 'Name',
                    value: bVal.name.toString(),
                  ),
                  CustomTile(
                    title: 'Summery',
                    value: bVal.summery!,
                  ),
                  CustomTile(
                    title: 'Author ame',
                    value: bVal.author.toString(),
                  ),
                  CustomTile(
                    title: 'ISBN Number',
                    value: bVal.iSBN.toString(),
                  ),
                  CustomTile(
                    title: 'Genre',
                    value: bVal.genre.toString(),
                  ),
                  const Text(
                    'Chapters',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            FutureBuilder(
              future: Provider.of<APICalls>(context, listen: false)
                  .getChapters(bVal.sId!),
              builder: (BuildContext context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text(snapshot.error.toString()),
                  );
                } else {
                  if (snapshot.data!.data!.isEmpty) {
                    return const Center(
                      child: Text('No document Found'),
                    );
                  }
                  return ListView.builder(
                    itemCount: snapshot.data!.data!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ChapterCard(
                        onClick: onClick,
                        chapter: snapshot.data!.data![index],
                      );
                    },
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  onClick() {
    setState(() {});
  }
}
