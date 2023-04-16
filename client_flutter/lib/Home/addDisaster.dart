import 'package:client_flutter/Disaster/Addimage.dart';
import 'package:flutter/material.dart';

class AddDis extends StatefulWidget {
  const AddDis({Key? key}) : super(key: key);

  @override
  State<AddDis> createState() => _AddDisState();
}

class _AddDisState extends State<AddDis> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Add Tags"),
          centerTitle: true,
          backgroundColor: Colors.black,
        ),
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 30, top: 20, bottom: 20),
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
            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.black,
                    width: 2,
                  )),
              child: ExpansionTile(
                title: const Text('Pandemic',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                children: [
                  // const Divider(
                  //   color: Colors.black,
                  //   thickness: .5,
                  // ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AddImage()));
                    },
                    child: const ListTile(
                        title: Text(
                      'Hepatitis-B',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20),
                    )),
                  ),
                  const Divider(
                    color: Colors.black,
                    thickness: .5,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AddImage()));
                    },
                    child: const ListTile(
                        title: Text('Covid-19',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 20))),
                  ),
                  const Divider(
                    color: Colors.black,
                    thickness: .5,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AddImage()));
                    },
                    child: const ListTile(
                        title: Text('Chickenpox',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 20))),
                  ),
                  SizedBox(
                    height: 10,
                  )
                ],
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                  border: BorderDirectional(
                      bottom: BorderSide(width: 2, color: Colors.black),
                      end: BorderSide(width: 2, color: Colors.black),
                      start: BorderSide(width: 2, color: Colors.black))),
              child: ExpansionTile(
                title: const Text('Animal Sightings',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AddImage()));
                    },
                    child: const ListTile(
                        title: Text('Tiger',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 20))),
                  ),
                  const Divider(
                    color: Colors.black,
                    thickness: .5,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AddImage()));
                    },
                    child: const ListTile(
                        title: Text('Elephant',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 20))),
                  ),
                  SizedBox(
                    height: 10,
                  )
                ],
              ),
            ),
            InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AddImage()));
                },
                child: Container(
                    height: 65,
                    decoration: const BoxDecoration(
                        border: BorderDirectional(
                            bottom: BorderSide(width: 2, color: Colors.black),
                            end: BorderSide(width: 2, color: Colors.black),
                            start: BorderSide(width: 2, color: Colors.black))),
                    child: Row(
                      children: const [
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          'Flood',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ))),
            InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AddImage()));
                },
                child: Container(
                    height: 65,
                    decoration: const BoxDecoration(
                        border: BorderDirectional(
                            bottom: BorderSide(width: 2, color: Colors.black),
                            end: BorderSide(width: 2, color: Colors.black),
                            start: BorderSide(width: 2, color: Colors.black))),
                    child: Row(
                      children: const [
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          'Earthquake',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ))),
            InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AddImage()));
                },
                child: Container(
                    height: 65,
                    decoration: const BoxDecoration(
                        border: BorderDirectional(
                            bottom: BorderSide(width: 2, color: Colors.black),
                            end: BorderSide(width: 2, color: Colors.black),
                            start: BorderSide(width: 2, color: Colors.black))),
                    child: Row(
                      children: const [
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          'Landslide',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ))),InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AddImage()));
                },
                child: Container(
                    height: 65,
                    decoration: const BoxDecoration(
                        border: BorderDirectional(
                            bottom: BorderSide(width: 2, color: Colors.black),
                            end: BorderSide(width: 2, color: Colors.black),
                            start: BorderSide(width: 2, color: Colors.black))),
                    child: Row(
                      children: const [
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          'Other',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ],
                    )))
          ],
        ),
      ),
    );
  }
}