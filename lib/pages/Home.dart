import 'dart:collection';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:we_helper_1/controller/ThemeProvider.dart';
import 'package:we_helper_1/core/linkedListEntery.dart';
import 'package:we_helper_1/modules/CstData.dart';
import 'package:we_helper_1/pages/Breaks.dart';
import 'package:we_helper_1/pages/multiOpener.dart';
import 'package:we_helper_1/pages/settings/QuickOpen.dart';
import 'package:we_helper_1/utils/pagginationHelper.dart';

import 'SideBar.dart/SideBar.main.dart';

enum InputType { any, number, landlinePhone }

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PagginationHelper pagginationHelper =
      PagginationHelper(list: [CstData()]);

  final cstName = TextEditingController();
  final cstId = TextEditingController();
  final cstAccount = TextEditingController();
  final cstAdslNumber = TextEditingController();
  final cstFirstPhoneNumber = TextEditingController();
  final cstSecondPhoneNumberName = TextEditingController();
  final comment = TextEditingController();

  final agentNoteController = TextEditingController();

  CstData get getFromForm => CstData(
        cstName: cstName.text,
        cstId: cstId.text,
        cstAdslNumber: cstAdslNumber.text,
        cstAccount: cstAccount.text,
        comment: comment.text,
        cstFirstPhoneNumber: cstFirstPhoneNumber.text,
        cstSecondPhoneNumberName: cstSecondPhoneNumberName.text,
      );

  void newForm() {
    if (cstName.text.isNotEmpty ||
        cstId.text.isNotEmpty ||
        cstAccount.text.isNotEmpty ||
        comment.text.isNotEmpty ||
        cstFirstPhoneNumber.text.isNotEmpty ||
        cstSecondPhoneNumberName.text.isNotEmpty) {
      getByCst(pagginationHelper.addData(getFromForm));
    } else {
      return;
    }
  }

  void getByCst(CstData cstdata) {
    cstName.text = cstdata.cstName;
    cstId.text = cstdata.cstId;
    cstAccount.text = cstdata.cstAccount;
    cstAdslNumber.text = cstdata.cstAdslNumber;
    cstFirstPhoneNumber.text = cstdata.cstFirstPhoneNumber;
    cstSecondPhoneNumberName.text = cstdata.cstSecondPhoneNumberName;
    comment.text = cstdata.comment;
    setState(() {});
  }

  final MyLinkedList<FocusNode> focuses = MyLinkedList([
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
  ]);

  @override
  Widget build(BuildContext context) {
    // Container(
    //     height: 50,
    //   ),
    //   separetor,

    final formFields = [
      DetailsField(
          autoFocus: true,
          focusIndex: 0,
          focusNode: focuses,
          label: "Name",
          controller: cstName),
      DetailsField(
          focusIndex: 1,
          focusNode: focuses,
          inputType: InputType.landlinePhone,
          label: "ADSL Number",
          controller: cstAdslNumber),
      DetailsField(
          focusIndex: 2,
          focusNode: focuses,
          label: "Account Number",
          controller: cstAccount),
      DetailsField(
          focusIndex: 3,
          focusNode: focuses,
          inputType: InputType.number,
          label: "Caller ID",
          controller: cstId),
      DetailsField(
          focusIndex: 4,
          focusNode: focuses,
          inputType: InputType.number,
          label: "First Mobile",
          controller: cstFirstPhoneNumber),
      DetailsField(
          focusIndex: 5,
          focusNode: focuses,
          inputType: InputType.number,
          label: "Second Mobile",
          controller: cstSecondPhoneNumberName),
      DetailsField(
          focusIndex: 6,
          focusNode: focuses,
          label: "Comment",
          controller: comment,
          lines: 3),
    ].map((e) => Column(children: [separetor, e])).toList();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        actions: [
          // IconButton(
          //   icon: Icon(Icons.light_mode),
          //   onPressed: () {
          //     // UserTheme().toggleBrightness(context);
          //   },
          // ),

          IconButton(
              onPressed: () {
                showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  builder: (c) =>
                      AgentNote(agentNoteController: agentNoteController),
                );
              },
              icon: Icon(FontAwesome.user_circle)),

          IconButton(
            icon: Icon(FontAwesome5Solid.tools),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (c) => QuickOpener(),
                ),
              );
            },
          ),
          SizedBox(width: 20)
        ],
        title: Text("we helper"),
        elevation: 0,
      ),
      drawer: Drawer(
        child: MultiOpener(),
      ),
      body: Row(
        textDirection: TextDirection.rtl,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // BreakSide(),
          SideBar(),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(10),
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Focus(canRequestFocus: false, child: pageController),
                    Focus(
                      onKey: (_, RawKeyEvent event) {
                        // print(event);
                        if (event.runtimeType.toString() == "RawKeyDownEvent" &&
                            event.physicalKey == PhysicalKeyboardKey.enter) {
                          ScaffoldMessenger.of(context).hideCurrentSnackBar();

                          if (cstAdslNumber.text.isNotEmpty) {
                            if (int.tryParse(cstAdslNumber.text) == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text(
                                          "adsl number must be integer only")));
                            } else if (cstAdslNumber.text.length <= 10) {
                              QuickOpenSettingsData.openTools(
                                  cstAdslNumber.text);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  content: Text(
                                      "more than normal by : ${(cstAdslNumber.text.length) - 10}")));
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("adsl number needed")));
                          }

                          return KeyEventResult.handled;
                        } else {
                          return KeyEventResult.ignored;
                        }
                      },
                      child: Form(
                          autovalidateMode: AutovalidateMode.always,
                          child: Column(
                            children: formFields,
                          )),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget get separetor => SizedBox(height: 10);

  Row get pageController {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: pagginationHelper.isFirest
                  ? null
                  : () {
                      pagginationHelper.save(getFromForm);
                      getByCst(pagginationHelper.getFirest);
                      focuses.list[0].requestFocus();
                    },
              mouseCursor: pagginationHelper.isFirest
                  ? SystemMouseCursors.forbidden
                  : SystemMouseCursors.click,
              icon: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(AntDesign.doubleleft),
                ],
              ),
            ),
            IconButton(
              onPressed: pagginationHelper.isPrev
                  ? () {
                      pagginationHelper.save(getFromForm);

                      getByCst(pagginationHelper.getPrev);
                      focuses.list[0].requestFocus();
                    }
                  : null,
              mouseCursor: pagginationHelper.isPrev
                  ? SystemMouseCursors.click
                  : SystemMouseCursors.forbidden,
              icon: Icon(AntDesign.left),
            ),
            IconButton(
              onPressed: pagginationHelper.isNext
                  ? () {
                      pagginationHelper.save(getFromForm);

                      getByCst(pagginationHelper.getNext);
                      focuses.list[0].requestFocus();
                    }
                  : null,
              mouseCursor: pagginationHelper.isNext
                  ? SystemMouseCursors.click
                  : SystemMouseCursors.forbidden,
              icon: Icon(AntDesign.right),
            ),
            IconButton(
              onPressed: pagginationHelper.isLast
                  ? null
                  : () {
                      pagginationHelper.save(getFromForm);

                      getByCst(pagginationHelper.getLast);
                      focuses.list[0].requestFocus();
                    },
              mouseCursor: pagginationHelper.isLast
                  ? SystemMouseCursors.forbidden
                  : SystemMouseCursors.click,
              icon: Icon(AntDesign.doubleright),
            ),
            IconButton(
              onPressed: () {
                getByCst(pagginationHelper.delete);
                focuses.list[0].requestFocus();
              },
              icon: Icon(AntDesign.delete),
            ),
          ],
        ),
        ElevatedButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.red)),
          onPressed: () {
            newForm();
            focuses.list[0].requestFocus();
          },
          child: Text(
            "New",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}

class AgentNote extends StatelessWidget {
  final TextEditingController agentNoteController;
  const AgentNote({
    Key? key,
    required this.agentNoteController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * .9,
      child: Column(
        children: [
          AppBar(
            elevation: 0,
            centerTitle: true,
            title: Text(
              "Agent Notes",
              style: TextStyle(fontSize: 25),
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(10),
              color: Colors.black.withOpacity(.1),
              child: TextFormField(
                expands: true,
                maxLines: null,
                controller: agentNoteController,
                decoration: InputDecoration(
                    hintText: "Note",
                    fillColor: Colors.white,
                    border: InputBorder.none),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DetailsField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final int? lines;
  final InputType inputType;
  final MyLinkedList focusNode;
  final focusIndex;
  final bool autoFocus;
  DetailsField({
    Key? key,
    this.autoFocus = false,
    required this.label,
    required this.controller,
    this.lines,
    this.inputType = InputType.any,
    required this.focusNode,
    required this.focusIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Focus(
      onFocusChange: (c) {},
      onKey: (_, RawKeyEvent event) {
        // print(event);
        if (event.runtimeType.toString() == "RawKeyDownEvent" &&
            event.physicalKey == PhysicalKeyboardKey.tab) {
          (focusNode.next(focusNode.list[focusIndex]) as FocusNode)
              .requestFocus();
          return KeyEventResult.handled;
        } else {
          return KeyEventResult.ignored;
        }
      },
      child: TextFormField(
        autofocus: autoFocus,
        focusNode: (focusNode.list[focusIndex] as FocusNode),
        keyboardType: lines != null ? TextInputType.multiline : null,
        maxLines: null,
        minLines: lines,
        controller: controller,
        validator: (s) {
          switch (inputType) {
            case InputType.landlinePhone:
              if (s != null) {
                if (s.isNotEmpty && int.tryParse(s) == null) {
                  return "integer numbers only";
                } else if (s.length <= 10) {
                  return null;
                } else {
                  return "more than normal by : ${(s.length) - 10}";
                }
              } else {
                return null;
              }
            case InputType.number:
              if (s != null) {
                if (s.isNotEmpty && int.tryParse(s) == null) {
                  return "integer numbers only";
                } else if (s.isNotEmpty && s.length > 11) {
                  return "more than normal by : ${(s.length) - 11}";
                } else {
                  return null;
                }
              } else {
                return null;
              }

            default:
              return null;
          }
        },
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  String? numberValidator(String? s) =>
      s != null && s.isNotEmpty && double.tryParse(s) == null
          ? "need number not string"
          : null;
}
