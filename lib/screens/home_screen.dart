import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cross_file_image/cross_file_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../models/item.dart';
import '../utils/app_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ImagePicker _picker = ImagePicker();
  XFile? _image;

  TextEditingController _textEditingController = TextEditingController();

  List<Item> _list = [];

  String _today = DateFormat('yyyyMMdd').format(DateTime.now());

  CollectionReference _itemCol = FirebaseFirestore.instance.collection('items');

  @override
  void initState() {
    init();
  }

  Future<void> init() async {
    if (FirebaseAuth.instance.currentUser == null) {
      await FirebaseAuth.instance.signInAnonymously();
    }
    await getItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("lunch_vote")),
      body: ListView.builder(
        itemCount: _list.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Image.network(_list[index].pictureUrl),
            title: Text(_list[index].name),
            trailing: Wrap(
              children: [
                Text(_list[index].unlike.toString()),
                IconButton(onPressed: () {}, icon: Icon(Icons.thumb_down)),
                Text(_list[index].like.toString()),
                IconButton(onPressed: () {}, icon: Icon(Icons.thumb_up))
              ],
            ),
          );
        },
      ),
      bottomSheet: Row(
        children: [
          _image != null
              ? Stack(
                  alignment: Alignment.topRight,
                  children: [
                    Image(
                      height: 50,
                      fit: BoxFit.fitHeight,
                      image: XFileImage(_image!),
                    ),
                    IconButton(
                        onPressed: () {
                          setState(() {
                            _image = null;
                          });
                        },
                        icon: Icon(
                          Icons.remove_circle,
                          color: Colors.redAccent,
                        )),
                  ],
                )
              : IconButton(
                  onPressed: () async {
                    _image =
                        await _picker.pickImage(source: ImageSource.gallery);
                    setState(() {});
                  },
                  icon: Icon(Icons.image),
                ),
          Expanded(
              child: TextField(
            controller: _textEditingController,
          )),
          IconButton(
            onPressed: () async {
              String imageUrl = await AppService.uploadFileToStorage(_image);
              await writeItem(
                  Item(_textEditingController.text, imageUrl, 0, 0));
              await getItems();
            },
            icon: Icon(Icons.send),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            getItems();
          },
          child: Icon(Icons.refresh)),
    );
  }

  Future<void> getItems() async {
    var result = await _itemCol.doc(_today).get();
    var dataList = result["list"];
    _list.clear();
    for (dynamic row in dataList) {
      _list.add(
        Item(
          row["name"],
          row["pictureUrl"],
          row["like"],
          row["unlike"],
        ),
      );
    }
    setState(() {});
  }

  Future<void> writeItem(Item item) async {
    await _itemCol.doc(_today).update({
      "list": FieldValue.arrayUnion([
        {
          "name": item.name,
          "pictureUrl": item.pictureUrl,
          "like": item.like,
          "unlike": item.unlike,
        }
      ])
    }).then((value) {
      // success
      print("success");
    }, onError: (e, st) async {
      await _itemCol.doc(_today).set({
        "list": FieldValue.arrayUnion([
          {
            "name": item.name,
            "pictureUrl": item.pictureUrl,
            "like": item.like,
            "unlike": item.unlike,
          }
        ])
      });
    });
    _textEditingController.text = "";
  }
}
