// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;
import 'package:provider/provider.dart';
import 'package:publisher_app/res/colors.dart';
import 'package:publisher_app/res/text_field/custom_text_field.dart';
import 'package:image_picker/image_picker.dart';
import '../data/API/api_calls.dart';
import '../data/provider/user_provider.dart';
import '../models/books_data.dart';
import '../utils/utils.dart';

class AddChapters extends StatefulWidget {
  const AddChapters({super.key});

  @override
  State<AddChapters> createState() => _AddChaptersState();
}

class _AddChaptersState extends State<AddChapters> {
  bool isLoading = false;
  final _key = GlobalKey<FormState>();
  final nameNode = FocusNode();
  final authorNode = FocusNode();
  final summeryNode = FocusNode();
  final isbnNode = FocusNode();
  final langNode = FocusNode();
  final genreNode = FocusNode();
  final btn2Node = FocusNode();
  List<File> images = [];
  final TextStyle txtStyle = const TextStyle(
    fontWeight: FontWeight.w800,
  );
  bool init = true;
  @override
  void dispose() {
    nameNode.dispose();
    authorNode.dispose();
    genreNode.dispose();
    langNode.dispose();
    summeryNode.dispose();
    isbnNode.dispose();
    btn2Node.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: darkBlueColor,
      appBar: AppBar(
        iconTheme: Theme.of(context).iconTheme,
        backgroundColor: darkBlueColor,
        centerTitle: true,
        title: const Text(
          'Add New Chapter',
          // :
          // 'Update Chapter',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w700,
            height: 0,
          ),
        ),
        actions: [
          isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : IconButton(
                  onPressed: () {
                    onSave();
                  },
                  icon: Icon(
                    'bv' == null ? Icons.save : Icons.update,
                    color: Colors.white,
                  ),
                ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: size.height * 0.03,
            ),
            Form(
              key: _key,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 20,
                ),
                child: Column(
                  children: [
                    CustomTextField(
                      text: 'Enter publisher name ',
                      thisNode: nameNode,
                      onSubmit: (v) {
                        FocusScope.of(context).requestFocus(summeryNode);
                      },
                      onValidate: (v) {
                        if (v!.isEmpty) {
                          return 'enter a name';
                        }
                        return null;
                      },
                      onSave: (v) {},
                    ),
                    SizedBox(
                      height: size.height * 0.027,
                    ),
                    CustomTextField(
                      text: 'Enter Summery ',
                      thisNode: summeryNode,
                      lines: 10,
                      textInputType: TextInputType.emailAddress,
                      onSubmit: (v) {
                        FocusScope.of(context).requestFocus(isbnNode);
                      },
                      onValidate: (v) {
                        if (v!.isEmpty) {
                          return 'enter text';
                        }
                        return null;
                      },
                      onSave: (v) {},
                    ),
                    SizedBox(
                      height: size.height * 0.027,
                    ),
                    CustomTextField(
                      text: 'Enter ISBN ',
                      thisNode: isbnNode,
                      textInputType: TextInputType.emailAddress,
                      onSubmit: (v) {
                        FocusScope.of(context).requestFocus();
                      },
                      onValidate: (v) {
                        if (v!.isEmpty) {
                          return 'enter a valid ISBN';
                        }
                        return null;
                      },
                      onSave: (v) {},
                    ),
                    SizedBox(
                      height: size.height * 0.027,
                    ),
                    CustomTextField(
                      text: 'Enter Genre ',
                      thisNode: genreNode,
                      textInputType: TextInputType.emailAddress,
                      onSubmit: (v) {
                        FocusScope.of(context).requestFocus();
                      },
                      onValidate: (v) {
                        if (v!.isEmpty) {
                          return 'enter a valid Genre';
                        }
                        return null;
                      },
                      onSave: (v) {},
                    ),
                    SizedBox(
                      height: size.height * 0.027,
                    ),
                    SizedBox(
                      height: size.height * 0.027,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(),
                      onPressed: () async {
                        List<XFile>? result =
                            await ImagePicker().pickMultiImage();
                        if (result.isNotEmpty) {
                          setState(() {
                            images = result.map((XFile file) {
                              String fileName = path.basename(file.path);
                              return File(fileName);
                            }).toList();
                          });
                        }
                      },
                      child: Text(
                        images.isEmpty
                            ? 'Upload Images'
                            : '${images.length} selected',
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.027,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onSave() async {
    UserProvider up = Provider.of<UserProvider>(context, listen: false);
    up.refreshUser();
    try {
      if (_key.currentState!.validate()) {
        if ("_bm.category" == '') {
          Utils().showToast('Gender is not selected');
          return;
        } else {
          setState(() {
            isLoading = true;
          });
          if ('bv ' != null) {
            Utils().showToast("ar.message");
          } else {
            Utils().showToast("ar.message");
          }
          setState(() {
            isLoading = false;
          });
        }
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      Utils().showToast(
        e.toString(),
      );
    }
  }
}
