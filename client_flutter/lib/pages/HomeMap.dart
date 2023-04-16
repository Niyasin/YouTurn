//This is the first page of the app

import 'package:client_flutter/pages/add_new.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:google_sign_in/google_sign_in.dart';
//import 'package:latlong/latlong.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
//import '../controllers/bottom_sheet.dart';

import '../Login/loginGoogle.dart';
import '../components/current_location.dart';
import '../provider/tag_provider.dart';

class HomeMap extends StatefulWidget {
  const HomeMap({Key? key}) : super(key: key);

  @override
  State<HomeMap> createState() => _HomeMapState();
}

class _HomeMapState extends State<HomeMap> {
  LatLng point = LatLng(49.5, -0.09);
  Color theme1 = Colors.black;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  final GoogleSignIn _googleSignIn = GoogleSignIn();

  @override
  Widget build(BuildContext context) {
    var tagProvider = Provider.of<TagProvider>(context);

    return Scaffold(
      key: scaffoldKey,
      drawer: Drawer(
        backgroundColor: Colors.white,
        child: ListView(
          children: [
            const UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: Colors.white),
              accountName: Text("Clement Mathew",
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold)),
              accountEmail: Text("clementmathew@gmail.com",
                  style: TextStyle(color: Colors.black)),
              currentAccountPicture:
                  CircleAvatar(backgroundColor: Colors.black),
            ),
            Container(width: double.infinity, color: Colors.black, height: 5),
            ListTile(
              leading: Icon(Icons.person, color: theme1),
              title: Text("Profile",
                  style: TextStyle(
                      color: theme1,
                      fontWeight: FontWeight.bold,
                      fontSize: 15)),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.chat, color: theme1),
              title: Text("Feedback",
                  style: TextStyle(
                      color: theme1,
                      fontSize: 15,
                      fontWeight: FontWeight.bold)),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.settings, color: theme1),
              title: Text("Settings",
                  style: TextStyle(
                      color: theme1,
                      fontWeight: FontWeight.bold,
                      fontSize: 15)),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app, color: theme1),
              title: Text("Signout",
                  style: TextStyle(
                      color: theme1,
                      fontSize: 15,
                      fontWeight: FontWeight.bold)),
              onTap: () async {
                await _googleSignIn.signOut().then((value) {
                  tagProvider.changeLogin();
                  if (tagProvider.getIsLoggedIn == false) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginPage(),
                        ));
                  }
                }).catchError((e) {});
              },
            )
          ],
        ),
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
            return SizedBox(
              height: constraints.maxHeight * 80,
              child: FlutterMap(
                mapController: tagProvider.getMapController,
                options: MapOptions(
                  center: LatLng(11.3263187, 75.9719164), // 11.605°N 76.083°E
                  zoom: 13,
                  onMapReady: tagProvider.getAllMarkers,
                ),
                children: [
                  TileLayer(
                    urlTemplate:
                        'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    userAgentPackageName: 'dev.fleaflet.flutter_map.example',
                  ),
                  CircleLayer(circles: tagProvider.getCircles),
                  MarkerLayer(markers: tagProvider.getMarkers),
                ],
              ),
            );
          }),
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Column(mainAxisAlignment: MainAxisAlignment.end, children: [
                  //widget to add new marker
                  Padding(
                    padding: const EdgeInsets.only(bottom: 18),
                    //widget definition
                    child: FloatingActionButton(
                      //function call on button press
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => AddDis(
                                      textEditingController:
                                          tagProvider.getTextEditingController,
                                    ))));
                      },
                      heroTag: "Add",
                      backgroundColor: Colors.white,
                      child: const Icon(
                        Icons.add,
                        size: 30,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 50),
                    child: Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: CurrentLocation(
                        mapController: tagProvider.getMapController,
                      ),
                    ),
                  ),
                ]),
              ],
            ),
          ),
          DraggableScrollableSheet(
              controller: tagProvider.getBottomSheetController,
              snap: true,
              maxChildSize: .80,
              initialChildSize: 0.05,
              minChildSize: 0.05,
              builder:
                  (BuildContext context, ScrollController scrollController) {
                return Container(
                  decoration: const BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 5, spreadRadius: .1, color: Colors.grey)
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20))),
                  child: ListView.builder(
                      controller: scrollController,
                      itemCount: 1,
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          children: [
                            Container(
                                height: 3,
                                width: 75,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: Colors.grey,
                                )),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(10, 35, 0, 10),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20),
                                    child: Text(
                                      tagProvider.getTagData.type,
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  //const Spacer(),
                                  const Padding(
                                    padding:
                                        EdgeInsets.only(right: 10, left: 30),
                                    child: Icon(
                                      Icons.verified,
                                      color: Colors.blue,
                                    ),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.only(right: 15),
                                    child: Text(
                                      "Verified",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 20),
                                    ),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.only(right: 20),
                                    child: Icon(Icons.edit),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 13),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        color: Colors.green,
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    height: 40,
                                    width: 150,
                                    child: InkWell(
                                      onTap: () {
                                        tagProvider.doUpVote();
                                      },
                                      child: Row(
                                        children: [
                                          const Padding(
                                            padding: EdgeInsets.only(left: 30),
                                            child: Icon(
                                              Icons.thumb_up,
                                              color: Colors.white,
                                              size: 20,
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 30),
                                            child: Text(
                                              tagProvider.getUpVotes.toString(),
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    height: 40,
                                    width: 150,
                                    child: InkWell(
                                      onTap: () {
                                        tagProvider.doDownVote();
                                      },
                                      child: Row(
                                        children: [
                                          const Padding(
                                            padding: EdgeInsets.only(left: 30),
                                            child: Icon(
                                              Icons.thumb_down,
                                              color: Colors.white,
                                              size: 20,
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 30),
                                            child: Text(
                                              tagProvider.getDownVotes
                                                  .toString(),
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(top: 20),
                              child: ListTile(
                                title: Text("John Smith",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20)),
                                leading: Icon(
                                  Icons.person_pin,
                                  size: 40,
                                ),
                                trailing: Text("45 minutes ago"),
                              ),
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 10, 15, 5),
                                  child: Text(tagProvider.getTagData.desc),
                                ),
                              ],
                            ),
                            const Padding(
                              padding: EdgeInsets.only(left: 20, right: 20),
                              child: TextField(
                                decoration: InputDecoration(
                                    labelText: "Comments",
                                    suffixIcon: Icon(Icons.done)),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(20),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Image.asset(
                                      "assets/images/1.png",
                                      height: 75,
                                      width: 75,
                                    ),
                                  ),
                                  Image.asset(
                                    "assets/images/2.png",
                                    height: 75,
                                    width: 75,
                                  ),
                                  const Padding(
                                      padding: EdgeInsets.all(20),
                                      child: Icon(
                                        Icons.add,
                                        size: 40,
                                      ))
                                ],
                              ),
                            ),
                          ],
                        );
                      }),
                );
              }),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 40, 15, 0),
            child: Container(
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        spreadRadius: .1,
                        blurRadius: 5,
                      )
                    ]),
                child: Row(children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: IconButton(
                      onPressed: () => scaffoldKey.currentState?.openDrawer(),
                      icon: const Icon(Icons.menu),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Text(
                      "Search",
                      style: TextStyle(fontSize: 17),
                    ),
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.person_pin,
                          size: 30,
                        )),
                  )
                ])),
          ),
        ],
      ),
    );
  }
}
