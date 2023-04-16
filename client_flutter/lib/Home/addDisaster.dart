import 'package:flutter/material.dart';

class AddDis extends StatefulWidget {
  const AddDis({Key? key}) : super(key: key);

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

  TextEditingController testName = TextEditingController();
  TextEditingController testPhone = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Tags"),
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
          Padding(
            padding: const EdgeInsets.all(20),
            child: DropdownButtonFormField(
                decoration: InputDecoration(
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
                  selectedLetter = value as String?;
                }),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: OutlinedButton(
                style: ButtonStyle(
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
                    side: MaterialStateProperty.all(
                        BorderSide(color: Colors.black, width: 3)),
                    foregroundColor: MaterialStateProperty.all(Colors.black),
                    minimumSize: MaterialStateProperty.all(Size(200, 50)),
                    textStyle: MaterialStateProperty.all(
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 19))),
                onPressed: () {},
                child: Text("Add Images")),
          ),
          SizedBox(
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
                    minimumSize: MaterialStateProperty.all(Size(100, 50)),
                    textStyle: MaterialStateProperty.all(TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ))),
                onPressed: () {
                  if (selectedLetter != null &&
                      testName.text != "" &&
                      testPhone.text != "") {
                    Navigator.pop(context);
                  }
                },
                child: Text("Submit")),
          ),
        ],
      ),
    );
  }
}