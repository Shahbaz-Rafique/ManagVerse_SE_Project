// ignore_for_file: deprecated_member_use

import 'package:publisher_app/res/colors.dart';

import '../res/routes/route_name.dart';
import '../view Model/provider/user_provider.dart';
import '../widgets/chart.dart';
import 'drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Map<String, double> dataMap = {
    "Total": 5,
    "active": 3,
    "inactive": 2,
  };
  @override
  Widget build(BuildContext context) {
    UserProvider up = Provider.of<UserProvider>(context, listen: false);
    up.refreshUser();

    return Scaffold(
      drawer: const MyDrawer(),
      appBar: AppBar(
        leading: const SizedBox(),
        title: const Text('Dashboard'),
        centerTitle: true,
        actions: [
          Builder(
            builder: (context) => IconButton(
              onPressed: () async {
                Scaffold.of(context).openDrawer();
              },
              icon: const Icon(Icons.menu),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.sizeOf(context).height * 0.37,
              color: Colors.grey.shade200,
              child: Expanded(
                child: PIChart(
                  data: dataMap,
                  chartName: 'Books',
                ),
              ),
            ),
            SizedBox(
              height: 200,
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          RouteName.addBook,
                        );
                      },
                      child: Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: darkBlueColor,
                        ),
                        child: const Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          RouteName.manageBooks,
                        );
                      },
                      child: Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: darkBlueColor,
                        ),
                        child: const Icon(
                          Icons.book,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
