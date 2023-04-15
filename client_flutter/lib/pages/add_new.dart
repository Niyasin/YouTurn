import 'package:client_flutter/pages/home_page.dart';
import 'package:client_flutter/provider/tag_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class AddDis extends StatefulWidget {
  final TextEditingController textEditingController;
  const AddDis({Key? key, required this.textEditingController})
      : super(key: key);

  @override
  State<AddDis> createState() => _AddDisState();
}

class _AddDisState extends State<AddDis> {
  final tags = [
    'Road Block',
    'Landslide',
    'Tiger',
    'Downed powerline',
    'Other',
  ];
  String? selectedLetter;

  @override
  Widget build(BuildContext context) {
    var tagProvider = Provider.of<TagProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Tags"),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 30, top: 20),
            child: Row(
              children: const [
                Text("Select the type : ",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20)),
              ],
            ),
          ),
          //drop down to choose disaster type
          Padding(
            padding: const EdgeInsets.all(20),
            child: DropdownButtonFormField(
                decoration: const InputDecoration(
                  label: Text("Select from the dropdown"),
                ),
                borderRadius: BorderRadius.circular(20),
                autofocus: true,
                items: tags
                    .map((e) => DropdownMenuItem(
                          value: e,
                          child: Text(e),
                        ))
                    .toList(),
                onChanged: (value) {
                  tagProvider
                      .addType(value ?? "default"); // changing disaster type
                }),
          ),
          const SizedBox(
            height: 20,
          ),
          const Padding(
            padding: EdgeInsets.only(left: 20, bottom: 6),
            child: Text(
              "Add a description:",
              style: TextStyle(),
            ),
          ),
          //text box for description
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextFormField(
              controller: textEditingController,
              decoration: const InputDecoration(border: OutlineInputBorder()),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: OutlinedButton(
                style: ButtonStyle(
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
                    side: MaterialStateProperty.all(
                        const BorderSide(color: Colors.black, width: 3)),
                    foregroundColor: MaterialStateProperty.all(Colors.black),
                    minimumSize: MaterialStateProperty.all(const Size(200, 50)),
                    textStyle: MaterialStateProperty.all(const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 19))),
                onPressed: () {},
                child: const Text("Add Images")),
          ),
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(50, 15, 50, 0),
            child: ElevatedButton(
                style: ButtonStyle(
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30))),
                    foregroundColor: MaterialStateProperty.all(Colors.white),
                    backgroundColor: MaterialStateProperty.all(Colors.black),
                    minimumSize: MaterialStateProperty.all(const Size(100, 50)),
                    textStyle: MaterialStateProperty.all(const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ))),
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const HomeApp()));
                },
                child: const Text("Submit")),
          ),
        ],
      ),
    );
  }
}
