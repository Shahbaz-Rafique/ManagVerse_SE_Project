import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:user_app/models/novel.dart';
import 'package:user_app/res/buttons/custom_button.dart';

class ViewBookDetails extends StatefulWidget {
  const ViewBookDetails({super.key});

  @override
  State<ViewBookDetails> createState() => _ViewBookDetailsState();
}

class _ViewBookDetailsState extends State<ViewBookDetails> {
  @override
  Widget build(BuildContext context) {
    final bookValue = ModalRoute.of(context)!.settings!.arguments as Book?;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 428,
                height: 304,
                decoration: const ShapeDecoration(
                  color: Color(0xFF171B36),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15),
                    ),
                  ),
                ),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 150,
                        height: 150,
                        decoration: const BoxDecoration(),
                        child: bookValue!.images!.isEmpty
                            ? Image.asset(
                                'assets/images/Group.png',
                                color: Colors.white,
                              )
                            : Image.network(
                                bookValue.images!.first,
                              ),
                      ),
                      const Gap(10),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            bookValue!.name!,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontFamily: 'Cabin Condensed',
                              fontWeight: FontWeight.w400,
                              height: 0,
                            ),
                          ),
                          const Gap(10),
                          Text(
                            bookValue.genre!,
                            style: const TextStyle(
                              color: Color(0xFFDCDDE2),
                              fontSize: 16,
                              fontFamily: 'HK Grotesk',
                              fontWeight: FontWeight.w400,
                            ),
                            overflow: TextOverflow.ellipsis,
                            softWrap: true,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const Gap(20),
              Center(
                child: Container(
                  width: 348,
                  height: 92,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    shadows: const [
                      BoxShadow(
                        color: Color(0x3F000000),
                        blurRadius: 35,
                        offset: Offset(0, 0),
                        spreadRadius: 0,
                      )
                    ],
                  ),
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Author",
                          style: TextStyle(
                            color: Color(0xFF9091A0),
                            fontSize: 14,
                            fontFamily: 'HK Grotesk',
                            fontWeight: FontWeight.w400,
                            height: 0,
                          ),
                        ),
                        Text(
                          bookValue.author!,
                          style: const TextStyle(
                            color: Color(0xFF4D506C),
                            fontSize: 24,
                            fontFamily: 'HK Grotesk',
                            fontWeight: FontWeight.w600,
                            height: 0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const Gap(20),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'About The Novel',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Color(0xFF4D506C),
                    fontSize: 18,
                    fontFamily: 'Cabin Condensed',
                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
                ),
              ),
              const Gap(20),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  bookValue!.summery!,
                  style: const TextStyle(
                    color: Color(0xFF9091A0),
                    fontSize: 14,
                    fontFamily: 'HK Grotesk',
                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Images',
                  style: TextStyle(
                    color: Color(0xFF4D506C),
                    fontSize: 18,
                    fontFamily: 'HK Grotesk',
                    fontWeight: FontWeight.w600,
                    height: 0,
                  ),
                ),
              ),
              bookValue.images!.isNotEmpty
                  ? SizedBox(
                      height: 300,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: bookValue.images!.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            height: 100,
                            margin: const EdgeInsets.all(5),
                            decoration: const BoxDecoration(),
                            // color: Colors.amber,
                            child: Container(
                              decoration: const BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0x3F000000),
                                    // blurStyle: BlurStyle.outer,
                                    blurRadius: 10,
                                    offset: Offset(0, 10),
                                    spreadRadius: 0,
                                  ),
                                ],
                              ),
                              child: bookValue.images!.isEmpty
                                  ? Image.asset(
                                      'assets/images/bg.png',
                                      // color: Colors.blue,
                                    )
                                  : Image.network(
                                      bookValue.images![index].toString(),
                                      // color: Colors.green,
                                    ),
                            ),
                          );
                        },
                      ),
                    )
                  : const Center(
                      child: Text('Images Not Available'),
                    ),
              const Gap(20),
              bookValue.chapters!.isNotEmpty
                  ? Column(
                      children: [
                        CustomButton(text: 'View Book', onClick: () {}),
                      ],
                    )
                  : const Center(
                      child: Text(
                          'Book is currently  Not Available for read or Download'),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
