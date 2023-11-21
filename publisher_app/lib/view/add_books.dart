// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;
import 'package:provider/provider.dart';
import 'package:publisher_app/data/firebase_methods.dart';
import 'package:publisher_app/models/author_model.dart' as a;
import 'package:publisher_app/models/author_response.dart';
import 'package:publisher_app/models/book.dart';
import 'package:publisher_app/res/colors.dart';
import 'package:publisher_app/res/text_field/custom_text_field.dart';
import 'package:image_picker/image_picker.dart';
import '../data/API/api_calls.dart';
import '../data/provider/user_provider.dart';
import '../models/books_data.dart';
import '../utils/utils.dart';

class AddBooks extends StatefulWidget {
  const AddBooks({super.key});

  @override
  State<AddBooks> createState() => _AddBooksState();
}

class _AddBooksState extends State<AddBooks> {
  bool isLoading = false;
  String selectedValue = 'Option 1';
  final _key = GlobalKey<FormState>();
  final nameNode = FocusNode();
  final authorNode = FocusNode();
  final summeryNode = FocusNode();
  final isbnNode = FocusNode();
  final langNode = FocusNode();
  final genreNode = FocusNode();
  final btn2Node = FocusNode();
  List<File> images = [];
  BookModel _bm = BookModel(
    name: '',
    author: '',
    publisher: '',
    summery: '',
    category: '',
    images: [],
    iSBN: '',
    language: '',
    genre: '',
  );
  a.Authors aut = a.Authors();
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
          'Add New Author',
          style: TextStyle(
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
                  icon: const Icon(
                    Icons.save,
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
                      onSave: (v) {
                        _bm = BookModel(
                          author: _bm.author,
                          category: _bm.category,
                          name: v.toString(),
                          publisher: _bm.publisher,
                          summery: _bm.summery,
                          images: _bm.images,
                          iSBN: _bm.iSBN,
                          language: _bm.language,
                          genre: _bm.genre,
                        );
                      },
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
                      onSave: (v) {
                        _bm = BookModel(
                          author: _bm.author,
                          category: _bm.category,
                          name: _bm.name,
                          publisher: _bm.publisher,
                          summery: v.toString(),
                          images: _bm.images,
                          iSBN: _bm.iSBN,
                          language: _bm.language,
                          genre: _bm.genre,
                        );
                      },
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
                      onSave: (v) {
                        _bm = BookModel(
                          author: _bm.author,
                          category: _bm.category,
                          name: _bm.name,
                          publisher: _bm.publisher,
                          summery: _bm.summery,
                          images: _bm.images,
                          iSBN: v.toString(),
                          language: _bm.language,
                          genre: _bm.genre,
                        );
                      },
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
                      onSave: (v) {
                        _bm = BookModel(
                          author: _bm.author,
                          category: _bm.category,
                          name: _bm.name,
                          publisher: _bm.publisher,
                          summery: _bm.summery,
                          images: _bm.images,
                          iSBN: _bm.iSBN,
                          language: _bm.language,
                          genre: v.toString(),
                        );
                      },
                    ),
                    SizedBox(
                      height: size.height * 0.027,
                    ),
                    CustomTextField(
                      text: 'Enter an Author name ',
                      thisNode: authorNode,
                      textInputType: TextInputType.emailAddress,
                      onSubmit: (v) {
                        FocusScope.of(context).requestFocus();
                      },
                      onValidate: (v) {
                        if (v!.isEmpty) {
                          return 'enter a name';
                        }
                        return null;
                      },
                      onSave: (v) {
                        _bm = BookModel(
                          author: v,
                          category: _bm.category,
                          name: _bm.name,
                          publisher: _bm.publisher,
                          summery: _bm.summery,
                          images: _bm.images,
                          iSBN: _bm.iSBN,
                          language: _bm.language,
                          genre: _bm.genre,
                        );
                      },
                    ),
                    SizedBox(
                      height: size.height * 0.027,
                    ),
                    CustomTextField(
                      text: 'Enter Language ',
                      thisNode: langNode,
                      textInputType: TextInputType.emailAddress,
                      onSubmit: (v) {
                        FocusScope.of(context).requestFocus();
                      },
                      onValidate: (v) {
                        if (v!.isEmpty) {
                          return 'enter a valid text';
                        }
                        return null;
                      },
                      onSave: (v) {
                        _bm = BookModel(
                          author: _bm.author,
                          category: _bm.category,
                          name: _bm.name,
                          publisher: _bm.publisher,
                          summery: _bm.summery,
                          images: _bm.images,
                          iSBN: _bm.iSBN,
                          language: v.toString(),
                          genre: _bm.genre,
                        );
                      },
                    ),
                    SizedBox(
                      height: size.height * 0.027,
                    ),
                    const Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Category : ',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w800,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 70,
                      child: Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  _bm = BookModel(
                                    author: _bm.author,
                                    category: 'novel',
                                    name: _bm.name,
                                    publisher: _bm.publisher,
                                    summery: _bm.summery,
                                    images: _bm.images,
                                    iSBN: _bm.iSBN,
                                    language: _bm.language,
                                    genre: _bm.genre,
                                  );
                                });
                              },
                              child: Container(
                                alignment: Alignment.center,
                                width: double.infinity,
                                height: 40,
                                margin: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  color: _bm.category == 'novel'
                                      ? Colors.black
                                      : Colors.black.withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Text(
                                  'Novel',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w800,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  _bm = BookModel(
                                    author: _bm.author,
                                    category: 'comics',
                                    name: _bm.name,
                                    publisher: _bm.publisher,
                                    summery: _bm.summery,
                                    images: _bm.images,
                                    iSBN: _bm.iSBN,
                                    language: _bm.language,
                                    genre: _bm.genre,
                                  );
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: _bm.category == 'comics'
                                      ? Colors.black
                                      : Colors.black.withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                alignment: Alignment.center,
                                margin: const EdgeInsets.all(5),
                                width: double.infinity,
                                height: 40,
                                child: const Text(
                                  'Comics',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w800,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
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
        if (_bm.category == '') {
          Utils().showToast('Gender is not selected');
          return;
        } else {
          setState(() {
            isLoading = true;
          });
          _bm = BookModel(
            author: _bm.author,
            category: 'comics',
            name: _bm.name,
            publisher: up.getPublisher!.id,
            summery: _bm.summery,
            images: _bm.images,
            iSBN: _bm.iSBN,
            language: _bm.language,
            genre: _bm.genre,
          );

          _key.currentState!.save();
//          for (File element in images) {
            // String pa =
            //     await Provider.of<FireBaseMethods>(context, listen: false)
            //         .uploadPost(
            //   'bookImages/',
            //   '${up.getPublisher!.id}/${path.basename(element.path)}',
            //   element,
            // );
            // _bm.images!.add(pa);
  //        }
          AuthorResponse ar =
              await Provider.of<APICalls>(context, listen: false)
                  .uploadBooks(_bm);
          Utils().showToast(ar.message);
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
