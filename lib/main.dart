import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_code_helper/widgets/text_widget.dart';
import 'package:toast/toast.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'String helper',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController _textEditingController = TextEditingController();

  String androidXmlString, androidCodeString, dartCodeString = '';

  bool androidCodeVisible = false;
  bool dartCodeVisible = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('String helper'),
        centerTitle: false,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 24),
        color: Colors.white,
        child: Center(
          child: Column(
            children: [
              SizedBox(
                width: 400,
                child: TextField(
                  controller: _textEditingController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter String',
                  ),
                ),
              ),
              SizedBox(
                height: 12,
              ),
              ElevatedButton(
                onPressed: () {
                  generateDartStringCode();
                },
                child: TextWidget(
                  text: 'Generate Dart string code',
                  color: Colors.white,
                  textSize: 16,
                ),
                style: ButtonStyle(
                  padding: MaterialStateProperty.all(
                    EdgeInsets.symmetric(horizontal: 24, vertical: 18),
                  ),
                ),
              ),
              SizedBox(
                height: 6,
              ),
              Visibility(
                visible: dartCodeVisible,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextWidget(text: dartCodeString),
                    SizedBox(
                      width: 30,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Clipboard.setData(ClipboardData(text: dartCodeString));
                      },
                      child: TextWidget(
                        text: 'Copy dart code',
                        color: Colors.white,
                        textSize: 16,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 24,
              ),
              ElevatedButton(
                onPressed: () {
                  generateAndroidString();
                },
                child: TextWidget(
                  text: 'Generate android string code',
                  color: Colors.white,
                  textSize: 16,
                ),
                style: ButtonStyle(
                  padding: MaterialStateProperty.all(
                    EdgeInsets.symmetric(horizontal: 24, vertical: 18),
                  ),
                ),
              ),
              SizedBox(
                height: 6,
              ),
              Visibility(
                visible: androidCodeVisible,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextWidget(text: androidCodeString),
                        SizedBox(
                          width: 30,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Clipboard.setData(ClipboardData(text: androidCodeString));
                          },
                          child: TextWidget(
                            text: 'Copy code',
                            color: Colors.white,
                            textSize: 16,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextWidget(text: androidXmlString),
                        SizedBox(
                          width: 30,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Clipboard.setData(ClipboardData(text: androidXmlString));
                          },
                          child: TextWidget(
                            text: 'Copy xml code',
                            color: Colors.white,
                            textSize: 16,
                          ),
                        )
                      ],
                    ),
                    Visibility(
                      visible: false,
                      child: SizedBox(
                        width: 400,
                        child: Table(
                          children: [
                            TableRow(
                              children: [
                                TextWidget(text: androidCodeString),
                                ElevatedButton(
                                  onPressed: () {
                                    Clipboard.setData(ClipboardData(text: androidCodeString));
                                  },
                                  child: TextWidget(
                                    text: 'Copy code',
                                    color: Colors.white,
                                    textSize: 16,
                                  ),
                                ),
                              ],
                            ),
                            TableRow(children: [
                              SizedBox(
                                height: 12,
                              ),
                              SizedBox(
                                height: 12,
                              )
                            ]),
                            TableRow(
                              children: [
                                TextWidget(text: androidXmlString),
                                ElevatedButton(
                                  onPressed: () {
                                    Clipboard.setData(ClipboardData(text: androidXmlString));
                                  },
                                  child: TextWidget(
                                    text: 'Copy xml code',
                                    color: Colors.white,
                                    textSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  generateAndroidString() {
    getAndroidString();

    Toast.show('Android code generated!', context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    androidCodeVisible = true;
    setState(() {});
  }

  String getAndroidString() {
    String androidString = _textEditingController.text
        .trim()
        .toLowerCase()
        // .capitalizeFirstofEach
        .replaceAll(' ', '_');

    androidXmlString = '<string name=\"$androidString\">${_textEditingController.text}</string>';
    log('androidXmlString - $androidXmlString');
    androidString = 'R.string.' + androidString;
    androidCodeString = androidString;

    return androidString;
  }

  generateDartStringCode() {
    String dartString = _textEditingController.text.trim().toLowerCase().replaceAll(' ', '_').replaceAll('.', ' ');
    dartString = 'static String $dartString = \'${_textEditingController.text}\'';
    dartCodeString = dartString;
    // log(dartCodeString);
    dartCodeVisible = true;
    setState(() {});

    Toast.show('Dart code generated!', context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
  }
}
